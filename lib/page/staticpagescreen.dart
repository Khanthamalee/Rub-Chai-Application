import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/font.dart';
import 'package:incomeandexpansesapp/page/Provider/financeProvider.dart';
import 'package:incomeandexpansesapp/page/homepagescreen.dart';
import 'package:incomeandexpansesapp/page/homepiegraph.dart';
import 'package:incomeandexpansesapp/page/makegraph.dart';
import 'package:incomeandexpansesapp/page/pie_chart.dart';
import 'package:provider/provider.dart';

class Staticmoney extends StatefulWidget {
  List result;
  String? topic;
  Staticmoney({
    super.key,
    required this.result,
    required this.topic,
  });

  @override
  State<Staticmoney> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<Staticmoney> {
  List typegraph = ["วัน", "สัปดาห์", "เดือน", "ปี"];
  int index_color = 0;
  bool enabled2 = false;
  bool enabled1 = false;

  @override
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    var _result = widget.result;
    var _topic = widget.topic;

    print("เข้ามาหน้า กราฟ Staticmoney ");
    print("_result :$_result ");
    List results = [];

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
                                  //Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomepageScreen(
                                                topicshow: _topic,
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
                              GestureDetector(
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
                                          builder: (context) => HomePieChart(
                                              result: _result, topic: _topic)));
                                },
                                child: Center(
                                  child: Container(
                                    height: Hscreen * H45,
                                    width: Wscreen * W45,
                                    //color: Colors.white,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(Hscreen * H50)),
                                      color: enabled1 ? AppColors.border : null,
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/pngwing.com.png"),
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
                                            fontSize: Hscreen * H12),
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
                      for (var data in _result) {
                        var datetimeInDB =
                            "${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}-${data.datetime.day.toString().padLeft(2, "0")}";
                        var datetimeDay =
                            "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}-${DateTime.now().day.toString().padLeft(2, "0")}";
                        if (datetimeInDB == datetimeDay) {
                          results.add(data);
                          print("result.lenght : ${results.length}");
                        }
                      }
                    } else if (index_color == 1) {
                      for (var data in _result) {
                        List dayinweek = [];
                        for (var i = 0; i <= 6; i++) {
                          var dodayEnd =
                              int.parse(DateTime.now().day.toString()) - i;
                          DateTime day = DateTime(DateTime.now().year,
                              DateTime.now().month, dodayEnd);
                          dayinweek.add(day);
                        }

                        var datetimeInDB =
                            "${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}-${data.datetime.day.toString().padLeft(2, "0")}";

                        for (var day in dayinweek) {
                          var dayweekstring =
                              "${day.year}-${day.month.toString().padLeft(2, "0")}-${day.day.toString().padLeft(2, "0")}";

                          if (datetimeInDB == dayweekstring) {
                            results.add(data);
                            print(dayweekstring);
                            print("results.lenght : ${results.length}");
                          }
                        }
                      }
                    } else if (index_color == 2) {
                      for (var data in _result) {
                        var datetimeInDB =
                            "${data.datetime.year}-${data.datetime.month.toString().padLeft(2, "0")}";
                        var datetimeMonth =
                            "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, "0")}";
                        if (datetimeInDB == datetimeMonth) {
                          results.add(data);
                          print("results.lenght : ${results.length}");
                        }
                      }
                    } else if (index_color == 3) {
                      for (var data in _result) {
                        var datetimeInDB = "${data.datetime.year}";
                        var datetimeMonth = "${DateTime.now().year}";
                        if (datetimeInDB == datetimeMonth) {
                          results.add(data);
                          print("results.lenght : ${results.length}");
                        }
                      }
                    }
                    return results.isEmpty || results.length < 2
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
                                      child: Graph(
                                        result: _result,
                                        index_color: index_color,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    childCount: results.length,
                                    (BuildContext context, index) {
                                  FinanceVariable data = results[index];

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
                                                      image: data.type == "รายรับ"
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
                                                      "${data.datetime!.year}/${data.datetime!.month}/${data.datetime!.day} เวลา ${data.datetime!.hour}:${data.datetime!.minute}",
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
                                                      "${data.name} ${data.amount} บาท",
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
