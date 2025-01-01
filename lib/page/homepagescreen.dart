import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/font.dart';
import 'package:incomeandexpansesapp/page/Provider/financeProvider.dart';
import 'package:incomeandexpansesapp/page/addtopicpage.dart';
import 'package:incomeandexpansesapp/page/homepage/edit_delete.dart';
import 'package:incomeandexpansesapp/page/staticpagescreen.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast.dart';

class HomepageScreen extends StatefulWidget {
  String? topicshow;
  HomepageScreen({super.key, required this.topicshow});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  List<FinanceVariable> results = [];
  // double? SumExpenses;
  // double? SumIncome;
  @override
  //Datetime
  DateTime dateTime = DateTime.now();

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime(2010),
      lastDate: DateTime(2110));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var _topicshow = widget.topicshow;

    //เรียก initdata ที่ FinanceProvider
    Provider.of<FinanceProvider>(context, listen: false).initData();
  }

  bool enabled = false;
  bool enabled1 = false;
  bool enabled2 = false;
  bool enabled3 = false;
  bool enabled4 = false;

  @override
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    var _topicshow = widget.topicshow;

    return Scaffold(
      body: Consumer(
          builder: (BuildContext context, FinanceProvider provider, widget) {
        List<FinanceVariable> result = [];
        for (var data in provider.FinanceList) {
          if (data.topic == _topicshow) {
            result.add(data);
          }
        }
        print("เข้ามาหน้า homepage");
        print(result);
        print(provider.FinanceList.length);
        print("results : $results");

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
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: Hscreen * H10,
                          right: Wscreen * W10,
                          left: Wscreen * W10,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  setState(() => enabled3 = true);
                                  await Future.delayed(
                                      Duration(milliseconds: 200));
                                  setState(() => enabled3 = false);
                                  await Future.delayed(
                                      Duration(milliseconds: 200));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddTopicPage()));
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
                                      color: enabled3
                                          ? Colors.grey
                                          : AppColors.addpink,
                                    ),
                                  ]),
                                ),
                              ),
                              SizedBox(width: Wscreen * W10),
                              Container(
                                width: Wscreen * W230,
                                margin: EdgeInsets.only(top: Hscreen * H15),
                                child: Center(
                                  child: Text(
                                    "$_topicshow",
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.getFont(
                                      Fonttype.Mali,
                                      fontSize: Hscreen * H20,
                                      color: AppColors.textblue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: Wscreen * W10),
                              GestureDetector(
                                onTap: () async {
                                  setState(() => enabled4 = true);
                                  await Future.delayed(
                                      Duration(milliseconds: 200));
                                  setState(() => enabled4 = false);
                                  await Future.delayed(
                                      Duration(milliseconds: 200));

                                  if (result.length < 2) {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: AppColors.bglevel1,
                                            content: Container(
                                                child: Text(
                                                    "รายการมีน้อยกว่า 2 ไม่สามารถวิเคราะห์กราฟได้ค่ะ",
                                                    style: GoogleFonts.getFont(
                                                        Fonttype.Mali,
                                                        fontSize: Hscreen * H16,
                                                        color:
                                                            AppColors.textgrey,
                                                        fontWeight:
                                                            FontWeight.w500))),
                                          );
                                        });
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Staticmoney(
                                                  result: result,
                                                  topic: _topicshow,
                                                )));
                                  }
                                },
                                child: Center(
                                  child: Container(
                                    height: Hscreen * H50,
                                    width: Wscreen * W50,
                                    //color: Colors.white,
                                    decoration: BoxDecoration(
                                      color: enabled4 ? AppColors.border : null,
                                      image: const DecorationImage(
                                        image:
                                            AssetImage("assets/chartline.png"),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
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
                                  results = result;
                                  print("results :  $results");
                                  provider.sumExpense(results);
                                  provider.sumIncome(results);
                                });
                              },
                              child: Container(
                                height: Hscreen * H40,
                                width: Wscreen * W130,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Hscreen * H10)),
                                  border: Border.all(color: AppColors.addpink),
                                ),
                                child: Center(
                                  child: Text(
                                    "ประวัติทั้งหมด",
                                    style: GoogleFonts.getFont(Fonttype.Mali,
                                        color: AppColors.textgrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Hscreen * H14),
                                  ),
                                ),
                              ),
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

                                  results = result
                                      .where((element) => element.datetime
                                          .toString()
                                          .toLowerCase()
                                          .contains(datetime))
                                      .toList();
                                  ;

                                  //provider.sumIncome(results);
                                  if (results.isEmpty) {
                                    results = [
                                      FinanceVariable(
                                          datetime: DateTime(dateTime.year,
                                              dateTime.month, dateTime.day),
                                          timeStamp: DateTime(dateTime.year,
                                              dateTime.month, dateTime.day),
                                          type: "Nodata",
                                          name: "ไม่มีรายการในวันนี้ค่ะ",
                                          amount: 00,
                                          note: "")
                                    ];

                                    provider.sumExpense(results);
                                    provider.sumIncome(results);
                                  } else {
                                    provider.sumExpense(results);
                                    provider.sumIncome(results);
                                  }
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: Hscreen * H30,
                                    width: Wscreen * W30,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage("assets/search.png"),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  SizedBox(width: Wscreen * W10),
                                  Text(
                                    "ค้นหาวันที่",
                                    style: GoogleFonts.getFont(Fonttype.Mali,
                                        color: AppColors.textgrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Hscreen * H14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: Padding(
                      padding: EdgeInsets.only(
                        //top: Hscreen * H5,
                        right: Wscreen * W20,
                        left: Wscreen * W20,
                        bottom: Hscreen * H5,
                      ),
                      child: result.isEmpty && results.isEmpty
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
                          : ListView.builder(
                              itemCount: results.isEmpty
                                  ? result.length
                                  : results.length,
                              itemBuilder: (context, index) {
                                FinanceVariable data = results.isEmpty
                                    ? result[index]
                                    : results[index];

                                return GestureDetector(
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: AppColors.bglevel1,
                                            actions: [
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
                                                                  Hscreen * H14,
                                                              color:
                                                                  Colors.white,
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
                                                              topic: _topicshow,
                                                              datetime:
                                                                  data.datetime,
                                                              timeStamp: data
                                                                  .timeStamp,
                                                              type: data.type,
                                                              name: data.name,
                                                              amount:
                                                                  data.amount,
                                                              note: data.note);
                                                        });
                                                  },
                                                ),
                                              ),
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
                                                                  Hscreen * H14,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                  onPressed: () {
                                                    if (results.isEmpty) {
                                                      var dataindex =
                                                          result[index];
                                                      provider
                                                          .delateFinanceVariable(
                                                              dataindex);
                                                    } else {
                                                      var dataindex =
                                                          results[index];
                                                      provider
                                                          .delateFinanceVariable(
                                                              dataindex);
                                                      results.remove(
                                                          results[index]);
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
                                                      color: AppColors.textgrey,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          );
                                        });
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(bottom: Hscreen * H15),
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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        Hscreen * H10)),
                                                color: AppColors.boxpurple),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.all(Hscreen * H10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  data.type == "Nodata"
                                                      ? SizedBox(
                                                          width: Wscreen * W340,
                                                          child: Column(
                                                            children: [
                                                              Row(children: [
                                                                Container(
                                                                  height:
                                                                      Hscreen *
                                                                          H20,
                                                                  width:
                                                                      Wscreen *
                                                                          W15,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(Hscreen * H20), topRight: Radius.circular(Hscreen * H20), bottomLeft: Radius.circular(Hscreen * H20), bottomRight: Radius.circular(Hscreen * H20)),
                                                                      image: DecorationImage(
                                                                          image: data.type == "รายรับ"
                                                                              ? const AssetImage("assets/like.png")
                                                                              : data.type == "รายจ่าย"
                                                                                  ? const AssetImage("assets/dislike.png")
                                                                                  : const AssetImage("assets/empty-box.png"))),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      Wscreen *
                                                                          W5,
                                                                ),
                                                                Text(
                                                                  "${data.datetime!.year}/${data.datetime!.month}/${data.datetime!.day} เวลา ${data.datetime!.hour.toString().padLeft(2, "0")}:${data.datetime!.minute.toString().padLeft(2, "0")}",
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
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.all(
                                                                        Hscreen *
                                                                            H8),
                                                                    child:
                                                                        SizedBox(
                                                                      width: Wscreen *
                                                                          W230,
                                                                      child:
                                                                          Text(
                                                                        "${data.name}",
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
                                                                  ),
                                                                  Container(
                                                                    width:
                                                                        Wscreen *
                                                                            W100,
                                                                    child: Text(
                                                                      "${data.amount} บาท",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts.getFont(
                                                                          Fonttype
                                                                              .Mali,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              Hscreen * H14),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          width: Wscreen * W340,
                                                          child: Column(
                                                            children: [
                                                              Row(children: [
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
                                                                          image: data.type == "รายรับ"
                                                                              ? const AssetImage("assets/like.png")
                                                                              : data.type == "รายจ่าย"
                                                                                  ? const AssetImage("assets/dislike.png")
                                                                                  : const AssetImage("assets/empty-box.png"))),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      Wscreen *
                                                                          W10,
                                                                ),
                                                                Text(
                                                                  "${data.datetime!.year}/${data.datetime!.month}/${data.datetime!.day} เวลา ${data.datetime!.hour.toString().padLeft(2, "0")}:${data.datetime!.minute.toString().padLeft(2, "0")}",
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
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
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
                                                                          style: GoogleFonts.getFont(
                                                                              Fonttype.Mali,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: Hscreen * H14),
                                                                        ),
                                                                      )),
                                                                  SizedBox(
                                                                    width:
                                                                        Wscreen *
                                                                            W100,
                                                                    child: Text(
                                                                      "${data.amount} บาท",
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .fade,
                                                                      style: GoogleFonts.getFont(
                                                                          Fonttype
                                                                              .Mali,
                                                                          color: Colors
                                                                              .white,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              Hscreen * H14),
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
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: result.isEmpty && results.isEmpty
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
                            child: Container(
                              child: Stack(children: [
                                Icon(
                                  Icons.circle,
                                  size: Hscreen * H80,
                                  color: Colors.white,
                                ),
                                Icon(
                                  Icons.arrow_circle_left,
                                  size: Hscreen * H80,
                                  color: enabled2
                                      ? Colors.grey
                                      : AppColors.addpink,
                                ),
                              ]),
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              setState(() => enabled2 = true);
                              await Future.delayed(Duration(milliseconds: 200));
                              setState(() => enabled2 = false);
                              await Future.delayed(Duration(milliseconds: 200));
                              showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return Alertdialog(topicshow: _topicshow);
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
                                        result.isNotEmpty && results.isEmpty
                                            ? Text(
                                                "${provider.sumIncome(result)} บาท",
                                                style: GoogleFonts.getFont(
                                                    "Mali",
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Hscreen * H16),
                                              )
                                            : result.isNotEmpty &&
                                                    results.isNotEmpty
                                                ? Text(
                                                    "${provider.sumIncome(results)} บาท",
                                                    style: GoogleFonts.getFont(
                                                        "Mali",
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Hscreen * H16),
                                                  )
                                                : Text(
                                                    "${provider.sumIncome(results)} บาท",
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
                                        result.isNotEmpty && results.isEmpty
                                            ? Text(
                                                "${provider.sumExpense(result)} บาท",
                                                style: GoogleFonts.getFont(
                                                    "Mali",
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Hscreen * H16),
                                              )
                                            : result.isNotEmpty &&
                                                    results.isNotEmpty
                                                ? Text(
                                                    "${provider.sumExpense(results)} บาท",
                                                    style: GoogleFonts.getFont(
                                                        "Mali",
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Hscreen * H16),
                                                  )
                                                : Text(
                                                    "${provider.sumExpense(results)} บาท",
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
                                    result.isNotEmpty && results.isEmpty
                                        ? Text(
                                            "${provider.sumIncome(result) - provider.sumExpense(result)} บาท",
                                            style: GoogleFonts.getFont("Mali",
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: Hscreen * H16),
                                          )
                                        : result.isNotEmpty &&
                                                results.isNotEmpty
                                            ? Text(
                                                "${provider.sumIncome(results) - provider.sumExpense(results)} บาท",
                                                style: GoogleFonts.getFont(
                                                    "Mali",
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Hscreen * H16),
                                              )
                                            : Text(
                                                "${provider.sumIncome(results) - provider.sumExpense(results)} บาท",
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

class Alertdialog extends StatefulWidget {
  String? topicshow;
  Alertdialog({super.key, required this.topicshow});

  @override
  State<Alertdialog> createState() => _AlertdialogState();
}

class _AlertdialogState extends State<Alertdialog> {
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

  @override
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    var _topicshow = widget.topicshow;

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
                            "$_topicshow",
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

                        //เตรียม Json ลง provider
                        FinanceVariable data = FinanceVariable(
                            topic: _topicshow,
                            datetime: DateTime(
                              dateTime.year,
                              dateTime.month,
                              dateTime.day,
                              dateTime.hour,
                              dateTime.minute,
                            ),
                            timeStamp: DateTime.now(),
                            type: type,
                            name: name,
                            amount: double.parse(amount),
                            note: note);

                        //call provider
                        FinanceProvider provider = Provider.of<FinanceProvider>(
                            context,
                            listen: false);
                        provider.addFinaceList(data);

                        //Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomepageScreen(
                                      topicshow: _topicshow,
                                    )));
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
