import 'package:flutter/foundation.dart';
import 'package:incomeandexpansesapp/database/finance_db.dart';

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
    var db = FinanceDB(dbname: 'finance.db');
    //ดึงข้อมูลมาแสดง
    FinanceList = await db.LoadAllData();
    returnlistTopic(FinanceList);

    SumExpenses = sumExpense(FinanceList);
    SumIncome = sumIncome(FinanceList);

    //แจ้งเตือน Comsumer
    notifyListeners();
  }

//1. function บัญชี
  //1.1 Arange Topic for Read บัญชี
  Future returnlistTopic(List<FinanceVariable> FinanceList) async {
    var db = FinanceDB(dbname: 'finance.db');
    //บันทึกข้อมูล
    //await db.InsertData(data);
    FinanceList = await db.LoadAllData();
    if (FinanceList.isNotEmpty) {
      setTopic = Set();
      for (var listdata in FinanceList) {
        var topic = listdata.topic;

        setTopic.addAll([topic.toString()]);
      }
    } else {
      setTopic = Set();
    }
  }

  //1.2 Delete บัญชี และข้อมูลที่อยู่ในบัญชีทั้งหมด
  Future daletedataTopic(String dataTopic) async {
    //เรียก database
    var db = FinanceDB(dbname: 'finance.db');
    for (var data in FinanceList) {
      if (data.topic == dataTopic) {
        int? index = data.id;

        //ลบข้อมูล
        await db.deleteData(index!);

        //ดึงข้อมูลมาแสดง
        FinanceList = await db.LoadAllData();

        returnlistTopic(FinanceList);
        //แจ้งเตือน Comsumer
        notifyListeners();
      }
    }
  }

  //1.4 แก้ไขข้อมูลบัญชี
  void UpdateTopic(int index, FinanceVariable data) async {
//เรียก database
    var db = FinanceDB(dbname: 'finance.db');
    for (var e in FinanceList) {
      if (e.id == index) {
        //Update data
        await db.UpdateData(index, data);

        //ดึงข้อมูลมาแสดง
        FinanceList = await db.LoadAllData();

        returnlistTopic(FinanceList);
        //แจ้งเตือน Comsumer
        notifyListeners();
      }
    }
  }

  //1.4 add data to FinanceList and เพิ่มบัญชี และให้ข้อมูลทั้งอยู่อยู่ในรูปแบบเริ่มต้นคือ

  void addFinaceList(FinanceVariable data) async {
    // var db = await FinanceDB(dbname: 'finance.db').openDatabase();
    //ในโทรศัพท์ มันสร้าง db ที่นี่
    //db : /data/user/0/com.Naudom.incomeandexpansesapphe/finance.db

    //เรียก database
    var db = FinanceDB(dbname: 'finance.db');
    //บันทึกข้อมูล
    await db.InsertData(data);

    //ดึงข้อมูลมาแสดง
    FinanceList = await db.LoadAllData();
    //FinanceList.insert(0, data);

    //แจ้งเตือน Comsumer
    notifyListeners();
  }

  //1.4 ลบข้อมูลในบัญชีรายอัน
  void delateFinanceVariable(FinanceVariable data) async {
    //เรียก database
    var db = FinanceDB(dbname: 'finance.db');

    //int? index = data.id;

    for (var e in FinanceList) {
      if (data.id == e.id) {
        int? index = data.id;

        //ลบข้อมูล
        await db.deleteData(index!);

        //ดึงข้อมูลมาแสดง
        FinanceList = await db.LoadAllData();

        returnlistTopic(FinanceList);
        //แจ้งเตือน Comsumer
        notifyListeners();
      }
    }

    sumIncome(FinanceList);
    sumExpense(FinanceList);

    //แจ้งเตือน Comsumer
    notifyListeners();
  }

  //1.5 จัดเรียงข้อมูลเพื่อคำนวนรายรับทั้งหมด
  double sumIncome(List<FinanceVariable> result) {
    List<FinanceVariable> incomedata = [];
    for (var element in result) {
      var type = element.type;

      if (type == "รายรับ") {
        incomedata.add(element);
      } else if (type == "Nodata") {
        incomedata.add(element);
      }
    }

    List<double> incomemoney = [];
    if (incomedata.isEmpty) {
      incomemoney = [0.0];
    } else {
      for (var money in incomedata) {
        incomemoney.add(double.parse(money.amount.toString()));
      }
    }

    double sumincomemoney =
        incomemoney.reduce((value, element) => value + element);

    //SumIncome = sumincomemoney;
    return sumincomemoney;
  }

  double sumExpense(List<FinanceVariable> result) {
    List<FinanceVariable> expensesdata = [];
    for (var element in result) {
      var type = element.type;

      if (type == "รายจ่าย") {
        expensesdata.add(element);
      } else if (type == "Nodata") {
        expensesdata.add(element);
      }
    }

    List<double> expensesmoney = [];
    if (expensesdata.isEmpty) {
      expensesmoney = [0.0];
    } else {
      for (var money in expensesdata) {
        expensesmoney.add(double.parse(money.amount.toString()));
      }
    }
    double sumexpensesmoney =
        expensesmoney.reduce((value, element) => value + element);

    return sumexpensesmoney;
  }
}
