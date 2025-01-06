import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/font.dart';
import 'package:incomeandexpansesapp/page/Provider/financeProvider.dart';
import 'package:incomeandexpansesapp/page/homepagescreen.dart';
import 'package:incomeandexpansesapp/page/topicwidget/dialogtopic.dart';
import 'package:provider/provider.dart';

import '../gsheet_CRUD.dart';

class AddTopicPage extends StatefulWidget {
  const AddTopicPage({super.key});

  @override
  State<AddTopicPage> createState() => _AddTopicPageState();
}

class _AddTopicPageState extends State<AddTopicPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //เรียก initdata ที่ FinanceProvider
    Provider.of<FinanceProvider>(context, listen: false).initData();
    print("start");
  }

  bool enabledaddtopic = false;

  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;

    return Scaffold(body: Consumer(
        builder: (BuildContext context, FinanceProvider provider, widget) {
      bool enabledtopicshow = false;
      provider.returnlistTopic(provider.FinanceList, provider.dataFromGsheet);
      provider.FinanceList;
      provider.dataFromGsheet;
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
                                        return const AlertdialogAddTopic();
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
                              child: provider.FinanceList.isEmpty &&
                                      provider.dataFromGsheet.isEmpty
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

                                      child: GridView.count(
                                        scrollDirection: Axis.vertical,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 15,
                                        crossAxisCount: 3,
                                        children: List.generate(
                                            provider.setTopic.length, (index) {
                                          var topicsort = provider.setTopic
                                              .toList()
                                              .reversed;
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
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomepageScreen(
                                                                topicshow:
                                                                    topicshow)));
                                              },
                                              onLongPress: () async {
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            AppColors.bglevel1,
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
                                                                          FontWeight
                                                                              .w500)),
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
                                                                          FontWeight
                                                                              .w500)),
                                                              onPressed: () {
                                                                provider
                                                                    .daletedataTopic(
                                                                        topicshow);
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                AddTopicPage()));
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                        content: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left:
                                                                        Wscreen *
                                                                            W10,
                                                                    top: Hscreen *
                                                                        H10),
                                                            child: Text(
                                                              "บัญชี $topicshow",
                                                              style: GoogleFonts.getFont(
                                                                  Fonttype.Mali,
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
                                                      gradient: LinearGradient(
                                                        colors: ([
                                                          AppColors.topicadd1,
                                                          AppColors.topicadd2
                                                        ]),
                                                      ),
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              Hscreen * H50)),
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
                                                  child: Center(
                                                      child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: Hscreen * H20,
                                                        left: Wscreen * W20,
                                                        right: Wscreen * W20,
                                                        bottom: Hscreen * H20),
                                                    child: Text(
                                                      "${topicshow}",
                                                      style:
                                                          GoogleFonts.getFont(
                                                              Fonttype.Mali,
                                                              fontSize:
                                                                  Hscreen * H14,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ))),
                                            ),
                                          );
                                        }),
                                      ),
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

class AlertdialogAddTopic extends StatefulWidget {
  const AlertdialogAddTopic({super.key});

  @override
  State<AlertdialogAddTopic> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AlertdialogAddTopic> {
  final formKey = GlobalKey<FormState>();
  TextEditingController topicController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //เรียก initdata ที่ FinanceProvider
    Provider.of<FinanceProvider>(context, listen: false).initData();
  }

  bool enabledbuttontopic = false;
  bool enabledX = false;
  // final _chars = "AFbkdbkAFoklfksn6523552ccsfevcx254fgthgf51Asf]gd3e";
  // final Random _rnd = Random();
  // String? ID;
  // UniqueIdGenerator() async {
  //   Random random = await new Random();
  //   int randomNumber = await random.nextInt(100000);

  //   String getRandomString(int lenght) =>
  //       String.fromCharCodes(Iterable.generate(
  //           lenght, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  //   ID = await "${randomNumber}${getRandomString(10)}";
  // }

  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;

