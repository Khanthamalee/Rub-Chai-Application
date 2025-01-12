import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/database/financedata.dart';
import 'package:incomeandexpansesapp/font.dart';
import 'package:incomeandexpansesapp/page/addtopicpage.dart';
import '../../../colors.dart';
import '../graph/linegraphscreen.dart';

class TabbarHomepage extends StatefulWidget {
  String topic;
  List<Finance>? dataToGraph;
  TabbarHomepage({super.key, required this.topic, required this.dataToGraph});

  @override
  State<TabbarHomepage> createState() => _TabbarHomepageState();
}

class _TabbarHomepageState extends State<TabbarHomepage> {
  String? _topic;
  List<Finance>? _dataToGraph;
  bool enabled3 = false;
  bool enabled4 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _topic = widget.topic;
    _dataToGraph = widget.dataToGraph;
  }

  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: ([AppColors.strongping, AppColors.strongyellow]),
        ),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Wscreen * W20),
            bottomRight: Radius.circular(Wscreen * W20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: Hscreen * H10,
          right: Wscreen * W10,
          left: Wscreen * W10,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          GestureDetector(
            onTap: () async {
              setState(() => enabled3 = true);
              await Future.delayed(Duration(milliseconds: 200));
              setState(() => enabled3 = false);
              await Future.delayed(Duration(milliseconds: 200));
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddTopicPage()));
            },
            child: Container(
              child: Stack(children: [
                Icon(
                  Icons.circle,
                  size: Hscreen * H70,
                  color: Colors.white,
                ),
                Icon(
                  Icons.arrow_circle_left,
                  size: Hscreen * H70,
                  color: enabled3 ? Colors.grey : AppColors.addpink,
                ),
              ]),
            ),
          ),
          SizedBox(width: Wscreen * W10),
          Container(
            width: Wscreen * W230,
            margin: EdgeInsets.only(top: Hscreen * H15),
            child: Center(
              child: Text(
                "$_topic",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.getFont(
                  Fonttype.Mali,
                  fontSize: Hscreen * H20,
                  color: AppColors.textblue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: Wscreen * W10),
          GestureDetector(
            onTap: () async {
              setState(() => enabled4 = true);
              await Future.delayed(Duration(milliseconds: 200));
              setState(() => enabled4 = false);
              await Future.delayed(Duration(milliseconds: 200));

              if (_dataToGraph!.length < 2) {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: AppColors.bglevel1,
                        content: Container(
                            child: Text(
                                "รายการมีน้อยกว่า 2 ไม่สามารถวิเคราะห์กราฟได้ค่ะ",
                                style: GoogleFonts.getFont(Fonttype.Mali,
                                    fontSize: Hscreen * H16,
                                    color: AppColors.textgrey,
                                    fontWeight: FontWeight.w500))),
                      );
                    });
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Staticmoney(
                              financeInTopic: _dataToGraph,
                              topic: _topic,
                            )));
              }
            },
            child: Center(
              child: Container(
                height: Hscreen * H50,
                width: Wscreen * W50,
                //color: Colors.white,
                decoration: BoxDecoration(
                  color: enabled4 ? AppColors.border : null,
                  image: const DecorationImage(
                    image: AssetImage("assets/chartline.png"),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
