import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:incomeandexpansesapp/DMstatic.dart';
import 'package:incomeandexpansesapp/colors.dart';
import 'package:incomeandexpansesapp/font.dart';
import 'package:incomeandexpansesapp/page/Provider/financeProvider.dart';
import 'package:incomeandexpansesapp/page/staticpagescreen.dart';
import 'package:provider/provider.dart';

class HomepageScreen extends StatefulWidget {
  HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  List<FinanceVariable> results = [];
  double? SumExpenses;
  double? SumIncome;
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

    //เรียก initdata ที่ FinanceProvider
    Provider.of<FinanceProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;
    //SumExpenses =
    //Provider.of<FinanceProvider>(context, listen: false).SumExpenses;
    return Scaffold(
      body: Consumer(
          builder: (BuildContext context, FinanceProvider provider, widget) {
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
                          top: Hscreen * H15,
                          right: Wscreen * W5,
                          left: Wscreen * W20,
                        ),
                        child: Row(children: [
                          Center(
                            child: Container(
                              height: Hscreen * H50,
                              width: Wscreen * W60,
                              //color: Colors.white,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage("assets/hii.gif"),
                                  ),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(Hscreen * H50))),
                            ),
                          ),
                          SizedBox(
                            width: Wscreen * W5,
                          ),
                          Container(
                            height: Hscreen * H50,
                            width: Wscreen * W200,
                            //color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.only(top: Hscreen * H15),
                              child: Text(
                                "",
                                style: GoogleFonts.getFont(Fonttype.Mali,
                                    color: AppColors.textblue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Hscreen * H14),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Wscreen * W50,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Staticmoney()));
                            },
                            child: Center(
                              child: Container(
                                height: Hscreen * H40,
                                width: Wscreen * W50,
                                //color: Colors.white,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/graph.png"),
                                      fit: BoxFit.fitWidth),
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
                              onTap: () {
                                setState(() {
                                  print(results);
                                  results = provider.FinanceList;
                                  print(results);
                                  SumExpenses = provider.sumExpense(results);
                                  SumIncome = provider.sumIncome(results);
                                });
                              },
                              child: Container(
                                height: Hscreen * H40,
                                width: Wscreen * W120,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(Hscreen * H20)),
                                    border:
                                        Border.all(color: AppColors.addpink)),
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
                                  print(datetime.toString());

