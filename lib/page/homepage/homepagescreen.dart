import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/database/financedata.dart';
import 'package:incomeandexpansesapp/font.dart';
import 'package:incomeandexpansesapp/gsheet_setup.dart';
import 'package:incomeandexpansesapp/page/Provider/financeProvider.dart';
import 'package:incomeandexpansesapp/page/addtopicpage.dart';
import 'package:incomeandexpansesapp/page/homepage/sub_homepage/edit_delete_each%20a%20list.dart';
import 'package:incomeandexpansesapp/page/homepage/sub_homepage/add_list_alert_dialog.dart';
import 'package:incomeandexpansesapp/page/homepage/sub_homepage/list_widget.dart';
import 'package:incomeandexpansesapp/page/homepage/sub_homepage/tab_find.dart';
import 'package:incomeandexpansesapp/page/homepage/sub_homepage/tabbar_homepage.dart';
import 'package:provider/provider.dart';

class HomepageScreen extends StatefulWidget {
  String? topic;
  List<Finance>? financeInTopic;
  HomepageScreen({
    super.key,
    this.financeInTopic,
    required this.topic,
  });

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  //List<Finance> results = [];
  //List<Finance> finances = [];
  bool enabled = false;
  bool enabled1 = false;
  bool enabled2 = false;

