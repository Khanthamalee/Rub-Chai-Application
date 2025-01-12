import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/database/financedata.dart';
import 'package:incomeandexpansesapp/font.dart';
import 'package:incomeandexpansesapp/gsheet_setup.dart';
import 'package:incomeandexpansesapp/page/Provider/financeProvider.dart';
import 'package:incomeandexpansesapp/page/homepage/homepagescreen.dart';
import 'package:provider/provider.dart';

class AddListAlertdialog extends StatefulWidget {
  String? topic;
  List<Finance>? financeInTopic;

  AddListAlertdialog(
      {super.key, required this.topic, required this.financeInTopic});

  @override
  State<AddListAlertdialog> createState() => _AddListAlertdialogState();
}

class _AddListAlertdialogState extends State<AddListAlertdialog> {
  String dropdowntypevalue = "รายรับ";
  List<String> typeList = ["รายรับ", "รายจ่าย"];

  //ใช้ในการดึงข้อมูลจาก Form ลงใน database
  final formKey = GlobalKey<FormState>();

  //controller
  TextEditingController typeController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  //Datetime
  DateTime dateTime = DateTime.now();
  bool enabled4 = false;
  bool enabled5 = false;
  bool enabled6 = false;
  String? _topic;
  List<Finance>? _financeInTopic;
  String? ID;
  final String _chars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890";
  Random _rnd = Random();