                                  results = provider.FinanceList.where(
                                      (element) => element.datetime
                                          .toString()
                                          .toLowerCase()
                                          .contains(datetime)).toList();

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
                                    SumExpenses = provider.sumExpense(results);
                                    SumIncome = provider.sumIncome(results);
                                  }
                                  SumExpenses = provider.sumExpense(results);
                                  SumIncome = provider.sumIncome(results);
                                  print("results in pick date : ${results}");
                                  print("SumExpenses : ${SumExpenses}");
                                  print("SumIncome : ${SumIncome}");
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
                        right: Wscreen * W30,
                        left: Wscreen * W30,
                        bottom: Hscreen * H5,
                      ),
                      child: provider.FinanceList.isEmpty
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
                                  ? provider.FinanceList.length
                                  : results.length,
                              itemBuilder: (context, index) {
                                FinanceVariable data = results.isEmpty
                                    ? provider.FinanceList[index]
                                    : results[index];
                                print("${results.length},${data}");
                                SumExpenses = provider.SumExpenses;
                                SumIncome = provider.SumIncome;
                                print(
                                    "SumExpenses in ListView.builder: ${SumExpenses}");

                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: Hscreen * H15),
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
                                                  bottomRight: Radius.circular(
                                                      Hscreen * H20)),
                                              image: DecorationImage(
                                                  image: data.type == "รายรับ"
                                                      ? const AssetImage(
                                                          "assets/like.png")
                                                      : data.type == "รายจ่าย"
                                                          ? const AssetImage(
                                                              "assets/dislike.png")
                                                          : const AssetImage(
                                                              "assets/empty-box.png"))),
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
                                                  bottomLeft: Radius.circular(
                                                      Hscreen * H30),
                                                  bottomRight: Radius.circular(
                                                      Hscreen * H20)),
                                              color: AppColors.boxpurple),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: Hscreen * H10,
                                                left: Wscreen * W15,
                                                right: Wscreen * W15),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: data.type == "Nodata"
                                                      ? Wscreen * W230
                                                      : Wscreen * W160,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Text(
                                                      //   "วันที่ ${datainput()[index].date} เวลา ${datainput()[index].time}",
                                                      Text(
                                                        "${data.datetime!.year}/${data.datetime!.month}/${data.datetime!.day} เวลา ${data.datetime!.hour.toString().padLeft(2, "0")}:${data.datetime!.minute.toString().padLeft(2, "0")}",
                                                        style:
                                                            GoogleFonts.getFont(
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
                                                      SizedBox(
                                                        height: Hscreen * H5,
                                                      ),
                                                      Text(
                                                        "${data.name} ${data.amount} บาท",
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            GoogleFonts.getFont(
                                                                Fonttype.Mali,
                                                                color: Colors
                                                                    .white,
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
                                                GestureDetector(
                                                  onTap: () {
                                                    var dataindex = provider
                                                        .FinanceList[index];
                                                    provider
                                                        .delateFinanceVariable(
                                                            dataindex);
                                                  },
                                                  child: data.type == "Nodata"
                                                      ? Container()
                                                      : Container(
                                                          height: Hscreen * H35,
                                                          width: Wscreen * W70,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(
                                                                      Hscreen *
                                                                          H20))),
                                                          child: Center(
                                                            child: Text(
                                                              "ลบข้อมูล",
                                                              style: GoogleFonts.getFont(
                                                                  Fonttype.Mali,
                                                                  fontSize:
                                                                      Hscreen *
                                                                          H12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return Alertdialog();
                            });
                      },
                      child: Container(
                        child: Stack(children: [
                          const Icon(
                            Icons.circle,
                            size: 80,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.add_circle,
                            size: 80,
                            color: AppColors.addpink,
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
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
                                      results.isEmpty
                                          ? Text(
                                              "${provider.SumIncome} บาท",
                                              style: GoogleFonts.getFont("Mali",
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Hscreen * H16),
                                            )
                                          : Text(
                                              "${provider.sumIncome(results)} บาท",
                                              style: GoogleFonts.getFont("Mali",
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Hscreen * H16),
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
                                      results.isEmpty
                                          ? Text(
                                              "${provider.SumExpenses} บาท",
                                              style: GoogleFonts.getFont("Mali",
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Hscreen * H16),
                                            )
                                          : Text(
                                              "${provider.sumExpense(results)} บาท",
                                              style: GoogleFonts.getFont("Mali",
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: Hscreen * H16),
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
                                  results.isEmpty
                                      ? Text(
                                          "${provider.SumIncome! - provider.SumExpenses!} บาท",
                                          style: GoogleFonts.getFont("Mali",
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Hscreen * H16),
                                        )
                                      : Text(
                                          "${provider.sumIncome(results) - provider.sumExpense(results)} บาท",
                                          style: GoogleFonts.getFont("Mali",
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Hscreen * H16),
                                        ),
                                ],
                              ),
                            ],
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
  const Alertdialog({super.key});

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
  //TextEditingController datetimeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  //Datetime
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double Hscreen = MediaQuery.of(context).size.height;
    double Wscreen = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Center(
        child: AlertDialog(
          content: Container(
            height: Hscreen * H695,
            width: Wscreen * W300,
            constraints: const BoxConstraints(),
            padding: EdgeInsets.only(top: Hscreen * H8, bottom: Hscreen * H30),
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
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              right: Wscreen * W10, left: Wscreen * W250),
                          height: Hscreen * H30,
                          width: Wscreen * W30,
                          //color: Colors.white,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/remove.png"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //หัวข้อเพิ่มข้อมูล
                    Center(
                      child: Text(
                        "เพิ่มข้อมูล",
                        style: GoogleFonts.getFont(Fonttype.Mali,
                            fontSize: Hscreen * H18,
                            color: AppColors.textgrey,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
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
                            borderRadius: BorderRadius.all(
                                Radius.circular(Hscreen * H20)),
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
                            items: typeList.map<DropdownMenuItem<String>>(
                                (String newvalue) {
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
                            top: Hscreen * H10),
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
                                onTap: pickDateTime,
                                child: Container(
                                  height: Hscreen * H30,
                                  width: Wscreen * W30,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage("assets/schedule.png"),
                                        fit: BoxFit.fill),
                                  ),
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
                    Container(
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
                        color: AppColors.addpink,
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Hscreen * H5,
                            bottom: Hscreen * H5,
                            left: Wscreen * W5,
                            right: Wscreen * W5),
                        child: GestureDetector(
                          onTap: () {
                            print(formKey);
                            if (formKey.currentState!.validate()) {
                              var type = dropdowntypevalue.toString();
                              var name = nameController.text;
                              var amount = amountController.text;
                              var note = noteController.text;
                              print(
                                  "$type,$name,${dateTime.toString()},$amount,$note");
                              //เตรียม Json ลง provider
                              FinanceVariable data = FinanceVariable(
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
                              FinanceProvider provider =
                                  Provider.of<FinanceProvider>(context,
                                      listen: false);
                              provider.addFinaceList(data);

                              //Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomepageScreen()));
                            }
                          },
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
      print(DateTime.now());
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