  DateTime dateTime = DateTime.now();
  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2010),
      lastDate: DateTime(2110));
  String? _topic;
  List<Finance>? _financeInTopic;
  List<Finance>? _history = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getFinance();
    //arrange(widget.financeInTopic!);
    _topic = widget.topic;
    _financeInTopic = widget.financeInTopic;
    _history = [];
  }

  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    //var _topic = widget.topic;

    return Scaffold(
      body: Consumer(
          builder: (BuildContext context, FinanceProvider provider, widget) {
        print("เข้ามาหน้า homepage");
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: ([AppColors.bglevel1, AppColors.bglevel2]))),
            ),
            Container(
              child: Column(
                children: [
                  //แถบหัวข้อบัญชี ลิงค์กลับ และลิงค์กราฟสถิติ
                  Expanded(
                      flex: 2,
                      child: TabbarHomepage(
                          topic: _topic!, dataToGraph: _financeInTopic!)),
                  //ค้นหาวันที่และปประวัติทั้งหมด //
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: Hscreen * H10,
                          right: Wscreen * W30,
                          left: Wscreen * W30),
                      child: Container(
                        //color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                setState(() => enabled1 = true);
                                await Future.delayed(
                                    const Duration(milliseconds: 200));
                                setState(() => enabled1 = false);
                                await Future.delayed(
                                    const Duration(milliseconds: 200));
                                setState(() {
                                  _history = _financeInTopic!;
                                  this._history = _history;

                                  //print("_history :  $_history");

                                  provider.sumExpense(_history!);
                                  provider.sumIncome(_history!);
                                });
                              },
                              child: FindAllStory(),
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() => enabled = true);
                                await Future.delayed(
                                    Duration(milliseconds: 200));
                                setState(() => enabled = false);
                                await Future.delayed(
                                    Duration(milliseconds: 200));
                                DateTime? date = await pickDate();
                                if (date == null) return;

                                final dateTime = DateTime(
                                  date.year,
                                  date.month,
                                  date.day,
                                );
                                setState(() {
                                  this.dateTime = dateTime;

                                  String datetime =
                                      "${dateTime.year}-${dateTime.month.toString().padLeft(2, "0")}-${dateTime.day.toString().padLeft(2, "0")}";

                                  _history = _financeInTopic!
                                      .where((element) => element.date
                                          .toString()
                                          .substring(0, 11)
                                          .toLowerCase()
                                          .contains(datetime))
                                      .toList();

                                  // print("_history :  $_history");

                                  provider.sumIncome(_history!);
                                  if (_history!.isEmpty) {
                                    _history = [
                                      Finance(
                                          date: DateTime(dateTime.year,
                                                  dateTime.month, dateTime.day)
                                              .toString(),
                                          timestamp: DateTime(dateTime.year,
                                                  dateTime.month, dateTime.day)
                                              .toString(),
                                          income: "0",
                                          expense: "0",
                                          name: "ไม่มีรายการในวันนี้ค่ะ",
                                          note: "")
                                    ];

                                    //print(_history);

                                    provider.sumExpense(_history!);
                                    provider.sumIncome(_history!);
                                  } else {
                                    print("มีรายการค่ะ");
                                    provider.sumExpense(_history!);
                                    provider.sumIncome(_history!);
                                  }
                                });
                              },
                              child: FindselectedStory(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //โชวรายการในบัญชี
                  Expanded(
                      flex: 9,
                      child: Padding(
                        padding: EdgeInsets.only(
                          //top: Hscreen * H5,
                          right: Wscreen * W20,
                          left: Wscreen * W20,
                          bottom: Hscreen * H5,
                        ),
                        child: _financeInTopic!.isEmpty
                            ? NoList()
                            : ListView.builder(
                                itemCount: _history!.isEmpty
                                    ? _financeInTopic!.length
                                    : _history!.length,
                                itemBuilder: (context, index) {
                                  Finance data = _history!.isEmpty
                                      ? _financeInTopic![index]
                                      : _history![index];

                                  //แต่ละรายการ
                                  return GestureDetector(
                                    //กดนานๆจะโชว์ไดอาลอคแก้ไขและลบ
                                    onLongPress: () {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  AppColors.bglevel1,
                                              actions: [
                                                //แก้ไขรายการ
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColors.income,
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              Hscreen * H20))),
                                                  child: TextButton(
                                                    child: Text("แก้ไขรายการ",
                                                        style:
                                                            GoogleFonts.getFont(
                                                                Fonttype.Mali,
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
                                                          context: context,
                                                          barrierDismissible:
                                                              true,
                                                          builder: (BuildContext
                                                              context) {
                                                            return EditList(
                                                                id: data.id,
                                                                topic: _topic,
                                                                datetime:
                                                                    data.date,
                                                                timeStamp: data
                                                                    .timestamp,
                                                                type: data.income !=
                                                                        "0"
                                                                    ? "รายรับ"
                                                                    : "รายจ่าย",
                                                                name: data.name,
                                                                amount: data.income !=
                                                                        "0"
                                                                    ? data
                                                                        .income
                                                                    : data
                                                                        .expense,
                                                                note:
                                                                    data.note);
                                                          });
                                                    },
                                                  ),
                                                ),
                                                //ลบรายการ
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: AppColors.expenses,
                                                      borderRadius: BorderRadius
                                                          .all(Radius.circular(
                                                              Hscreen * H20))),
                                                  child: TextButton(
                                                    child: Text("ลบรายการ",
                                                        style:
                                                            GoogleFonts.getFont(
                                                                Fonttype.Mali,
                                                                fontSize:
                                                                    Hscreen *
                                                                        H14,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                    onPressed: () {
                                                      if (_history!
                                                          .isNotEmpty) {
                                                        var dataindex =
                                                            _history![index];
                                                        // print(
                                                        //     "dataindex  result: ${dataindex.id}");
                                                        // deleteDatafromGSheet(
                                                        //     dataindex.id
                                                        //         .toString());
                                                      } else {
                                                        var dataindex =
                                                            _financeInTopic![
                                                                index];
                                                        // print(
                                                        //     "dataindex  results: ${dataindex.id}");
                                                        // deleteDatafromGSheet(
                                                        //     dataindex.id
                                                        //         .toString());
                                                        // results.remove(
                                                        //     results[index]);
                                                      }

                                                      //provider.FinanceList;

                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                              ],
                                              content: Container(
                                                  margin: EdgeInsets.only(
                                                      left: Wscreen * W10,
                                                      top: Hscreen * H10),
                                                  child: Text(
                                                    "${data.name}",
                                                    overflow: TextOverflow.clip,
                                                    style: GoogleFonts.getFont(
                                                        Fonttype.Mali,
                                                        fontSize: Hscreen * H20,
                                                        color:
                                                            AppColors.textgrey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            );
                                          });
                                    },
                                    //หน้าแต่ละลิส
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: Hscreen * H15),
                                      child: Container(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: Hscreen * H70,
                                              width: Wscreen * W365,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              Hscreen * H10)),
                                                  color: AppColors.boxpurple),
                                              child: Padding(
                                                padding: EdgeInsets.all(
                                                    Hscreen * H10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    data.income == 0 &&
                                                            data.expense == 0
                                                        ?
                                                        //เงื่อนไขข้อมูลใหม่ยังไม่แก้ไข
                                                        SizedBox(
                                                            width:
                                                                Wscreen * W340,
                                                            child: Column(
                                                              children: [
                                                                Row(children: [
                                                                  //รูปภาพในลิสต์
                                                                  Container(
                                                                    height:
                                                                        Hscreen *
                                                                            H20,
                                                                    width:
                                                                        Wscreen *
                                                                            W20,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(Hscreen * H20), topRight: Radius.circular(Hscreen * H20), bottomLeft: Radius.circular(Hscreen * H20), bottomRight: Radius.circular(Hscreen * H20)),
                                                                        image: DecorationImage(
                                                                            image: data.income != "0"
                                                                                ? const AssetImage("assets/like.png")
                                                                                : data.expense != "0"
                                                                                    ? const AssetImage("assets/dislike.png")
                                                                                    : const AssetImage("assets/empty-box.png"))),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        Wscreen *
                                                                            W5,
                                                                  ),
                                                                  //ข้อความวันที่ในลิสต์
                                                                  Text(
                                                                    "${data.date.toString().substring(0, 19)}",
                                                                    //"${data.datetime!.year}/${data.datetime!.month}/${data.datetime!.day} เวลา ${data.datetime!.hour.toString().padLeft(2, "0")}:${data.datetime!.minute.toString().padLeft(2, "0")}",
                                                                    style: GoogleFonts.getFont(
                                                                        "Mali",
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            Hscreen *
                                                                                H14),
                                                                  ),
                                                                ]),
                                                                //ข้อความรายการและราคาในลิสต์
                                                                Row(
                                                                  children: [
                                                                    //ข้อความรายการในลิสต์
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          top: Hscreen *
                                                                              H5,
                                                                          left: Wscreen *
                                                                              W20),
                                                                      child:
                                                                          SizedBox(
                                                                        width: Wscreen *
                                                                            W200,
                                                                        child:
                                                                            Text(
                                                                          "${data.name}",
                                                                          maxLines:
                                                                              1,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: GoogleFonts.getFont(
                                                                              Fonttype.Mali,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: Hscreen * H14),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    //ราคาในลิสต์
                                                                    Container(
                                                                      width:
                                                                          Wscreen *
                                                                              W80,
                                                                      child:
                                                                          Text(
                                                                        "${data.income != "0" ? data.income : data.expense} บาท",
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: GoogleFonts.getFont(
                                                                            Fonttype
                                                                                .Mali,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: Hscreen * H14),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        // มีข้อมูล หรือค้นหาโดยใช้วันที่เจอ
                                                        : SizedBox(
                                                            width:
                                                                Wscreen * W340,
                                                            child: Column(
                                                              children: [
                                                                Row(children: [
                                                                  //รูปภาพในลิสต์
                                                                  Container(
                                                                    height:
                                                                        Hscreen *
                                                                            H25,
                                                                    width:
                                                                        Wscreen *
                                                                            W20,
                                                                    decoration: BoxDecoration(
                                                                        //borderRadius: BorderRadius.only(topLeft: Radius.circular(Hscreen * H10), topRight: Radius.circular(Hscreen * H10), bottomLeft: Radius.circular(Hscreen * H10), bottomRight: Radius.circular(Hscreen * H10)),
                                                                        image: DecorationImage(
                                                                            image: data.income != "0"
                                                                                ? const AssetImage("assets/like.png")
                                                                                : data.expense != "0"
                                                                                    ? const AssetImage("assets/dislike.png")
                                                                                    : const AssetImage("assets/empty-box.png"))),
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        Wscreen *
                                                                            W10,
                                                                  ),
                                                                  //ข้อความวันที่ในลิสต์
                                                                  Text(
                                                                    "${data.date.toString().substring(0, 19)}",
                                                                    //"${data.date!.year}/${data.datetime!.month}/${data.datetime!.day} เวลา ${data.datetime!.hour.toString().padLeft(2, "0")}:${data.datetime!.minute.toString().padLeft(2, "0")}",
                                                                    style: GoogleFonts.getFont(
                                                                        "Mali",
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            Hscreen *
                                                                                H14),
                                                                  ),
                                                                ]),
                                                                SizedBox(
                                                                  height:
                                                                      Hscreen *
                                                                          H5,
                                                                ),
                                                                //ข้อความรายการและราคาในลิสต์
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    //ข้อความรายการในลิสต์
                                                                    SizedBox(
                                                                        width: Wscreen *
                                                                            W230,
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.only(left: Wscreen * W30),
                                                                          child:
                                                                              Text(
                                                                            "${data.name}",
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: GoogleFonts.getFont(Fonttype.Mali,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: Hscreen * H14),
                                                                          ),
                                                                        )),
                                                                    //ข้อความราคาในลิสต์
                                                                    SizedBox(
                                                                      width: Wscreen *
                                                                          W100,
                                                                      child:
                                                                          Text(
                                                                        "${data.income == "0" ? data.expense : data.income} บาท",
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.fade,
                                                                        style: GoogleFonts.getFont(
                                                                            Fonttype
                                                                                .Mali,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontSize: Hscreen * H14),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
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
                      )),

                  //ปุ่มเพิ่มรายการในบัญชี
                  Expanded(
                    flex: 2,
                    child: _financeInTopic!.isEmpty && _history!.isEmpty
                        ? GestureDetector(
                            onTap: () async {
                              setState(() => enabled2 = true);
                              await Future.delayed(Duration(milliseconds: 200));
                              setState(() => enabled2 = false);
                              await Future.delayed(Duration(milliseconds: 200));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddTopicPage()));
                            },
                            child: AddbuttonList(enabled: enabled2),
                          )
                        : GestureDetector(
                            onTap: () async {
                              //  print(_history![0].name);
                              // print(_financeInTopic);
                              setState(() => enabled2 = true);
                              await Future.delayed(Duration(milliseconds: 200));
                              setState(() => enabled2 = false);
                              await Future.delayed(Duration(milliseconds: 200));
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return AddListAlertdialog(
                                        topic: _topic,
                                        financeInTopic: _financeInTopic);
                                  });
                            },
                            child: Container(
                              child: Stack(children: [
                                Icon(
                                  Icons.circle,
                                  size: Hscreen * H80,
                                  color: Colors.white,
                                ),
                                Icon(
                                  Icons.add_circle,
                                  size: Hscreen * H80,
                                  color: enabled2
                                      ? Colors.grey
                                      : AppColors.addpink,
                                ),
                              ]),
                            ),
                          ),
                  ),
                  //แถบรายการรวมรายรับ ราบจ่าย คงเหลือ
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: Container(
                        height: Hscreen * H200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: ([
                              AppColors.strongping,
                              AppColors.strongyellow
                            ]),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Wscreen * W20),
                            topRight: Radius.circular(Wscreen * W20),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: Hscreen * H20,
                              bottom: Hscreen * H20,
                              left: Wscreen * W60,
                              right: Wscreen * W60),
                          child: Container(
                            //color: Colors.white,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "รายรับ",
                                          style: GoogleFonts.getFont("Mali",
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Hscreen * H16),
                                        ),
                                        SizedBox(
                                          height: Hscreen * H5,
                                        ),
                                        _history!.isNotEmpty &&
                                                _financeInTopic!.isEmpty
                                            ? Text(
                                                "${provider.sumIncome(_financeInTopic!)} บาท",
                                                style: GoogleFonts.getFont(
                                                    "Mali",
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Hscreen * H16),
                                              )
                                            : _history!.isNotEmpty &&
                                                    _financeInTopic!.isNotEmpty
                                                ? Text(
                                                    "${provider.sumIncome(_financeInTopic!)} บาท",
                                                    style: GoogleFonts.getFont(
                                                        "Mali",
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Hscreen * H16),
                                                  )
                                                : Text(
                                                    "${provider.sumIncome(_financeInTopic!)} บาท",
                                                    style: GoogleFonts.getFont(
                                                        "Mali",
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Hscreen * H16),
                                                  ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "รายจ่าย",
                                          style: GoogleFonts.getFont("Mali",
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Hscreen * H16),
                                        ),
                                        SizedBox(
                                          height: Hscreen * H5,
                                        ),
                                        _history!.isNotEmpty &&
                                                _financeInTopic!.isEmpty
                                            ? Text(
                                                "${provider.sumExpense(_history!)} บาท",
                                                style: GoogleFonts.getFont(
                                                    "Mali",
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Hscreen * H16),
                                              )
                                            : _history!.isNotEmpty &&
                                                    _financeInTopic!.isNotEmpty
                                                ? Text(
                                                    "${provider.sumExpense(_financeInTopic!)} บาท",
                                                    style: GoogleFonts.getFont(
                                                        "Mali",
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Hscreen * H16),
                                                  )
                                                : Text(
                                                    "${provider.sumExpense(_financeInTopic!)} บาท",
                                                    style: GoogleFonts.getFont(
                                                        "Mali",
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Hscreen * H16),
                                                  ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Hscreen * H20,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "ยอดเงินคงเหลือ",
                                      style: GoogleFonts.getFont("Mali",
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Hscreen * H16),
                                    ),
                                    SizedBox(
                                      height: Hscreen * H5,
                                    ),
                                    _history!.isNotEmpty &&
                                            _financeInTopic!.isEmpty
                                        ? Text(
                                            "${provider.sumIncome(_history!) - provider.sumExpense(_history!)} บาท",
                                            style: GoogleFonts.getFont("Mali",
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: Hscreen * H16),
                                          )
                                        : _history!.isNotEmpty &&
                                                _financeInTopic!.isNotEmpty
                                            ? Text(
                                                "${provider.sumIncome(_financeInTopic!) - provider.sumExpense(_financeInTopic!)} บาท",
                                                style: GoogleFonts.getFont(
                                                    "Mali",
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Hscreen * H16),
                                              )
                                            : Text(
                                                "${provider.sumIncome(_financeInTopic!) - provider.sumExpense(_financeInTopic!)} บาท",
                                                style: GoogleFonts.getFont(
                                                    "Mali",
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Hscreen * H16)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
