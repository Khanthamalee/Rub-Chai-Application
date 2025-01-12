import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/database/financedata.dart';
import 'package:incomeandexpansesapp/font.dart';
import 'package:incomeandexpansesapp/page/Provider/financeProvider.dart';
import 'package:incomeandexpansesapp/page/topicwidget/dialogtopic.dart';
import 'package:provider/provider.dart';
import '../gsheet_setup.dart';
import 'homepage/homepagescreen.dart';
import 'topicwidget/alertdialog.dart';

class AddTopicPage extends StatefulWidget {
  Finance? financeadd;
  AddTopicPage({super.key, this.financeadd});

  @override
  State<AddTopicPage> createState() => _AddTopicPageState();
}

class _AddTopicPageState extends State<AddTopicPage> {
  bool enabledaddtopic = false;
  List<Finance> finances = [];
  Finance? _financeadd;

  @override
  initState() {
    super.initState();
    getFinance();
    //_financeadd = widget.financeadd;
  }

  //ReadData
  Future getFinance() async {
    final allfinances = await UserSheetApi.getAll();
    arrange(allfinances);
    Provider.of<FinanceProvider>(context, listen: false)
        .returnlistTopic(finances);
    print("finances in initState : ${finances.length}");

    setState(() {
      this.finances = finances;
    });
  }

  List<Finance> arrange(List<Finance> financeInTopic) {
    for (var data in financeInTopic) {
      finances.insert(0, data);
    }
    //print("finances : ${finances[0].date}");
    return finances;
  }

  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;

