import 'dart:io';
import 'package:incomeandexpansesapp/page/Provider/financeProvider.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../gsheet_CRUD.dart';

class FinanceDB {
  //บริการเกี่ยวกับข้อมูล
  String dbname; //ตั้งชื่อฐานข้อมูล

  //ถ้ายังไม่ถูกสร้าง => สร้าง
  //ถูกสร้างแล้ว => เปิด
  FinanceDB({required this.dbname});

  //หาตำแหน่งที่จัดเก็บข้อมูล
  // Future<String> openDatabase() async {
  //   Directory financeDirectory = await getApplicationCacheDirectory();
  //   String dbLocation = join(financeDirectory.path, dbname);
  //   return dbLocation;
  // }

  Future<Database> openDatabase() async {
    //หาตำแหน่งที่จัดเก็บข้อมูล
    Directory financeDirectory = await getApplicationCacheDirectory();
    String dbLocation = join(financeDirectory.path, dbname);

    //สร้าง database ใน dbLocation
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Future<Database> db = dbFactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล
  Future<int> InsertData(FinanceVariable data) async {
    //บันทึกข้อมูล ส่งเข้า store in database

    //เรียกฐานข้อมูล
    var db = await this.openDatabase();
    //เรียก store
    var store = intMapStoreFactory.store("income-expense");

    //เอาข้อมูลจาก form Alertdialog มาจัดเรียงเป็น แล้วเก็บไว้ในตัวแปร KeyID
    var KeyID = store.add(db, {
      "topic": data.topic.toString(),
      "datetime": data.datetime.toString(),
      "timeStamp": data.timeStamp.toString(),
      "type": data.type,
      "name": data.name,
      "amount": data.amount,
      "note": data.note
    });
    db.close();
    return KeyID;
  }

  //update data
  Future UpdateData(int dataId, FinanceVariable data) async {
    //เรียกฐานข้อมูล
    var db = await this.openDatabase();
    //เรียก store
    var store = intMapStoreFactory.store("income-expense").record(dataId);
    print("data in Updatedata : ${dataId}");
    await store.update(db, {
      "id": data.id,
      "topic": data.topic,
      "datetime": data.datetime.toString(),
      "timeStamp": data.timeStamp.toString(),
      "type": data.type,
      "name": data.name,
      "amount": data.amount,
      "note": data.note
    });
    db.close();
  }

  //ดึงข้อมูล
  Future<List<FinanceVariable>> LoadAllData() async {
    //เรียกฐานข้อมูล
    var db = await this.openDatabase();

    //เรียก store
    var store = intMapStoreFactory.store("income-expense");

    //ข้อมูลจะออกมาในรูปแบบ <List<RecordSnapshot<int, Map<String, Object?>>>>
    //finder: Finder(sortOrders: [SortOrder(Field.key, false)]) = เรียงข้อมูลจากใหม่ไปเก่า ใช้ false
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));

    List<FinanceVariable> financeList = FinanceProvider().FinanceList;
    for (var Record in snapshot) {
      int id = Record.key;
      String topic = Record.value["topic"].toString();
      DateTime dtConvert = DateTime.parse(Record.value["datetime"].toString());
      DateTime tsConvert = DateTime.parse(Record.value["timeStamp"].toString());
      String type = Record.value["type"].toString();
      String name = Record.value["name"].toString();
      double amount = double.parse(Record.value["amount"].toString());
      String note = Record.value["note"].toString();

      financeList.add(
        FinanceVariable(
            id: id.toString(),
            topic: topic,
            datetime: dtConvert,
            timeStamp: tsConvert,
            type: type,
            name: name,
            amount: amount,
            note: note),
      );
    }

    return financeList;
  }

  //ลบข้อมูล
  Future deleteData(int dataId) async {
    //เรียกฐานข้อมูล
    var db = await this.openDatabase();
    //เรียก store
    var store = intMapStoreFactory.store("income-expense");
    await store.record(dataId).delete(
          db,
        );
    LoadAllData();
  }

  //จัดเรียงข้อมูลให้อยู่ในรูป Map<String,dynamic>DayData
  Future QueryDayData() async {
    //เรียกฐานข้อมูล
    var db = await this.openDatabase();
    //เรียก store
    var store = intMapStoreFactory.store("income-expense");

    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));
  }

  //จัดเรียงข้อมูลเอาลง chart
  Future<List<FinanceVariable>> LoadDAtaToChart() async {
    //เรียกฐานข้อมูล
    var db = await this.openDatabase();

    //เรียก store
    var store = intMapStoreFactory.store("income-expense");

    //ข้อมูลจะออกมาในรูปแบบ <List<RecordSnapshot<int, Map<String, Object?>>>>
    //finder: Finder(sortOrders: [SortOrder(Field.key, false)]) = เรียงข้อมูลจากใหม่ไปเก่า ใช้ false
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [SortOrder(Field.key, false)]));

    List<FinanceVariable> financeList = FinanceProvider().FinanceList;
    for (var Record in snapshot) {
      int id = Record.key;
      String topic = Record.value["topic"].toString();
      DateTime dtConvert = DateTime.parse(Record.value["datetime"].toString());
      DateTime tsConvert = DateTime.parse(Record.value["timeStamp"].toString());
      String type = Record.value["type"].toString();
      String name = Record.value["name"].toString();
      double amount = double.parse(Record.value["amount"].toString());
      String note = Record.value["note"].toString();

      financeList.add(
        FinanceVariable(
            id: id.toString(),
            topic: topic,
            datetime: dtConvert,
            timeStamp: tsConvert,
            type: type,
            name: name,
            amount: amount,
            note: note),
      );
    }
    return financeList;
  }
}
