import 'package:flutter/foundation.dart';
import 'package:incomeandexpansesapp/database/finance_db.dart';

class FinanceVariable {
  int? id;
  DateTime? datetime;
  DateTime? timeStamp;
  String? type;
  String? name;
  double? amount;
  String? note;
  FinanceVariable(
      {this.id,
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

  double? SumExpenses;
  double? getSumExpenses() {
    return SumExpenses;
  }

  double? SumIncome;
  double? getIncome() {
    return SumIncome;
  }

  //แสดงผลเลยถ้า เข้า app
  void initData() async {
    var db = FinanceDB(dbname: 'finance.db');
    //ดึงข้อมูลมาแสดง
    FinanceList = await db.LoadAllData();
    //FinanceList.insert(0, data);
    SumExpenses = sumExpense(FinanceList);
    SumIncome = sumIncome(FinanceList);

    //แจ้งเตือน Comsumer
    notifyListeners();
  }

  //add data to FinanceList
  void addFinaceList(FinanceVariable data) async {
    // var db = await FinanceDB(dbname: 'finance.db').openDatabase();
    // print("db : $db");
    //ในโทรศัพท์ มันสร้าง db ที่นี่
    //db : /data/user/0/com.example.incomeandexpansesapp/cache/finance.db

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

  void delateFinanceVariable(FinanceVariable data) async {
    print("data in delateFinanceVariable : $data");

    int? index = data.id;
    print("data.id in delateFinanceVariable : ${index}");
    //เรียก database
    var db = FinanceDB(dbname: 'finance.db');
    //ลบข้อมูล
    await db.deleteCake(index!);
    //ดึงข้อมูลมาแสดง
    FinanceList = await db.LoadAllData();
    //แจ้งเตือน Comsumer
    notifyListeners();
  }

  double sumIncome(List<FinanceVariable> result) {
    print("result in sumIncome : $result");

    List<FinanceVariable> incomedata = [];
    for (var element in result) {
      var type = element.type;
      //print("type : ${type}");

      if (type == "รายรับ") {
        incomedata.add(element);
      } else if (type == "Nodata") {
        incomedata.add(element);
      }
    }

    List<double> incomemoney = [];
    if (incomedata.isEmpty) {
      print("incomedata : $incomedata");
      incomemoney = [0.0];
    } else {
      for (var money in incomedata) {
        incomemoney.add(double.parse(money.amount.toString()));
      }
    }

    double sumincomemoney =
        incomemoney.reduce((value, element) => value + element);

    print("incomemoney : ${incomemoney}");
    print("sumincomemoney : ${sumincomemoney}");
    //SumIncome = sumincomemoney;
    return sumincomemoney;
  }

  double sumExpense(List<FinanceVariable> result) {
    print("result : $result");

    List<FinanceVariable> expensesdata = [];
    for (var element in result) {
      var type = element.type;
      //print("type : ${type}");

      if (type == "รายจ่าย") {
        expensesdata.add(element);
      } else if (type == "Nodata") {
        expensesdata.add(element);
      }
    }
    print("expensesdata : $expensesdata");

    List<double> expensesmoney = [];
    if (expensesdata.isEmpty) {
      print("incomedata : $expensesdata");
      expensesmoney = [0.0];
    } else {
      for (var money in expensesdata) {
        expensesmoney.add(double.parse(money.amount.toString()));
      }
    }
    double sumexpensesmoney =
        expensesmoney.reduce((value, element) => value + element);

    print("expensesmoney : ${expensesmoney}");
    print("sumexpensesmoney : ${sumexpensesmoney}");
    // SumExpenses = sumexpensesmoney;
    return sumexpensesmoney;
  }
}
