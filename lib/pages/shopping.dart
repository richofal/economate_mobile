import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/pages/cart_shopping.dart';
import 'package:economate_mobile/widgets/list_shopping.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> shoppingLists = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchShoppingLists();
  }

  Future<void> _fetchShoppingLists() async {
  setState(() => isLoading = true);
  
  final userId = supabase.auth.currentUser?.id;
  if (userId == null) {
    setState(() => isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User not logged in')),
    );
    return;
  }

  try {
    final response = await supabase
        .from('shopping_lists')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    
    setState(() {
      shoppingLists = response as List<Map<String, dynamic>>;
      isLoading = false;
    });
  } catch (e) {
    setState(() => isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error fetching shopping lists: $e')),
    );
  }
}

  Future<void> _addNewShoppingList() async {
    final nameController = TextEditingController();
    final budgetController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New Shopping List', style: GoogleFonts.plusJakartaSans()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'List Name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: budgetController,
              decoration: InputDecoration(
                labelText: 'Initial Budget',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isEmpty || budgetController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }

              try {
                final budget = double.tryParse(budgetController.text) ?? 0;
                await supabase.from('shopping_lists').insert({
                  'user_id': supabase.auth.currentUser?.id,
                  'name': nameController.text,
                  'initial_budget': budget,
                });
                
                Navigator.pop(context);
                await _fetchShoppingLists();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error creating list: $e')),
                );
              }
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorConstant.putihbiru,
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Gap(45),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Shopping',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.birumuda,
                          ),
                        ),
                      ],
                    ),

                    const Gap(16),

                    if (isLoading)
                      const CircularProgressIndicator()
                    else ...[
                      ...shoppingLists.map((list) => ListShopping(
                        isName: list['name'],
                        isNominal: (list['initial_budget'] as num).toDouble(),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartShopping(
                              shoppingListId: list['id'],
                              initialBudget: (list['initial_budget'] as num).toDouble(),
                              listName: list['name'],
                            ),
                          ),
                        ),
                      )),
                    ],

                    const Gap(2),

                    GestureDetector(
                      onTap: _addNewShoppingList,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorConstant.birumuda,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.hitamshadow,
                              spreadRadius: 1,
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Tambah Aktivitas',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.putih,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 10,
                child: IconButton(
                  icon: SvgPicture.asset(
                    'assets/svgs/back.svg',
                    height: 30,
                    width: 30,
                    colorFilter: ColorFilter.mode(
                      ColorConstant.birumuda,
                      BlendMode.srcIn,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}