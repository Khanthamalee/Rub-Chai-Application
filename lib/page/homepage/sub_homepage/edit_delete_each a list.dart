import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/font.dart';
import 'package:incomeandexpansesapp/page/Provider/financeProvider.dart';
import 'package:provider/provider.dart';

import '../../../database/financedata.dart';
import '../homepagescreen.dart';

class EditList extends StatefulWidget {
  String? id;
  String? topic;
  String? datetime;
  String? timeStamp;
  String? type;
  String? name;
  String? amount;
  String? note;
  EditList(
      {super.key,
      this.id,
      required this.topic,
      this.datetime,
      this.timeStamp,
      this.type,
      this.name,
      this.amount,
      this.note});

  @override
  State<EditList> createState() => _EditListState();
}

class _EditListState extends State<EditList> {
  var dropdowntypevalue = "";
  List<String> typeList = ["รายรับ", "รายจ่าย"];
  @override
  void initState() {
    // TODO: implement initState
    dropdowntypevalue = widget.type!;
    super.initState();
  }

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
  //bool enabled7 = false;
  bool datetimechange = false;

  @override
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    var _topic = widget.topic;
    String? _datetime = widget.datetime;
    var _id = widget.id;
    var _name = widget.name;
    var _amount = widget.amount;
    var _note = widget.note;

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
                      //Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomepageScreen(
                                    topic: _topic,
                                  )));
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
                        child: DropdownButtonFormField<String>(
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
                          focusColor: AppColors.addpink,
                          onChanged: (value) {
                            // This is called when the user selects an item.
                            print("value : $value");

                            dropdowntypevalue = value.toString();
                            print("dropdowntypevalue : $dropdowntypevalue");
                          },
                          items: typeList
                              .map<DropdownMenuItem<String>>((String newvalue) {
                            print("newvalue : $newvalue");
                            print(
                                "dropdowntypevalue in items : $dropdowntypevalue");

                            //dropdowntypevalue = newvalue;
                            print(
                                "dropdowntypevalue n items  : $dropdowntypevalue");
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
                          keyboardType: TextInputType.text,
                          maxLines: 3,
                          cursorColor: AppColors.addpink,
                          decoration: InputDecoration(
                              hintText: "${_name}",
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
                          keyboardType: TextInputType.number,
                          cursorColor: AppColors.addpink,
                          decoration: InputDecoration(
                              hintText: "${_amount}",
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
                                "แก้ไขเวลาที่ทำการซื้อ-ขาย",
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
                            datetimechange == true
                                ? "${dateTime.year}/${dateTime.month}/${dateTime.day} เวลา ${dateTime.hour.toString().padLeft(2, "0")}:${dateTime.minute.toString().padLeft(2, "0")}"
                                //: "${_datetime!.year}/${_datetime.month}/${_datetime.day} เวลา ${_datetime.hour.toString().padLeft(2, "0")}:${_datetime.minute.toString().padLeft(2, "0")}"
                                : "${_datetime}",
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
                              hintText: "${_note}",
                              hintStyle: GoogleFonts.getFont(Fonttype.Mali,
                                  fontSize: Hscreen * H16,
                                  color: AppColors.textblue,
                                  fontWeight: FontWeight.w400),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none),
                        ),
                      )),
                  //แก้ไขข้อมูล
                  GestureDetector(
                    onTap: () async {
                      setState(() => enabled6 = true);
                      await Future.delayed(Duration(milliseconds: 200));
                      setState(() => enabled6 = false);
                      await Future.delayed(Duration(milliseconds: 200));

                      FinanceProvider provider =
                          Provider.of<FinanceProvider>(context, listen: false);

                      var type = dropdowntypevalue.toString();
                      print("dropdowntypevalue : $dropdowntypevalue");
                      var name = nameController.text.isEmpty
                          ? _name
                          : nameController.text;
                      var datetimeedit = dateTime;

                      var amount = amountController.text.isEmpty
                          ? _amount
                          : amountController.text;
                      var note = noteController.text.isEmpty
                          ? _note
                          : noteController.text;

                      for (var i in provider.datafromGsheet) {
                        if (i.id == _id) {
                          //เตรียม Json ลง provider
                          Finance data = Finance(
                            id: _id,
                            topic: _topic,
                            date: datetimeedit.toString(),
                            timestamp: i.timestamp,
                            name: name,
                            income:
                                type == "รายรับ" ? amount.toString() : "0.00",
                            expense:
                                type == "รายจ่าย" ? amount.toString() : "0.00",
                            balance: amount.toString(),
                            note: note,
                          );
                          print("updateDataToGoogleSheet");
                          //provider.updateDataToGoogleSheet(data);
                        }

                        //Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomepageScreen(
                                      topic: _topic,
                                    )));
                      }
                    },
                    // ปุ่มแก้ไขรายการ
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
                            "แก้ไขรายการ",
                            style: GoogleFonts.getFont("Mali",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Hscreen * H14),
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
      // var datetime =
      //     "${dateTime.year}/${dateTime.month}/${dateTime.day} เวลา ${dateTime.hour.toString().padLeft(2, "0")}:${dateTime.minute.toString().padLeft(2, "0")}";
      datetimechange = true;
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