    return Consumer(
        builder: (BuildContext context, FinanceProvider provider, widget) {
      provider.returnlistTopic(provider.FinanceList, provider.dataFromGsheet);
      return SingleChildScrollView(
        child: Center(
          child: AlertDialog(
            content: Container(
              height: Hscreen * H300,
              width: Wscreen * W300,
              constraints: const BoxConstraints(),
              padding:
                  EdgeInsets.only(top: Hscreen * H10, bottom: Hscreen * H30),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.bglevel1, AppColors.bglevel2],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius:
                      BorderRadius.all(Radius.circular(Hscreen * H30))),
              child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      //ปุ่มกากบาท
                      GestureDetector(
                        onTap: () async {
                          setState(() => enabledX = true);
                          await Future.delayed(Duration(milliseconds: 200));
                          setState(() => enabledX = false);
                          await Future.delayed(Duration(milliseconds: 200));
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                right: Wscreen * W10, left: Wscreen * W250),
                            height: Hscreen * H30,
                            width: Wscreen * W30,
                            //color: Colors.white,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(Hscreen * H40)),
                                image: const DecorationImage(
                                  image: AssetImage("assets/remove.png"),
                                ),
                                boxShadow: enabledX
                                    ? []
                                    : [
                                        BoxShadow(
                                            offset: Offset(-(Wscreen * W2),
                                                -(Hscreen * H2)),
                                            blurRadius: Hscreen * H2,
                                            color: Colors.white,
                                            spreadRadius: 1),
                                        BoxShadow(
                                            offset: Offset(
                                                Wscreen * W2, Hscreen * H2),
                                            blurRadius: Hscreen * H2,
                                            color: Colors.grey,
                                            spreadRadius: 1),
                                      ]),
                          ),
                        ),
                      ),
                      //หัวข้อเพิ่มข้อมูล
                      Center(
                        child: Text(
                          "เพิ่มบัญชี",
                          style: GoogleFonts.getFont(Fonttype.Mali,
                              fontSize: Hscreen * H18,
                              color: AppColors.textgrey,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      //กล่องเพิ่มบัญชี
                      Container(
                          margin: EdgeInsets.only(
                              left: Wscreen * W20,
                              right: Wscreen * W20,
                              top: Hscreen * H20),
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
                                left: Wscreen * W15,
                                right: Wscreen * W5),
                            child: TextFormField(
                              controller: topicController,
                              validator: (str) {
                                if (str!.isEmpty) {
                                  return "กรุณาเพิ่มบัญชี";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              maxLines: 2,
                              cursorColor: AppColors.addpink,
                              decoration: InputDecoration(
                                  hintText: "บัญชี",
                                  hintStyle: GoogleFonts.getFont(Fonttype.Mali,
                                      fontSize: Hscreen * H16,
                                      color: AppColors.textblue,
                                      fontWeight: FontWeight.w400),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none),
                            ),
                          )),
                      //ปุ่มบันทึกข้อมูล
                      GestureDetector(
                        onTap: () async {
                          setState(() => enabledbuttontopic = true);
                          await Future.delayed(Duration(milliseconds: 200));
                          setState(() => enabledbuttontopic = false);
                          await Future.delayed(Duration(milliseconds: 200));

                          provider.returnlistTopic(
                              provider.FinanceList, provider.dataFromGsheet);

                          if (formKey.currentState!.validate() &&
                              provider.setTopic
                                      .contains(topicController.text) ==
                                  true) {
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: AppColors.bglevel1,
                                    title: Text("บัญชีนี้มีในระบบแล้ว"),
                                    content: Text("กรุณาใช้ชื่อบัญชีใหม่ค่ะ"),
                                  );
                                });
                          } else if (formKey.currentState!.validate() &&
                              provider.setTopic
                                      .contains(topicController.text) ==
                                  false) {
                            var topic = topicController.text;
                            var type = "รายรับ";
                            var name = "ชื่อรายการ";
                            double amount = 50;
                            var note = "note";
                            //เตรียม Json ลง provider
                            FinanceVariable data = FinanceVariable(
                                topic: topic,
                                datetime: DateTime.now(),
                                timeStamp: DateTime.now(),
                                type: type,
                                name: name,
                                amount: amount,
                                note: note);

                            //call provider
                            FinanceProvider provider =
                                Provider.of<FinanceProvider>(context,
                                    listen: false);
                            provider.addFinaceList(data);
                            InsertDataIntoGSheet([
                              {
                                "Topic": topic,
                                "Date": DateTime.now().toString(),
                                "Timestamp": DateTime.now().toString(),
                                "Name": name,
                                "Income": type == "รายรับ" ? amount : "",
                                "Expense": type == "รายจ่าย" ? amount : "",
                                "Balance": "",
                                "Note": note,
                              }
                            ]);

                            //Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddTopicPage()));
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Wscreen * W50,
                              right: Wscreen * W50,
                              top: Hscreen * H30),
                          padding: EdgeInsets.only(
                            left: Wscreen * W30,
                            right: Wscreen * W30,
                          ),
                          height: Hscreen * H50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(
                              Hscreen * H20,
                            ),
                            color: enabledbuttontopic
                                ? Colors.grey
                                : AppColors.addpink,
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
                                "บันทึก",
                                style: GoogleFonts.getFont("Mali",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Hscreen * H18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            contentPadding: const EdgeInsets.all(0.0),
          ),
        ),
      );
    });
  }
}
