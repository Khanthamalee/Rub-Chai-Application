import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/font.dart';
import 'package:incomeandexpansesapp/page/addtopicpage.dart';
import 'package:incomeandexpansesapp/page/homepagescreen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: ([AppColors.bglevel1, AppColors.bglevel2]))),
        ),
        Container(
            child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: Wscreen * W30,
                      right: Wscreen * W30,
                    ),
                    height: Hscreen * H300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/star.png"))),
                  ),
                  Center(
                    child: Text(
                      "บันทึกรายรับ-รายจ่าย",
                      style: GoogleFonts.getFont("Mali",
                          color: AppColors.textgrey,
                          fontWeight: FontWeight.bold,
                          fontSize: Hscreen * H25),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: ([
                            AppColors.strongping,
                            AppColors.strongyellow
                          ]),
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Hscreen * H30),
                            topRight: Radius.circular(Hscreen * H30))),
                    child: Container(
                      height: Hscreen * H532,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: Wscreen * W60,
                                right: Wscreen * W60,
                                top: Hscreen * H100),
                            padding: EdgeInsets.only(
                              left: Wscreen * W30,
                              right: Wscreen * W50,
                            ),
                            height: Hscreen * H60,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(
                                Hscreen * H20,
                              ),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: Hscreen * H5,
                                  bottom: Hscreen * H5,
                                  left: Wscreen * W5,
                                  right: Wscreen * W5),
                              child: TextField(
                                obscureText: true,
                                cursorColor: AppColors.addpink,
                                decoration: InputDecoration(
                                    hintText: "นามแฝง",
                                    hintStyle: GoogleFonts.getFont(
                                        Fonttype.Mali,
                                        fontSize: Hscreen * H18,
                                        color: AppColors.textblue,
                                        fontWeight: FontWeight.w700),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: Wscreen * W60,
                                right: Wscreen * W60,
                                top: Hscreen * H30),
                            padding: EdgeInsets.only(
                              left: Wscreen * W30,
                              right: Wscreen * W50,
                            ),
                            height: Hscreen * H60,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.border),
                              borderRadius: BorderRadius.circular(
                                Hscreen * H20,
                              ),
                              color: Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: Hscreen * H5,
                                  bottom: Hscreen * H5,
                                  left: Wscreen * W5,
                                  right: Wscreen * W5),
                              child: TextField(
                                obscureText: true,
                                cursorColor: AppColors.addpink,
                                decoration: InputDecoration(
                                    hintText: "รหัสผ่าน",
                                    hintStyle: GoogleFonts.getFont(
                                        Fonttype.Mali,
                                        fontSize: Hscreen * H18,
                                        color: AppColors.textblue,
                                        fontWeight: FontWeight.w700),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddTopicPage()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: Wscreen * W120,
                                  right: Wscreen * W120,
                                  top: Hscreen * H30),
                              padding: EdgeInsets.only(
                                left: Wscreen * W30,
                                right: Wscreen * W30,
                              ),
                              height: Hscreen * H54,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(
                                  Hscreen * H20,
                                ),
                                color: AppColors.addpink,
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: Hscreen * H5,
                                    bottom: Hscreen * H5,
                                    left: Wscreen * W5,
                                    right: Wscreen * W5),
                                child: Center(
                                  child: Text(
                                    "เข้าสู่ระบบ",
                                    style: GoogleFonts.getFont("Mali",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Hscreen * H18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: Wscreen * W130,
                                right: Wscreen * W20,
                                top: Hscreen * H15),
                            height: 110,
                            width: 240,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/butterfly.png"),
                                    fit: BoxFit.cover)),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          ],
        ))
      ],
    ));
  }
}
