import 'gsheet_setup.dart';

InsertDataIntoGSheet(data) async {
  await GsheetCRUDUserDetails!.values.map.appendRows(data);
  print("Data stored");
}

List DataFromGsheet = [];
Map<String, List<dynamic>> Data = {};
readDatafromGSheet() async {
  DataFromGsheet = (await GsheetCRUDUserDetails!.values.map.allRows())!;
  print("data fetcheds");
}

UpdateDatafromGSheet(int id, Map<String, dynamic> database) async {
  print("id, $id");
  print("database : $database");
  await GsheetCRUDUserDetails!.values.map.insertRowByKey(id, database);
  print("Data updated");
}
