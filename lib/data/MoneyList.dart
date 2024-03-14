import 'package:incomeandexpansesapp/data/variable.dart';
import 'package:intl/intl.dart';

List<money> datainput() {
  money moneyinput = money();
  moneyinput.date = DateTime.now();
  moneyinput.time = DateFormat.Hms().format(DateTime.now());
  moneyinput.type = "รายรับ";
  moneyinput.name = "ปริ้นเอกสาร";
  moneyinput.amount = 20;
  money moneyinput1 = money();
  moneyinput1.date = DateTime.now();
  moneyinput1.time = DateFormat.Hms().format(DateTime.now());
  moneyinput1.type = "รายจ่าย";
  moneyinput1.name = "น้ำโค้ก";
  moneyinput1.amount = 100;
  return [moneyinput, moneyinput1];
}
