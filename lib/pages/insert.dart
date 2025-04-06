import 'package:economate_mobile/constants/color_constant.dart';
import 'package:economate_mobile/widgets/dropdown_insert.dart';
import 'package:economate_mobile/widgets/textfield_insert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class Insert extends StatelessWidget{
  const Insert({super.key});

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
                Text('Pemasukan',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.birumuda,
                  ),
                ),

                const Gap(16),
                
                TextfieldInsert(isHint: 'Judul'),

                const Gap(24),

                DropdownInsert(isHint: 'Kategori'),
                

                // DropdownExample(),

              ],
            ),
          )
        ),
      ),
    );
  }
}

// class DropdownExample extends StatefulWidget {
//   @override
//   _DropdownExampleState createState() => _DropdownExampleState();
// }

// class _DropdownExampleState extends State<DropdownExample> {
//   String? selectedCategory = 'Kategori'; // Default text
//   final List<String> categories = ['Kategori', 'Uang saku', 'Gaji', 'Bisnis'];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           decoration: BoxDecoration(
//             color: ColorConstant.putih,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: ColorConstant.birushadow,
//                 spreadRadius: 1,
//                 blurRadius: 8,
//               ),
//             ],
//           ),
//           child: DropdownButton<String>(
//             value: selectedCategory,
//             isExpanded: true,
//             icon: SvgPicture.asset('assets/svgs/arrowsolid.svg'),
//             iconSize: 30,
//             style: GoogleFonts.plusJakartaSans(
//               fontSize: 20,
//               fontWeight: FontWeight.w400,
//               color: ColorConstant.abu
//             ),
//             underline: SizedBox(),
//             onChanged: (String? newValue) {
//               setState(() {
//                 selectedCategory = newValue;
//               });
//             },
//             items: categories.map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value),
//               );
//             }).toList(),
//             dropdownColor: ColorConstant.putih,
//           ),
//         ),
        
//       ],
//     );
//   }
// }