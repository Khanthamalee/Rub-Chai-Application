import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:incomeandexpansesapp/database/finance_db.dart';

import '../../gsheet_CRUD.dart';
import '../../gsheet_setup.dart';

class FinanceVariable {
  int? id;
  String? topic;
  DateTime? datetime;
  DateTime? timeStamp;
  String? type;
  String? name;
  double? amount;
  String? note;
  FinanceVariable(
      {this.id,
      this.topic,
      this.datetime,
      this.timeStamp,
      this.type,
      this.name,
      this.amount,
      this.note});
}

class FinanceProvider with ChangeNotifier {
  //keep data json
  List<FinanceVariable> FinanceList = [];

  //get FinanceList
  List<FinanceVariable> getFinanceList() {
    return FinanceList;
  }

  List<finance> datafromGsheet = [];

  List<finance> getdatafromGsheet() {
    return datafromGsheet;
  }

  double SumExpenses = 0.0;
  double getSumExpenses() {
    return SumExpenses;
  }

  double SumIncome = 0.0;
  double getIncome() {
    return SumIncome;
  }

  Set<String> setTopic = Set();
  Set<String> getlistTopic() => setTopic;

  //แสดงผลเลยถ้า เข้า app
  void initData() async {
    print("initData");

    var db = FinanceDB(dbname: 'finance.db');
    //ดึงข้อมูลมาแสดง
    FinanceList = await db.LoadAllData();

    //บันทึกข้อมูลใน local ลง GoogleSheet
    saveDataFromLocalToGoogleSheet();
    datafromGsheet = await readDatafromGoogleSheet();
    print("datafromGsheet in initData $datafromGsheet");
    print("datafromGsheet.length in initData ${datafromGsheet.length}");
    //returnlistTopic(datafromGsheet);

    SumExpenses = sumExpense(datafromGsheet);
    SumIncome = sumIncome(datafromGsheet);

    //แจ้งเตือน Comsumer
    notifyListeners();
  }

//1. function บัญชี

  //1.1 Arange Topic for Read บัญชี
  readDatafromGoogleSheet() async {
    DataFromGsheet = await readDatafromGSheet();
    datafromGsheet = [];

    for (var d in DataFromGsheet) {
      finance data = finance(
        id: d["Id"],
        topic: d["Topic"],
        date: d["Date"],
        timestamp: d["Timestamp"].toString(),
        name: d["Name"],
        income: double.parse(d["Income"].toString()),
        expense: double.parse(d["Expense"].toString()),
        balance: double.parse(d["Balance"].toString()),
        note: d["Note"],
      );
      datafromGsheet.add(data);
    }
    print("datafromGsheet in readDatafromGSheet $datafromGsheet");
  }

  returnlistTopic(List<finance> datafromGsheet) async {
    // List<finance> datafromGsheet = [];
    // readDatafromGSheet();
    //
    //print("datafromGsheet in returnlistTopic : $datafromGsheet");
    //บันทึกข้อมูล
    setTopic = Set();
    if (datafromGsheet.isNotEmpty) {
      setTopic = Set();
      for (var listdata in datafromGsheet) {
        var topic = listdata.topic;

        setTopic.add(topic.toString());
      }
    } else {
      setTopic = Set();
    }
    print("setTopic in returnlistTopic :  ${setTopic}");
    print("returnlistTopic");
  }

  //1.2 Delete บัญชี และข้อมูลที่อยู่ในบัญชีทั้งหมด
  Future daletedataTopic(String dataTopic) async {
    datafromGsheet = [];
    readDatafromGSheet();
    for (var data in datafromGsheet) {
      if (data.topic == dataTopic) {
        String? index = data.id;
        deleteDatafromGSheet(index!);
        returnlistTopic(datafromGsheet);
        notifyListeners();
      }
    }
  }

  //1.3 แก้ไขข้อมูลบัญชี
  void UpdateTopic(String index, finance data) async {
//เรียก database
    datafromGsheet = [];
    DataFromGsheet = (await GsheetCRUDUserDetails!.values.map.allRows())!;
    for (var d in DataFromGsheet) {
      finance data = finance(
        id: d["Id"],
        topic: d["Topic"],
        date: d["Date"],
        timestamp: d["Timestamp"].toString(),
        name: d["Name"],
        income: double.parse(d["Income"].toString()),
        expense: double.parse(d["Expense"].toString()),
        balance: double.parse(d["Balance"].toString()),
        note: d["Note"],
      );
      datafromGsheet.add(data);
    }
    print("index in UpdateTopic : $index");
    for (var e in datafromGsheet) {
      if (e.id == index) {
        //Update data
        UpdateDataIntoGSheet(data);
        print("data.topic : ${data.topic}");
        print("olddata.topic : ${e.topic}");
        datafromGsheet.insert(0, data);
        datafromGsheet.remove(e);
      }
    }

    //ดึงข้อมูลมาแสดง
    print("datafromGsheet after UpdateDataIntoGSheet : $datafromGsheet");
    print(
        "length datafromGsheet after UpdateDataIntoGSheet : ${datafromGsheet.length}");
    for (var e in datafromGsheet) {
      //Update data
      if (e == data.topic) {
        print("e.topic : ${e.topic}");
      } else {
        print("ไม่มี");
      }
    }
    //returnlistTopic(datafromGsheet);

    notifyListeners();
  }

