import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/font.dart';

class FindAllStory extends StatelessWidget {
  const FindAllStory({super.key});

  @override
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    return Container(
      height: Hscreen * H40,
      width: Wscreen * W130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(Hscreen * H10)),
        border: Border.all(color: AppColors.addpink),
      ),
      child: Center(
        child: Text(
          "ประวัติทั้งหมด",
          style: GoogleFonts.getFont(Fonttype.Mali,
              color: AppColors.textgrey,
              fontWeight: FontWeight.bold,
              fontSize: Hscreen * H14),
        ),
      ),
    );
  }
}

class FindselectedStory extends StatelessWidget {
  const FindselectedStory({super.key});

  @override
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          height: Hscreen * H30,
          width: Wscreen * W30,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/search.png"), fit: BoxFit.fill),
          ),
        ),
        SizedBox(width: Wscreen * W10),
        Text(
          "ค้นหาวันที่",
          style: GoogleFonts.getFont(Fonttype.Mali,
              color: AppColors.textgrey,
              fontWeight: FontWeight.bold,
              fontSize: Hscreen * H14),
        ),
      ],
    );
  }
}
