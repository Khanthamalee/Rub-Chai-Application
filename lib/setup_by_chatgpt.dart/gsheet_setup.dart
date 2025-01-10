import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:gsheets/gsheets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/googleapis_auth.dart' show ServiceAccountCredentials;

class GSheetsApi {
  static const _credentialsFile = 'assets/setup/gsheetSetup.json'; // Path to your service account JSON

  static Future<GSheets> _initializeGSheets() async {
    final jsonCredentials = jsonDecode(await rootBundle.loadString(_credentialsFile));
    final credentials = ServiceAccountCredentials.fromJson(jsonCredentials);

    final client = await clientViaServiceAccount(credentials, [
      SheetsApi.spreadsheetsScope,
      DriveApi.driveFileScope,
    ]);

    return GSheets(client);
  }

  static Future<Spreadsheet> _getSpreadsheet(String spreadsheetId) async {
    final gSheets = await _initializeGSheets();
    return await gSheets.spreadsheet(spreadsheetId);
  }

  static Future<void> createData() async {
    final spreadsheetId = 'your_spreadsheet_id'; // Replace with your Google Spreadsheet ID
    final sheet = await _getSpreadsheet(spreadsheetId);

    // Access the first sheet in the spreadsheet
    final worksheet = sheet.worksheetByTitle('Sheet1');
    
    if (worksheet != null) {
      await worksheet.values.appendRow(['Name', 'Age', 'Country']);
      await worksheet.values.appendRow(['Alice', '30', 'USA']);
      await worksheet.values.appendRow(['Bob', '25', 'Canada']);
    }
  }

  static Future<List<List<dynamic>>> readData() async {
    final spreadsheetId = 'your_spreadsheet_id'; // Replace with your Google Spreadsheet ID
    final sheet = await _getSpreadsheet(spreadsheetId);

    // Access the first sheet
    final worksheet = sheet.worksheetByTitle('Sheet1');
    
    if (worksheet != null) {
      return await worksheet.values.allRows();
    }
    return [];
  }

  static Future<void> updateData() async {
    final spreadsheetId = 'your_spreadsheet_id'; // Replace with your Google Spreadsheet ID
    final sheet = await _getSpreadsheet(spreadsheetId);

    // Access the first sheet
    final worksheet = sheet.worksheetByTitle('Sheet1');
    
    if (worksheet != null) {
      // Update the second row (index 1)
      await worksheet.values.updateValue('Updated Alice', 2, 1);  // Row 2, Column 1
      await worksheet.values.updateValue('35', 2, 2);  // Row 2, Column 2
    }
  }

  static Future<void> deleteData() async {
    final spreadsheetId = 'your_spreadsheet_id'; // Replace with your Google Spreadsheet ID
    final sheet = await _getSpreadsheet(spreadsheetId);

    // Access the first sheet
    final worksheet = sheet.worksheetByTitle('Sheet1');
    
    if (worksheet != null) {
      // Delete row 2
      await worksheet.values.deleteRow(2);  // Delete the second row
    }
  }
}
