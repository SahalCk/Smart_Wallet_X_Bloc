import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartwalletx/database/data_encrption.dart';
import 'package:smartwalletx/models/id_card_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class IdCardFunctions {
  static ValueNotifier<List<IdCardModel>> idcardlist = ValueNotifier([]);
  XEncryption xEncryption = XEncryption();

  Future<void> createTable(sql.Database database) async {
    await database.execute(
        """CREATE TABLE idcards_table (id INTEGER PRIMARY KEY, cardname TEXT, name TEXT, cardnumber TEXT, additionalinfotitle1 TEXT, additionalinfoans1 TEXT, additionalinfotitle2 TEXT, additionalinfoans2 TEXT, carddesign TEXT, backgrounddesign TEXT)""");
  }

  Future<sql.Database> openIDcardDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return sql.openDatabase(
      '${directory.path}/idcardsDB',
      version: 1,
      onCreate: (sql.Database db, int version) async {
        await createTable(db);
      },
    );
  }

  Future<void> addIdCard(IdCardModel idCardModel) async {
    final db = await openIDcardDataBase();
    final data = {
      'cardname': xEncryption.encryptAES(idCardModel.cardname),
      'name': xEncryption.encryptAES(idCardModel.name),
      'cardnumber': xEncryption.encryptAES(idCardModel.cardnumber),
      'additionalinfotitle1':
          xEncryption.encryptAES(idCardModel.additionalinfotitle1),
      'additionalinfoans1':
          xEncryption.encryptAES(idCardModel.additionalinfoans1),
      'additionalinfotitle2':
          xEncryption.encryptAES(idCardModel.additionalinfotitle2),
      'additionalinfoans2':
          xEncryption.encryptAES(idCardModel.additionalinfoans2),
      'carddesign': idCardModel.carddesign,
      'backgrounddesign': idCardModel.backgrounddesign
    };
    idcardlist.value.add(idCardModel);
    idcardlist.notifyListeners();
    await db.insert('idcards_table', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  Future<void> idCardUpdate(IdCardModel idCardModel, int index) async {
    final db = await openIDcardDataBase();
    await db.rawUpdate(
        'UPDATE idcards_table SET '
        'cardname = ?,'
        'name = ?,'
        'cardnumber = ?,'
        'additionalinfotitle1 = ?,'
        'additionalinfoans1 = ?,'
        'additionalinfotitle2 = ?,'
        'additionalinfoans2 = ?,'
        'carddesign = ?,'
        'backgrounddesign = ?'
        'WHERE id = ?',
        [
          xEncryption.encryptAES(idCardModel.cardname),
          xEncryption.encryptAES(idCardModel.name),
          xEncryption.encryptAES(idCardModel.cardnumber),
          xEncryption.encryptAES(idCardModel.additionalinfotitle1),
          xEncryption.encryptAES(idCardModel.additionalinfoans1),
          xEncryption.encryptAES(idCardModel.additionalinfotitle2),
          xEncryption.encryptAES(idCardModel.additionalinfoans2),
          idCardModel.carddesign,
          idCardModel.backgrounddesign,
          index + 1,
        ]);
    await getallallIdcards();
  }

  Future<void> deleteIdCard(String cardnumber) async {
    final db = await openIDcardDataBase();
    await db.rawDelete('DELETE FROM idcards_table WHERE cardnumber = ?',
        [xEncryption.encryptAES(cardnumber)]);
    getallallIdcards();
  }

  Future<void> getallallIdcards() async {
    final db = await openIDcardDataBase();
    var values = await db.query('idcards_table', orderBy: "id");
    idcardlist.value.clear();
    for (int i = 0; i < values.length; i++) {
      final idcard = IdCardModel.maptomodel(values[i]);
      idcardlist.value.add(idcard);
      idcardlist.notifyListeners();
    }
  }

  Future<void> deleteDatabase() async {
    final database = await openIDcardDataBase();
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/idcardsDB';
    await database.close();
    await sql.deleteDatabase(path);
  }
}
