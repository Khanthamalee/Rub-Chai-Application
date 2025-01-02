import 'gsheet_setup.dart';

InsertDataIntoGSheet() async {
  await GsheetCRUDUserDetails!.values.map.appendRows(maps);
  print("Data stored");
}
