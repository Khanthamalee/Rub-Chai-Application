import 'package:gsheets/gsheets.dart';

import 'database/finace_field.dart';
import 'database/financedata.dart';

class UserSheetApi {
  static final _sheetid = "";
  static final _credentials = r'''{
}''';

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

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }

  static Future<List<Finance>> getAll() async {
    if (_userSheet == null) return <Finance>[];
    final finance = await _userSheet!.values.map.allRows();
    return finance == null
        ? <Finance>[]
        : finance.map(Finance.fromJson).toList();
  }

  static Future<Finance?> getByID(String id) async {
    if (_userSheet == null) return null;
    final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : Finance.fromJson(json);
  }

  static Future<bool> updateByID(String id, Map<String, dynamic> list) async {
    if (_userSheet == null) return false;
    return _userSheet!.values.map.insertRowByKey(id, list);
  }

  static Future<bool> deleteByID(String id) async {
    if (_userSheet == null) return false;
    final index = await _userSheet!.values.rowIndexOf(id);
    if (index == -1) return false;
    return _userSheet!.deleteRow(index);
  }
}
