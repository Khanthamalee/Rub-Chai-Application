import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/database/financedata.dart';
import 'package:incomeandexpansesapp/font.dart';
import 'package:incomeandexpansesapp/main.dart';
import 'package:incomeandexpansesapp/page/Provider/financeProvider.dart';
import 'package:incomeandexpansesapp/page/homepage/graph/pie_chart.dart';
import 'package:incomeandexpansesapp/page/homepage/graph/linegraphscreen.dart';
import 'package:provider/provider.dart';

import '../homepagescreen.dart';

class HomePieChart extends StatefulWidget {
  List<Finance>? financeInTopic;
  String? topic;
  HomePieChart({
    super.key,
    required this.financeInTopic,
    required this.topic,
  });

  @override
  State<HomePieChart> createState() => _HomePieChartState();
}

class _HomePieChartState extends State<HomePieChart> {
  List typegraph = ["วัน", "สัปดาห์", "เดือน", "ปี"];
  int index_color = 0;
  bool enabled2 = false;
  bool enabled1 = false;
  List<Finance>? _financeInTopic;
  String? _topic;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _financeInTopic = widget.financeInTopic;
    _topic = widget.topic;
  }

  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    var _financeInTopic = widget.financeInTopic;
    var _topic = widget.topic;
    print("เข้ามาหน้า กราฟ Staticmoney ");
    print("_financeInTopic :${_financeInTopic} ");
    List _financeInTopics = [];

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
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: ([
                          AppColors.strongping,
                          AppColors.strongyellow
                        ]),
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Wscreen * W20),
                          bottomRight: Radius.circular(Wscreen * W20)),
                    ),
                    child: Container(
                        //color: Colors.black,
                        // margin: EdgeInsets.only(right: 0, left: Wscreen * W15),
                        width: Wscreen,
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: Hscreen * H10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  setState(() => enabled2 = true);
                                  await Future.delayed(
                                      Duration(milliseconds: 200));
                                  setState(() => enabled2 = false);
                                  await Future.delayed(
                                      Duration(milliseconds: 200));
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomepageScreen(
                                                topic: _topic,
                                                financeInTopic: _financeInTopic,
                                              )));
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
                                      color: enabled2
                                          ? Colors.grey
                                          : AppColors.addpink,
                                    ),
                                  ]),
                                ),
                              ),
                              SizedBox(width: Wscreen * W30),
                              Container(
                                margin: EdgeInsets.only(top: Hscreen * H15),
                                child: Text(
                                  "สถิติรายรับ-รายจ่าย",
                                  style: GoogleFonts.getFont(
                                    Fonttype.Mali,
                                    fontSize: Hscreen * H18,
                                    color: AppColors.textblue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: Wscreen * W45),
                              Container(
                                child: GestureDetector(
                                  onTap: () async {
                                    setState(() => enabled1 = true);
                                    await Future.delayed(
                                        Duration(milliseconds: 200));
                                    setState(() => enabled1 = false);
                                    await Future.delayed(
                                        Duration(milliseconds: 200));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Staticmoney(
                                                financeInTopic: _financeInTopic,
                                                topic: _topic)));
                                  },
                                  child: Center(
                                    child: Container(
                                      height: Hscreen * H45,
                                      width: Wscreen * W45,
                                      //color: Colors.white,
                                      decoration: BoxDecoration(
                                        color:
                                            enabled1 ? AppColors.border : null,
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/linegraph.png"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                      // color: Colors.amber,
                      margin: EdgeInsets.only(
                          left: Wscreen * W34,
                          right: Wscreen * W34,
                          top: Hscreen * H20,
                          bottom: Hscreen * H20),
                      height: Hscreen * H54,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ...List.generate(
                            4,
                            (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    index_color = index;
                                  });
                                },
                                child: Container(
                                  width: Wscreen * W70,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: index_color == index
                                            ? Colors.white
                                            : AppColors.addpink),
                                    borderRadius: BorderRadius.circular(
                                      Hscreen * H10,
                                    ),
                                    color: index_color == index
                                        ? AppColors.addpink
                                        : Colors.white,
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
                                        "${typegraph[index]}",
                                        style: GoogleFonts.getFont("Mali",
                                            color: index_color == index
                                                ? Colors.white
                                                : AppColors.textblue,
                                            fontWeight: FontWeight.w500,
                                            fontSize: Hscreen * H16),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      )),
                ),
                Expanded(
                  flex: 14,
                  child: Consumer(
                      builder: (context, FinanceProvider provider, widget) {
                    if (index_color == 0) {
                      for (var data in _financeInTopic!) {
                        var datetimeInDB =
                            "${data.date.toString().substring(0, 10)}";
                        //"${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}-${data.datetime.day.toString().padLeft(2, "0")}";
                        var datetimeDay =
                            "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}-${DateTime.now().day.toString().padLeft(2, "0")}";
                        if (datetimeInDB == datetimeDay) {
                          _financeInTopics.add(data);
                        }
                      }
                    } else if (index_color == 1) {
                      for (var data in _financeInTopic!) {
                        List dayinweek = [];
                        for (var i = 0; i <= 6; i++) {
                          var dodayEnd =
                              int.parse(DateTime.now().day.toString()) - i;
                          DateTime day = DateTime(DateTime.now().year,
                              DateTime.now().month, dodayEnd);
                          dayinweek.add(day);
                        }

                        var datetimeInDB =
                            "${data.date.toString().substring(0, 10)}";
                        //"${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}-${data.datetime.day.toString().padLeft(2, "0")}";

                        for (var day in dayinweek) {
                          var dayweekstring =
                              "${day.year}-${day.month.toString().padLeft(2, "0")}-${day.day.toString().padLeft(2, "0")}";

                          if (datetimeInDB == dayweekstring) {
                            _financeInTopics.add(data);
                          }
                        }
                      }
                    } else if (index_color == 2) {
                      for (var data in _financeInTopic!) {
                        var datetimeInDB =
                            "${data.date.toString().substring(0, 7)}";
                        //"${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}";
                        var datetimeMonth =
                            "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}";
                        if (datetimeInDB == datetimeMonth) {
                          _financeInTopics.add(data);
                        }
                      }
                    } else if (index_color == 3) {
                      for (var data in _financeInTopic!) {
                        var datetimeInDB =
                            "${data.date.toString().substring(0, 4)}";
                        var datetimeMonth = "${DateTime.now().year}";
                        if (datetimeInDB == datetimeMonth) {
                          _financeInTopics.add(data);
                        }
                      }
                    }
                    return _financeInTopics.isEmpty ||
                            _financeInTopics.length < 2
                        ? Center(
                            child: Container(
                                height: Hscreen * H200,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/empty-box.png"),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "ข้อมูลที่มีน้อยกว่า 2 ",
                                      style: GoogleFonts.getFont(Fonttype.Mali,
                                          fontSize: Hscreen * H16,
                                          color: AppColors.textblue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "ไม่สามารถวิเคราะห์กราฟได้จ้า",
                                      style: GoogleFonts.getFont(Fonttype.Mali,
                                          fontSize: Hscreen * H16,
                                          color: AppColors.textblue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                          )
                        : CustomScrollView(
                            clipBehavior: Clip.antiAlias,
                            slivers: [
                              SliverAppBar(
                                expandedHeight: Hscreen * H400,
                                backgroundColor: Colors.pink[100],
                                toolbarHeight: 0,
                                clipBehavior: Clip.hardEdge,
                                flexibleSpace: FlexibleSpaceBar(
                                  background: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: ([
                                          AppColors.bglevel1,
                                          AppColors.bglevel2
                                        ]),
                                      ),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft:
                                            Radius.circular(-Wscreen * W20),
                                        bottomRight:
                                            Radius.circular(-Wscreen * W20),
                                      ),
                                    ),
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                          //top: Hscreen * H5,
                                          right: Wscreen * W30,
                                          left: Wscreen * W30,
                                          bottom: Hscreen * H5,
                                        ),
                                        child: PieChart(
                                          financeInTopic: _financeInTopic!,
                                          index_color: index_color,
                                        )),
                                  ),
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    childCount: _financeInTopics.length,
                                    (BuildContext context, index) {
                                  Finance data = _financeInTopics[index];

                                  return Container(
                                    padding: EdgeInsets.only(
                                        //top: Hscreen * H5,
                                        right: Wscreen * W30,
                                        left: Wscreen * W30,
                                        bottom: Hscreen * H5,
                                        top: Hscreen * H10),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: Hscreen * H15),
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: Hscreen * H70,
                                              width: Wscreen * W70,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          Hscreen * H20),
                                                      topRight: Radius.circular(
                                                          Hscreen * H20),
                                                      bottomLeft: Radius.circular(
                                                          Hscreen * H20),
                                                      bottomRight:
                                                          Radius.circular(
                                                              Hscreen * H20)),
                                                  image: DecorationImage(
                                                      image: data.income != "0"
                                                          ? const AssetImage(
                                                              "assets/like.png")
                                                          : const AssetImage(
                                                              "assets/dislike.png"))),
                                            ),
                                            SizedBox(
                                              width: Wscreen * W5,
                                            ),
                                            Container(
                                              height: Hscreen * H70,
                                              width: Wscreen * W270,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          Hscreen * H20),
                                                      topRight: Radius.circular(
                                                          Hscreen * H20),
                                                      bottomLeft:
                                                          Radius.circular(
                                                              Hscreen * H30),
                                                      bottomRight:
                                                          Radius.circular(
                                                              Hscreen * H20)),
                                                  color: AppColors.boxpurple),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: Hscreen * H15,
                                                    left: Wscreen * W20,
                                                    right: Wscreen * W20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${data.date.toString().substring(0, 11)}",
                                                      // "${data.datetime!.year}/${data.datetime!.month}/${data.datetime!.day} เวลา ${data.datetime!.hour}:${data.datetime!.minute}",
                                                      // Text(
                                                      //   "${DateFormat.yMMMMd().format(datainput()[index].date!)} ${datainput()[index].time}",
                                                      style:
                                                          GoogleFonts.getFont(
                                                              "Mali",
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  Hscreen *
                                                                      H14),
                                                    ),
                                                    SizedBox(
                                                      height: Hscreen * H5,
                                                    ),
                                                    Text(
                                                      "${data.name} ${data.income != "0" ? data.income : data.expense} บาท",
                                                      style:
                                                          GoogleFonts.getFont(
                                                              Fonttype.Mali,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize:
                                                                  Hscreen *
                                                                      H14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
