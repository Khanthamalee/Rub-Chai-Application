import 'package:gsheets/gsheets.dart';

import 'database/finace_field.dart';

class UserSheetApi {
  static final _sheetid = "";
  static final _credentials = r'''{
"
  }''';

//by https://www.youtube.com/watch?v=3UJ6RnWTGIY

//
  static final _gsheets = GSheets(_credentials);

  static Worksheet? _userSheet;

  static Future GSheetsinit() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_sheetid);
      _userSheet = await _getWorkSheet(spreadsheet, title: "27/11-27/12");
      final firstRow = financeField.getField();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print("init error : $e");
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) {
    _userSheet!.values.map.appendRow(rowList);
  }
}
