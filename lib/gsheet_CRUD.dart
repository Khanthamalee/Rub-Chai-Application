import 'gsheet_setup.dart';

//U
UpdateDataIntoGSheet(finance data) async {
  print("in datafromGsheet ${data.id}");
  await _getWorkSheet?.values.map.insertRowByKey("${data.id}", {
    'Id': data.id,
    'Topic': data.topic,
    'Date': data.date,
    'Timestamp': data.timestamp,
    'Name': data.name,
    'Income': data.income,
    'Expense': data.expense,
    'Balance': data.balance,
    'Note': data.note
  });
  print("Data Update");
  readDatafromGSheet();
}

//C
Insert(finance data) async {
  print(data.topic);
  await _getWorkSheet!.values.map.appendRows([
    {
      'Id': data.id,
      'Topic': data.topic,
      'Date': data.date,
      'Timestamp': data.timestamp,
      'Name': data.name,
      'Income': data.income,
      'Expense': data.expense,
      'Balance': data.balance,
      'Note': data.note
    }
  ]);
  print("Data stored");
}

List DataFromGsheet = [];
List<finance> datafromGsheet = [];

//R
readDatafromGSheet() async {
  DataFromGsheet = (await _getWorkSheet!.values.map.allRows())!;
}

//D
deleteDatafromGSheet(String key) async {
  final index = await _getWorkSheet!.values.rowIndexOf(key);
  await _getWorkSheet!.deleteRow(index);
  print("Row Deleted");
}
