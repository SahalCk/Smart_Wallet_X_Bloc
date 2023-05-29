import 'dart:io';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartwalletx/database/data_encrption.dart';
import 'package:smartwalletx/models/bank_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class BankFunctions {
  static ValueNotifier<List<BankModel>> banknotifier = ValueNotifier([]);
  XEncryption xEncryption = XEncryption();

  Future<void> createBankDB(sql.Database database) async {
    await database.execute(
        """CREATE TABLE banks_table (id INTEGER PRIMARY KEY,bankname TEXT,accountnumber TEXT,nameasperpassbook TEXT,accounttype TEXT,linkedmobile TEXT,ifsc TEXT,branchname TEXT)""");
  }

  Future<sql.Database> openBankDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return sql.openDatabase(
      '${directory.path}/BankDB',
      version: 1,
      onCreate: (sql.Database db, int version) async {
        await createBankDB(db);
      },
    );
  }

  Future<void> addBank(BankModel bankModel) async {
    final db = await openBankDB();
    var data = {
      'bankname': xEncryption.encryptAES(bankModel.bankname),
      'accountnumber': xEncryption.encryptAES(bankModel.accountnumber),
      'nameasperpassbook': xEncryption.encryptAES(bankModel.nameasperpassbook),
      'accounttype': xEncryption.encryptAES(bankModel.accounttype),
      'linkedmobile': xEncryption.encryptAES(bankModel.linkedmobile),
      'ifsc': xEncryption.encryptAES(bankModel.ifsc),
      'branchname': xEncryption.encryptAES(bankModel.branchname)
    };
    BankFunctions.banknotifier.value.add(bankModel);
    BankFunctions.banknotifier.notifyListeners();
    await db.insert('banks_table', data);
  }

  Future<void> updateBank(BankModel bankModel, int index) async {
    final db = await openBankDB();
    await db.rawUpdate(
        'UPDATE banks_table SET '
        'bankname = ?,'
        'accountnumber = ?,'
        'nameasperpassbook = ?,'
        'accounttype = ?,'
        'linkedmobile = ?,'
        'ifsc = ?,'
        'branchname = ?'
        ' WHERE id = ?',
        [
          xEncryption.encryptAES(bankModel.bankname),
          xEncryption.encryptAES(bankModel.accountnumber),
          xEncryption.encryptAES(bankModel.nameasperpassbook),
          xEncryption.encryptAES(bankModel.accounttype),
          xEncryption.encryptAES(bankModel.linkedmobile),
          xEncryption.encryptAES(bankModel.ifsc),
          xEncryption.encryptAES(bankModel.branchname),
          index + 1
        ]);
    await getAllBanks();
  }

  Future<void> deleteBank(int index) async {
    final db = await openBankDB();
    await db.rawDelete('DELETE FROM banks_table WHERE id = ?', [index + 1]);
    getAllBanks();
  }

  Future<void> getAllBanks() async {
    final db = await openBankDB();
    var values = await db.query('banks_table', orderBy: "id");
    banknotifier.value.clear();
    for (int i = 0; i < values.length; i++) {
      final bank = BankModel.maptomodel(values[i]);
      banknotifier.value.add(bank);
      banknotifier.notifyListeners();
    }
  }

  Future<void> deleteBanksDB() async {
    final database = await openBankDB();
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/BankDB';
    await database.close();
    await sql.deleteDatabase(path);
  }
}
