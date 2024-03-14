import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/font.dart';
import 'package:incomeandexpansesapp/page/Provider/financeProvider.dart';
import 'package:incomeandexpansesapp/page/homepagescreen.dart';
import 'package:incomeandexpansesapp/page/makegraph.dart';
import 'package:provider/provider.dart';

class Staticmoney extends StatefulWidget {
  const Staticmoney({super.key});

  @override
  State<Staticmoney> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<Staticmoney> {
  List typegraph = ["วัน", "สัปดาห์", "เดือน", "ปี"];
  int index_color = 0;
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
                        margin: EdgeInsets.only(
                            right: Wscreen * W20, left: Wscreen * W30),
                        width: Wscreen,
                        child: Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: Hscreen * H10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
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
                              SizedBox(width: Wscreen * W50),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomepageScreen()));
                                },
                                child: Center(
                                  child: Container(
                                    height: Hscreen * H40,
                                    width: Wscreen * W50,
                                    //color: Colors.white,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/home.png"),
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

                          // Container(
                          //   width: Wscreen * W70,
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.white),
                          //     borderRadius: BorderRadius.circular(
                          //       Hscreen * H20,
                          //     ),
                          //     color: AppColors.addpink,
                          //   ),
                          //   alignment: Alignment.center,
                          //   child: Padding(
                          //     padding: EdgeInsets.only(
                          //         top: Hscreen * H5,
                          //         bottom: Hscreen * H5,
                          //         left: Wscreen * W5,
                          //         right: Wscreen * W5),
                          //     child: Center(
                          //       child: Text(
                          //         "สัปดาห์",
                          //         style: GoogleFonts.getFont("Mali",
                          //             color: Colors.white,
                          //             fontWeight: FontWeight.w500,
                          //             fontSize: Hscreen * H16),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   width: Wscreen * W70,
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.white),
                          //     borderRadius: BorderRadius.circular(
                          //       Hscreen * H20,
                          //     ),
                          //     color: AppColors.addpink,
                          //   ),
                          //   alignment: Alignment.center,
                          //   child: Padding(
                          //     padding: EdgeInsets.only(
                          //         top: Hscreen * H5,
                          //         bottom: Hscreen * H5,
                          //         left: Wscreen * W5,
                          //         right: Wscreen * W5),
                          //     child: Center(
                          //       child: Text(
                          //         "เดือน",
                          //         style: GoogleFonts.getFont("Mali",
                          //             color: Colors.white,
                          //             fontWeight: FontWeight.w500,
                          //             fontSize: Hscreen * H16),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // Container(
                          //   width: Wscreen * W70,
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.white),
                          //     borderRadius: BorderRadius.circular(
                          //       Hscreen * H20,
                          //     ),
                          //     color: AppColors.addpink,
                          //   ),
                          //   alignment: Alignment.center,
                          //   child: Padding(
                          //     padding: EdgeInsets.only(
                          //         top: Hscreen * H5,
                          //         bottom: Hscreen * H5,
                          //         left: Wscreen * W5,
                          //         right: Wscreen * W5),
                          //     child: Center(
                          //       child: Text(
                          //         "ปี",
                          //         style: GoogleFonts.getFont("Mali",
                          //             color: Colors.white,
                          //             fontWeight: FontWeight.w500,
                          //             fontSize: Hscreen * H16),
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      )),
                ),
                Expanded(
                  flex: 14,
                  child: Consumer(
                      builder: (context, FinanceProvider provider, widget) {
                    return provider.FinanceList.isEmpty
                        ? Center(
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
                                      child: Graph(),
                                    ),
                                  ),
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    childCount: provider.FinanceList.length,
                                    (BuildContext context, index) {
                                  FinanceVariable data =
                                      provider.FinanceList[index];
                                  print(provider.FinanceList.length);
                                  // print(
                                  //     "${DateFormat.yMMMMd().format(datainput()[index].date!)} ${datainput()[index].time}");
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
