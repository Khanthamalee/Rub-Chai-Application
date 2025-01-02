import 'gsheet_setup.dart';

InsertDataIntoGSheet(data) async {
  print(data[0]["topic"]);
  // if (data == "รายรับ") {
  //   data = {
  //     "topic": data.topic,
  //     "date": DateTime.now(),
  //     "name": data.name,
  //     "typeI": data.type,
  //     "typeE": "",
  //     "amount": data.amount,
  //     "note": data.note
  //   };
  // } else {
  //   data = {
  //     "topic": data.topic,
  //     "date": DateTime.now(),
  //     "name": data.name,
  //     "typeI": "",
  //     "typeE": data.type,
  //     "amount": data.amount,
  //     "note": data.note
  //   };
  // }
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
