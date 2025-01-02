import 'gsheet_setup.dart';

void InsertDataIntoGSheet(data) async {
  await GsheetCRUDUserDetails!.values.map.appendRows(data);
  print("Data stored");
}

List DataFromGsheet = [];

void readDatafromGSheet() async {
  DataFromGsheet = (await GsheetCRUDUserDetails!.values.map.allRows())!;
  print("Data Fetched");
  print("DataFromGsheet : ${DataFromGsheet[0]["Date"].runtimeType}");
  print(
      "DataFromGsheet : ${DateTime.fromMicrosecondsSinceEpoch(double.parse(DataFromGsheet[0]["Date"]).toInt())}");
}
