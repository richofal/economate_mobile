import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/list_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartShopping extends StatefulWidget {
  final String shoppingListId;
  final double initialBudget;
  final String listName;

  const CartShopping({
    super.key,
    required this.shoppingListId,
    required this.initialBudget,
    required this.listName,
  });

  @override
  State<CartShopping> createState() => _CartShoppingState();
}

class _CartShoppingState extends State<CartShopping> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> items = [];
  bool isLoading = true;
  double totalSpent = 0;

  @override
  void initState() {
    super.initState();
    _fetchItems();
  }

  Future<void> _fetchItems() async {
    setState(() => isLoading = true);
    try {
      final response = await supabase
          .from('shopping_items')
          .select()
          .eq('shopping_list_id', widget.shoppingListId)
          .order('created_at', ascending: true);
      
      double total = 0;
      for (var item in response) {
        total += (item['price'] as num).toDouble() * (item['quantity'] as num).toDouble();
      }

      setState(() {
        items = response as List<Map<String, dynamic>>;
        totalSpent = total;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching items: $e')),
      );
    }
  }

  Future<void> _addNewItem() async {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final quantityController = TextEditingController(text: '1');

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Item', style: GoogleFonts.plusJakartaSans()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Item Name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
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
              if (nameController.text.isEmpty || 
                  priceController.text.isEmpty || 
                  quantityController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please fill all fields')),
                );
                return;
              }

              try {
                final price = double.tryParse(priceController.text) ?? 0;
                final quantity = int.tryParse(quantityController.text) ?? 1;
                
                await supabase.from('shopping_items').insert({
                  'shopping_list_id': widget.shoppingListId,
                  'name': nameController.text,
                  'price': price,
                  'quantity': quantity,
                });
                
                Navigator.pop(context);
                await _fetchItems();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error adding item: $e')),
                );
              }
            },
            child: Text('Add'),
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.listName,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: ColorConstant.hitam,
                      ),
                    ),
                  ],
                ),
                const Gap(16),
                Container(
                  height: 90,
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Modal',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: ColorConstant.putih,
                          ),
                        ),
                        SizedBox(
                          width: 320,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rp',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstant.putih,
                                ),
                              ),
                              const Gap(2),
                              Text(
                                NumberFormat('#,###').format(widget.initialBudget),
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  color: ColorConstant.putih,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(8),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConstant.putih,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.hitamshadow,
                          spreadRadius: 1,
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tambahkan item',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.birumuda,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: _addNewItem,
                                      child: Container(
                                        height: 28,
                                        width: 28,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: ColorConstant.birumuda,
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/svgs/add.svg',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(12),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      final item = items[index];
                                      return ListCart(
                                        isName: item['name'],
                                        isQuantity: (item['quantity'] as num).toDouble(),
                                        isPrice: (item['price'] as num).toDouble(),
                                      );
                                    },
                                  ),
                                ),
                                Divider(color: ColorConstant.birumuda, thickness: 2),
                                const Gap(8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Total',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: ColorConstant.hitam,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Rp',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstant.hitam,
                                            ),
                                          ),
                                          const Gap(2),
                                          Text(
                                            NumberFormat('#,###').format(totalSpent),
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                              color: ColorConstant.hitam,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                const Gap(8),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
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
                        'Selesai',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorConstant.putih,
                        ),
                      ),
                    ),
                  ),
                ),
                const Gap(12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}