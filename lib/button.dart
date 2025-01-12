import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'DMstatic.dart';
import 'colors.dart';

class Button extends StatelessWidget {
  bool enabled;
  final String textbutton;
  Button({super.key, required this.enabled, required this.textbutton});

  @override
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;

    return Container(
      height: Hscreen * H54,
      margin: EdgeInsets.only(
          left: Wscreen * W20, right: Wscreen * W20, top: Hscreen * H70),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Hscreen * H50),
          gradient: LinearGradient(
            colors: ([AppColors.addpink, Color.fromARGB(255, 251, 68, 2)]),
          ),
          boxShadow: enabled
              ? []
              : [
                  BoxShadow(
                      offset: Offset(-(Wscreen * W6), -(Hscreen * H6)),
                      blurRadius: Hscreen * H5,
                      color: Colors.white,
                      spreadRadius: 1),
                  BoxShadow(
                      offset: Offset(Wscreen * W6, Hscreen * H6),
                      blurRadius: Hscreen * H5,
                      color: Colors.grey,
                      spreadRadius: 1),
                ]),
      child: Text(
        textbutton,
        style: GoogleFonts.inter(
            color: AppColors.textblue, fontSize: Hscreen * H19),
      ),
    );
  }
}
