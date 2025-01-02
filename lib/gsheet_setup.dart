import 'package:gsheets/gsheets.dart';

var sheetid = "";
var credentials = r'''''';

final gsheets = GSheets(credentials);
var GsheetController;
Worksheet? GsheetCRUDUserDetails;

GSheetsinit() async {
  GsheetController = await gsheets.spreadsheet(sheetid);
  GsheetCRUDUserDetails =
      await GsheetController.worksheetByTitle("27/11-27/12");
}