    _financeadd != null ? finances.insert(0, _financeadd!) : finances;
    return Scaffold(body: Consumer(
        builder: (BuildContext context, FinanceProvider provider, widget) {
      bool enabledtopicshow = false;
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: ([AppColors.bglevel1, AppColors.bglevel2]))),
          ),
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: Wscreen * W30,
                        right: Wscreen * W30,
                      ),
                      height: Hscreen * H300,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/star.png"))),
                    ),
                    Center(
                      child: Text(
                        "รายการบัญชีทั้งหมด",
                        style: GoogleFonts.getFont("Mali",
                            color: AppColors.textgrey,
                            fontWeight: FontWeight.bold,
                            fontSize: Hscreen * H20),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Container(
                      height: Hscreen * H685,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: ([
                              AppColors.strongping,
                              AppColors.strongyellow
                            ]),
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Hscreen * H50),
                              topRight: Radius.circular(Hscreen * H50))),
                      child: Container(
                        margin: EdgeInsets.only(
                            right: Wscreen * W10,
                            top: Hscreen * H10,
                            left: Wscreen * W10),
                        //height: Hscreen * H650,
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () async {
                                  setState(() => enabledaddtopic = true);
                                  await Future.delayed(
                                      const Duration(milliseconds: 200));
                                  setState(() => enabledaddtopic = false);
                                  await Future.delayed(
                                      const Duration(milliseconds: 200));
                                  provider.FinanceList;
                                  provider.dataFromGsheet;
                                  showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertdialogAddTopic();
                                      });
                                },
                                child: SizedBox(
                                  height: Hscreen * H100,
                                  child: Stack(children: [
                                    Icon(
                                      Icons.circle,
                                      size: Hscreen * H80,
                                      color: Colors.white,
                                    ),
                                    Icon(
                                      Icons.add_circle,
                                      size: Hscreen * H80,
                                      color: enabledaddtopic
                                          ? AppColors.textgrey
                                          : AppColors.topicadd1,
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: finances.isEmpty
                                  ? Center(
                                      child: Container(
                                          height: Hscreen * H200,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/empty-box.png"),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "ยังไม่มีบัญชีค่ะ ",
                                                style: GoogleFonts.getFont(
                                                    Fonttype.Mali,
                                                    fontSize: Hscreen * H16,
                                                    color: AppColors.textblue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "กด + เพิ่มบัญชีจ้า",
                                                style: GoogleFonts.getFont(
                                                    Fonttype.Mali,
                                                    fontSize: Hscreen * H16,
                                                    color: AppColors.textblue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(
                                        left: Wscreen * W5,
                                        right: Wscreen * W5,
                                        bottom: Hscreen * H15,
                                      ),
                                      height: double.maxFinite,
                                      width: double.maxFinite,

                                      // decoration:
                                      //     BoxDecoration(color: AppColors.income),

                                      child: ListView.builder(
                                          itemCount: provider.setTopic.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var topicsort =
                                                provider.setTopic.toList();
                                            var topicshow = topicsort
                                                .toList()[index]
                                                .toString();
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  left: Wscreen * W3,
                                                  right: Wscreen * W3,
                                                  bottom: Hscreen * H2,
                                                  top: Hscreen * H2),
                                              child: GestureDetector(
                                                onTap: () {
                                                  List<Finance> dataInTopic =
                                                      [];
                                                  for (var f in finances) {
                                                    if (f.topic == topicshow) {
                                                      dataInTopic.add(f);
                                                      dataInTopic.reversed;
                                                    }
                                                  }
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomepageScreen(
                                                                topic:
                                                                    topicshow,
                                                                financeInTopic:
                                                                    dataInTopic,
                                                              )));
                                                },
                                                onLongPress: () async {
                                                  showDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              AppColors
                                                                  .bglevel1,
                                                          actions: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .income,
                                                                  borderRadius: BorderRadius.all(
                                                                      Radius.circular(
                                                                          Hscreen *
                                                                              H20))),
                                                              child: TextButton(
                                                                child: Text(
                                                                    "แก้ไขบัญชี",
                                                                    style: GoogleFonts.getFont(
                                                                        Fonttype
                                                                            .Mali,
                                                                        fontSize:
                                                                            Hscreen *
                                                                                H14,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                                onPressed: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      barrierDismissible:
                                                                          true,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return UpdateTopic(
                                                                            topic:
                                                                                topicshow);
                                                                      });
                                                                  // Navigator.push(
                                                                  //     context,
                                                                  //     MaterialPageRoute(
                                                                  //         builder:
                                                                  //             (context) =>
                                                                  //                 UpdateTopic(topic: topicshow)));
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  color: AppColors
                                                                      .expenses,
                                                                  borderRadius: BorderRadius.all(
                                                                      Radius.circular(
                                                                          Hscreen *
                                                                              H20))),
                                                              child: TextButton(
                                                                child: Text(
                                                                    "ลบบัญชี",
                                                                    style: GoogleFonts.getFont(
                                                                        Fonttype
                                                                            .Mali,
                                                                        fontSize:
                                                                            Hscreen *
                                                                                H14,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                                onPressed: () {
                                                                  // provider
                                                                  //     .daletedataTopic(
                                                                  //         topicshow);
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              AddTopicPage()));
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                          content: Container(
                                                              margin: EdgeInsets.only(
                                                                  left:
                                                                      Wscreen *
                                                                          W10,
                                                                  top: Hscreen *
                                                                      H10),
                                                              child: Text(
                                                                "บัญชี $topicshow",
                                                                style: GoogleFonts.getFont(
                                                                    Fonttype
                                                                        .Mali,
                                                                    fontSize:
                                                                        Hscreen *
                                                                            H20,
                                                                    color: AppColors
                                                                        .textgrey,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                        );
                                                      });
                                                },
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                        //color: AppColors.textblue,
                                                        gradient:
                                                            LinearGradient(
                                                          colors: ([
                                                            AppColors.topicadd1,
                                                            AppColors.topicadd2
                                                          ]),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    Hscreen *
                                                                        H10)),
                                                        boxShadow:
                                                            enabledtopicshow
                                                                ? []
                                                                : [
                                                                    BoxShadow(
                                                                        offset: Offset(
                                                                            (Wscreen *
                                                                                W2),
                                                                            (Hscreen *
                                                                                H2)),
                                                                        blurRadius:
                                                                            Hscreen *
                                                                                H2,
                                                                        color: Colors
                                                                            .white,
                                                                        spreadRadius:
                                                                            1),
                                                                  ]),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: Hscreen * H20,
                                                          left: Wscreen * W20,
                                                          right: Wscreen * W20,
                                                          bottom:
                                                              Hscreen * H20),
                                                      child: Text(
                                                        "${topicshow}",
                                                        style:
                                                            GoogleFonts.getFont(
                                                                Fonttype.Mali,
                                                                fontSize:
                                                                    Hscreen *
                                                                        H18,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                        maxLines: 2,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    )),
                                              ),
                                            );
                                          }),
                                    ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ],
      );
    }));
  }
}