  //1.4 add data to FinanceList and เพิ่มบัญชี และให้ข้อมูลทั้งอยู่อยู่ในรูปแบบเริ่มต้นคือ
  void saveDataToGoogleSheet(finance data) async {
    var _chars = "aSfac205EadlF";

    Random _rnd = Random();
    String? ID;

    UniqueIdGenerator() async {
      Random random = await Random();
      int randomNumber = await random.nextInt(10000000);
      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(
              length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
      ID = await '${randomNumber}${getRandomString(10)}';
      return ID;
    }

    ID = await UniqueIdGenerator();
    print("ID in saveDataToGoogleSheet : ${ID}");

    finance dataUpdate = finance(
        id: ID,
        topic: data.topic,
        date: data.date.toString(),
        timestamp: data.timestamp.toString(),
        name: data.name,
        expense: data.expense,
        income: data.income,
        balance: data.balance,
        note: data.note);

    InsertDataIntoGSheet(dataUpdate);

    //datafromGsheet = [];
    datafromGsheet.add(dataUpdate);
    print("datafromGsheet in saveDataToGoogleSheet :$datafromGsheet");
    print("datafromGsheet in saveDataToGoogleSheet :${datafromGsheet.length}");
    returnlistTopic(datafromGsheet);
    notifyListeners();
  }

  void updateDataToGoogleSheet(finance data) async {
    UpdateDataIntoGSheet(data);
    datafromGsheet = [];
    datafromGsheet = await readDatafromGSheet();
    returnlistTopic(datafromGsheet);
    notifyListeners();
    print(updateDataToGoogleSheet);
  }

  //1.5 ลบข้อมูลในบัญชีรายอัน
  void delateDataFromGsheet(finance data) async {
    //เรียก database
    datafromGsheet = [];
    readDatafromGSheet();

    //int? index = data.id;

    for (var e in datafromGsheet) {
      if (data.id == e.id)
        //ลบข้อมูล
        deleteDatafromGSheet(e.id!);

      //ดึงข้อมูลมาแสดง
      datafromGsheet = [];
      readDatafromGSheet();

      //returnlistTopic(FinanceList);
      //แจ้งเตือน Comsumer
      notifyListeners();
    }
    sumIncome(datafromGsheet);
    sumExpense(datafromGsheet);

    //แจ้งเตือน Comsumer
    notifyListeners();
  }

  //1.6 จัดเรียงข้อมูลเพื่อคำนวนรายรับทั้งหมด
  double sumIncome(List<finance> result) {
    List<finance> incomedata = [];
    for (var element in result) {
      if (element.income != 0.0) {
        incomedata.add(element);
      } else if (element.income == 0.0 && element.expense == 0.0) {
        incomedata.add(element);
      }
    }

    List<double> incomemoney = [];
    if (incomedata.isEmpty) {
      incomemoney = [0.0];
    } else {
      for (var money in incomedata) {
        incomemoney.add(double.parse(money.income.toString()));
      }
    }

    double sumincomemoney =
        incomemoney.reduce((value, element) => value + element);

    //SumIncome = sumincomemoney;
    return sumincomemoney;
  }

  double sumExpense(List<finance> result) {
    List<finance> expensesdata = [];

    for (var element in result) {
      if (element.expense != 0.0) {
        expensesdata.add(element);
      } else if (element.expense == 0.0 && element.expense == 0.0) {
        expensesdata.add(element);
      }
    }

    List<double> expensesmoney = [];
    if (expensesdata.isEmpty) {
      expensesmoney = [0.0];
    } else {
      for (var money in expensesdata) {
        expensesmoney.add(double.parse(money.expense.toString()));
      }
    }
    double sumexpensesmoney =
        expensesmoney.reduce((value, element) => value + element);

    return sumexpensesmoney;
  }

  //1.7 บันทึกข้อมูลในระบบ local ลงที่ Google sheet
  void saveDataFromLocalToGoogleSheet() async {
    var _chars = "aSfac205EadlF506614Avdkgsl";

    Random _rnd = Random();
    String? ID;

    UniqueIdGenerator() async {
      Random random = await Random();
      int randomNumber = await random.nextInt(10000000);
      String getRandomString(int length) =>
          String.fromCharCodes(Iterable.generate(
              length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
      ID = await '${randomNumber}${getRandomString(10)}';
      return ID;
    }

    ID = await UniqueIdGenerator();
    print("ID : $ID");
    if (FinanceList.isNotEmpty) {
      for (var r in FinanceList) {
        if (FinanceList.isNotEmpty) {
          InsertDataIntoGSheet(finance(
              id: ID,
              topic: r.topic,
              date: r.datetime.toString(),
              timestamp: r.timeStamp.toString(),
              name: r.name,
              expense: r.amount,
              income: r.amount,
              balance: r.amount,
              note: r.note));
        }
      }
    }

    for (var r in FinanceList) {
      if (FinanceList.isNotEmpty) {
        InsertDataIntoGSheet(finance(
            id: ID,
            topic: r.topic,
            date: r.datetime.toString(),
            timestamp: r.timeStamp.toString(),
            name: r.name,
            expense: r.amount,
            income: r.amount,
            balance: r.amount,
            note: r.note));
      }
    }
    print("saveDataFromLocalToGoogleSheet");
  }
}
