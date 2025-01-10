import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/font.dart';
import 'package:incomeandexpansesapp/page/Provider/financeProvider.dart';
import 'package:incomeandexpansesapp/page/addtopicpage.dart';
import 'package:provider/provider.dart';

import '../../gsheet_CRUD.dart';

class UpdateTopic extends StatefulWidget {
  String? topic;
  UpdateTopic({super.key, required this.topic});

  @override
  State<UpdateTopic> createState() => _UpdateTopicState();
}

class _UpdateTopicState extends State<UpdateTopic> {
  @override
  final formKey = GlobalKey<FormState>();
  TextEditingController topicController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //เรียก initdata ที่ FinanceProvider
    //Provider.of<FinanceProvider>(context, listen: false).initData();
  }

  bool enabledbuttontopic = false;
  bool enabledX = false;
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    var _topic = widget.topic;
    return Consumer(
        builder: (BuildContext context, FinanceProvider provider, widget) {
      provider.getdatafromGsheet();
      List<String> idchangetopic = [];
      List<dynamic> listdata = [];
      for (var data in provider.datafromGsheet) {
        if (data.topic == _topic) {
          var idchange = data.id;
          idchangetopic.add(idchange!);
          listdata.add(data);
        }
      }
      print(provider.getdatafromGsheet());
      print("listdata $listdata");

      return Center(
        child: AlertDialog(
          content: Container(
            height: Hscreen * H320,
            width: Wscreen * W300,
            constraints: const BoxConstraints(),
            padding: EdgeInsets.only(top: Hscreen * H10, bottom: Hscreen * H30),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppColors.bglevel1, AppColors.bglevel2],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.all(Radius.circular(Hscreen * H30))),
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
                              top: Hscreen * H10,
                              right: Wscreen * W10,
                              left: Wscreen * W250),
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
                                          offset: Offset(
                                              -(Wscreen * W2), -(Hscreen * H2)),
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
                        "แก้ไขชื่อบัญชี",
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
                                labelText: "เปลี่ยนชื่อบัญชี ${_topic} เป็น",
                                //hintText: "${_topic}",
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
                        setState(() {
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
                            //call provider
                            FinanceProvider provider =
                                Provider.of<FinanceProvider>(context,
                                    listen: false);

                            for (var d in listdata) {
                              print("i : ${d.id}");
                              // if (i == provider.FinanceList)
                              //เตรียม Json ลง provider
                              finance data = finance(
                                id: d.id,
                                topic: topicController.text,
                                date: d.date,
                                timestamp: d.timestamp,
                                name: d.name,
                                income: d.income,
                                expense: d.expense,
                                balance: d.balance,
                                note: d.note,
                              );

                              print(
                                  "id = ${d.id} , topic = ${topicController.text}");

                              provider.UpdateTopic(d.id, data);

                              provider.setTopic.add(topicController.text);
                              provider.setTopic.remove(d.topic);
                              print("provider.setTopic ${provider.setTopic}");
                            }

                            Navigator.pop(context);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddTopicPage()));
                            setState(() {});
                          }
                        });
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
      );
    });
  }
}