  @override
  initState() {
    super.initState();
    _topic = widget.topic;
    _financeInTopic = widget.financeInTopic;
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

  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    //var _topicshow = widget.topic;

    return Center(
      child: AlertDialog(
        content: Container(
          height: Hscreen * H695,
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
                      setState(() => enabled4 = true);
                      await Future.delayed(Duration(milliseconds: 200));
                      setState(() => enabled4 = false);
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
                            boxShadow: enabled4
                                ? []
                                : [
                                    BoxShadow(
                                        offset: Offset(
                                            -(Wscreen * W2), -(Hscreen * H2)),
                                        blurRadius: Hscreen * H2,
                                        color: Colors.white,
                                        spreadRadius: 1),
                                    BoxShadow(
                                        offset:
                                            Offset(Wscreen * W2, Hscreen * H2),
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
                      "เพิ่มข้อมูล",
                      style: GoogleFonts.getFont(Fonttype.Mali,
                          fontSize: Hscreen * H16,
                          color: AppColors.textgrey,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  //บัญชี
                  Container(
                      margin: EdgeInsets.only(
                        top: Hscreen * H20,
                        left: Wscreen * W20,
                        right: Wscreen * W20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(
                          Hscreen * H20,
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Hscreen * H15,
                            bottom: Hscreen * H5,
                            left: Wscreen * W15,
                            right: Wscreen * W5),
                        child: Container(
                          height: Hscreen * H30,
                          child: Text(
                            "$_topic",
                            style: GoogleFonts.getFont("Mali",
                                color: AppColors.textblue,
                                fontWeight: FontWeight.w400,
                                fontSize: Hscreen * H16),
                          ),
                        ),
                      )),
                  //dropdawn list รายรับรายจ่าย
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
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Hscreen * H5,
                            bottom: Hscreen * H5,
                            left: Wscreen * W15,
                            right: Wscreen * W15),
                        child: DropdownButton<String>(
                          value: dropdowntypevalue,
                          dropdownColor: Colors.pink[100],
                          borderRadius:
                              BorderRadius.all(Radius.circular(Hscreen * H20)),
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down_circle,
                            color: AppColors.addpink,
                            size: Hscreen * H24,
                          ),
                          style: GoogleFonts.getFont(Fonttype.Mali,
                              color: AppColors.textblue,
                              fontWeight: FontWeight.w400,
                              fontSize: Hscreen * H16),
                          underline: Container(
                            height: Hscreen * H2,
                            color: AppColors.addpink,
                          ),
                          onChanged: (value) {
                            // This is called when the user selects an item.

                            setState(() {
                              dropdowntypevalue = value.toString();
                            });
                          },
                          items: typeList
                              .map<DropdownMenuItem<String>>((String newvalue) {
                            return DropdownMenuItem<String>(
                              value: newvalue,
                              child: Text(newvalue),
                            );
                          }).toList(),
                        ),
                      )),
                  //กล่องรายการ
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
                          controller: nameController,
                          validator: (String? str) {
                            if (str!.isEmpty) {
                              return "กรุณาเพิ่มรายการ";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          maxLines: 3,
                          cursorColor: AppColors.addpink,
                          decoration: InputDecoration(
                              hintText: "รายการ",
                              hintStyle: GoogleFonts.getFont(Fonttype.Mali,
                                  fontSize: Hscreen * H16,
                                  color: AppColors.textblue,
                                  fontWeight: FontWeight.w400),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none),
                        ),
                      )),
                  //กล่องจำนวนเงิน
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
                          controller: amountController,
                          validator: (String? str) {
                            if (str!.isEmpty) {
                              return "กรุณาระบุจำนวนเงิน";
                            }
                            if (double.parse(str) <= 0) {
                              return "กรุณาระบุตัวเลขเป็นค่าบวก";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          cursorColor: AppColors.addpink,
                          decoration: InputDecoration(
                              hintText: "จำนวนเงิน",
                              hintStyle: GoogleFonts.getFont(Fonttype.Mali,
                                  fontSize: Hscreen * H16,
                                  color: AppColors.textblue,
                                  fontWeight: FontWeight.w400),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none),
                        ),
                      )),
                  //ปุ่มปฏิทิน
                  Container(
                      margin: EdgeInsets.only(
                          left: Wscreen * W20,
                          right: Wscreen * W20,
                          top: Hscreen * H10,
                          bottom: Hscreen * H10),
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Hscreen * H5,
                            bottom: Hscreen * H5,
                            left: Wscreen * W15,
                            right: Wscreen * W5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "เลือกเวลาที่ทำการซื้อ-ขาย",
                                style: GoogleFonts.getFont("Mali",
                                    color: AppColors.textblue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Hscreen * H12),
                              ),
                            ),
                            Icon(
                              Icons.arrow_circle_right_sharp,
                              size: Hscreen * H24,
                              color: Colors.red,
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() => enabled5 = true);
                                await Future.delayed(
                                    Duration(milliseconds: 200));
                                setState(() => enabled5 = false);
                                await Future.delayed(
                                    Duration(milliseconds: 200));
                                pickDateTime();
                              },
                              child: Container(
                                height: Hscreen * H30,
                                width: Wscreen * W30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Hscreen * H5)),
                                    image: const DecorationImage(
                                        image:
                                            AssetImage("assets/schedule.png"),
                                        fit: BoxFit.fill),
                                    boxShadow: enabled5
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
                          ],
                        ),
                      )),
                  //กล่องวันที่
                  Container(
                      margin: EdgeInsets.only(
                        left: Wscreen * W20,
                        right: Wscreen * W20,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(
                          Hscreen * H20,
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Hscreen * H15,
                            bottom: Hscreen * H5,
                            left: Wscreen * W15,
                            right: Wscreen * W5),
                        child: Container(
                          height: Hscreen * H40,
                          child: Text(
                            "${dateTime.year}/${dateTime.month}/${dateTime.day} เวลา ${dateTime.hour.toString().padLeft(2, "0")}:${dateTime.minute.toString().padLeft(2, "0")}",
                            style: GoogleFonts.getFont("Mali",
                                color: AppColors.textblue,
                                fontWeight: FontWeight.w400,
                                fontSize: Hscreen * H16),
                          ),
                        ),
                      )),
                  //กล่องหมายเหตุ
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
                          controller: noteController,
                          keyboardType: TextInputType.text,
                          cursorColor: AppColors.addpink,
                          decoration: InputDecoration(
                              hintText: "หมายเหตุ",
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
                      setState(() => enabled6 = true);
                      await Future.delayed(Duration(milliseconds: 200));
                      setState(() => enabled6 = false);
                      await Future.delayed(Duration(milliseconds: 200));

                      if (formKey.currentState!.validate()) {
                        var type = dropdowntypevalue.toString();
                        var name = nameController.text;
                        var amount = amountController.text;
                        var note = noteController.text;

                        UniqueIdGenerator();
                        //เตรียม Json ลง provider
                        Finance finance = Finance(
                            id: ID,
                            topic: _topic,
                            date: DateTime(
                              dateTime.year,
                              dateTime.month,
                              dateTime.day,
                              dateTime.hour,
                              dateTime.minute,
                            ).toString(),
                            timestamp: DateTime.now().toString(),
                            name: name,
                            income: type == "รายรับ" ? amount : "0",
                            expense: type == "รายจ่าย" ? amount : "0",
                            balance: amount,
                            note: note);

                        insertFinance(finance);
                        _financeInTopic?.insert(0, finance);

                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomepageScreen(
                                    topic: _topic,
                                    financeInTopic: _financeInTopic)));
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
                        color: enabled6 ? Colors.grey : AppColors.addpink,
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
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      this.dateTime = dateTime;
    });
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2010),
      lastDate: DateTime(2110));

  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );
}
