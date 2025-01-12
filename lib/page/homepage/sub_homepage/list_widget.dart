import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/font.dart';

class NoList extends StatelessWidget {
  const NoList({super.key});

  @override
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
          height: Hscreen * H200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/empty-box.png"),
            ),
          ),
          child: Text(
            "ยังไม่มีการบันทึกข้อมูลจ้า",
            style: GoogleFonts.getFont(Fonttype.Mali,
                fontSize: Hscreen * H16,
                color: AppColors.textblue,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}

class AddbuttonList extends StatelessWidget {
  bool enabled = false;
  AddbuttonList({super.key, required this.enabled});

  @override
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    return Container(
      child: Stack(children: [
        Icon(
          Icons.circle,
          size: Hscreen * H80,
          color: Colors.white,
        ),
        Icon(
          Icons.arrow_circle_left,
          size: Hscreen * H80,
          color: enabled ? Colors.grey : AppColors.addpink,
        ),
      ]),
    );
  }
}
