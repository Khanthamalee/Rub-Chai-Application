import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../DMstatic.dart';
import '../../colors.dart';
import '../../database/financedata.dart';
import '../../font.dart';
import '../../gsheet_CRUD.dart';
import '../../gsheet_setup.dart';
import '../Provider/financeProvider.dart';
import '../addtopicpage.dart';

class AlertdialogAddTopic extends StatefulWidget {
  AlertdialogAddTopic({super.key});

  @override
  State<AlertdialogAddTopic> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AlertdialogAddTopic> {
  bool enabledbuttontopic = false;
  bool enabledX = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController topicController = TextEditingController();
  String? ID;
  final String _chars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
  Random _rnd = Random();
  List<Finance> finances = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //เรียก initdata ที่ FinanceProvider
    //Provider.of<FinanceProvider>(context, listen: false).initData();
  }

  UniqueIdGenerator() {
    Random random = new Random();
    int randomNumber = random.nextInt(10000000);
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    ID = '${randomNumber}${getRandomString(10)}';
  }

  Future insertFinance(Finance data) async {
    final finance = [data];
    final jsonFinance = finance.map((finance) => finance.toJson()).toList();
    await UserSheetApi.insert(jsonFinance);
    print("Data stored");
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
    //
    //List<Finance> _finances = widget.finance;
    return Consumer(
        builder: (BuildContext context, FinanceProvider provider, widget) {
      print("addtopicpage");

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
                            double amount = 0;
                            var note = "note";
                            //เตรียม Json ลง provider
                            UniqueIdGenerator();
                            print("ID : ${ID}");

                            Finance finance = Finance(
                              id: ID,
                              topic: topic,
                              date: DateTime.now().toString(),
                              timestamp: DateTime.now().toString(),
                              name: name,
                              income:
                                  type == "รายรับ" ? amount.toString() : "0",
                              expense:
                                  type == "รายจ่าย" ? amount.toString() : "0",
                              balance: amount.toString(),
                              note: note,
                            );

                            //call provider
                            await insertFinance(finance);
                            await getFinance();
                            setState(() {});

                            // Provider.of<FinanceProvider>(context, listen: false)
                            //     .returnlistTopic(finance);

                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddTopicPage(financeadd: finance)));
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
