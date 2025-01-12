import 'dart:core';
import 'dart:math';
import 'database/financedata.dart';

List<Finance> finances = [];
List<Finance> getfinances() => finances;
Set<String> setTopic = Set();
Set<String> getlistTopic() => setTopic;
//Create


void randomID() async {
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
  print("ID in saveDataToGoogleSheet : ${ID}");
}

returnlistTopic(List<Finance> data) async {
  setTopic = Set();
  if (data.isNotEmpty) {
    setTopic = Set();
    for (var listdata in data) {
      var topic = listdata.topic;

      setTopic.add(topic.toString());
    }
  } else {
    setTopic = Set();
  }
  print("setTopic in returnlistTopic :  ${setTopic}");
  print("returnlistTopic");
  return setTopic;
}

//Read
// Future getFinance() async {
//   finances = await UserSheetApi.getAll();
//   print("finances in getFinance : $finances");
// }
// Future getFinance(String id) async {
//   final finance = await UserSheetApi.getByID(id);
//   print(finance!.toJson());

//   setState(() {
//     this.finance = finance;
//   });
// }

//U
// UpdateDataIntoGSheet(Finance data) async {
//   print("in datafromGsheet ${data.id}");
//   await _getWorkSheet?.values.map.insertRowByKey("${data.id}", {
//     'Id': data.id,
//     'Topic': data.topic,
//     'Date': data.date,
//     'Timestamp': data.timestamp,
//     'Name': data.name,
//     'Income': data.income,
//     'Expense': data.expense,
//     'Balance': data.balance,
//     'Note': data.note
//   });
//   print("Data Update");
//   readDatafromGSheet();
// }

// List DataFromGsheet = [];
// List<finance> datafromGsheet = [];

// //D
// deleteDatafromGSheet(String key) async {
//   final index = await _getWorkSheet!.values.rowIndexOf(key);
//   await _getWorkSheet!.deleteRow(index);
//   print("Row Deleted");
// }
