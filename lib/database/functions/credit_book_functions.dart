import 'dart:io';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartwalletx/database/data_encrption.dart';
import 'package:smartwalletx/models/customers_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class CreditBookFunctions {
  static ValueNotifier<List<CustomersModel>> customerNotifier =
      ValueNotifier([]);
  XEncryption xEncryptionx = XEncryption();

  Future<void> createCreditBookDB(sql.Database db) async {
    await db.execute(
        """CREATE TABLE customers_table (id INTEGER PRIMARY KEY, customername TEXT, customerphone TEXT, customerwhatsapp TEXT, profilepic TEXT)""");
    await db.execute(
        """CREATE TABLE transactions (id INTEGER PRIMARY KEY, amount TEXT, note TEXT, date TEXT, time TEXT,customername TEXT)""");
  }

  Future<sql.Database> openCreditBookDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return sql.openDatabase(
      '${directory.path}/creditbookDB',
      version: 1,
      onCreate: (sql.Database db, int version) async {
        await createCreditBookDB(db);
      },
    );
  }

  Future<void> addCustomer(CustomersModel customersModel) async {
    final db = await openCreditBookDB();
    var data = {
      'customername': xEncryptionx.encryptAES(customersModel.customername),
      'customerphone': xEncryptionx.encryptAES(customersModel.customerphone),
      'customerwhatsapp':
          xEncryptionx.encryptAES(customersModel.customerwhatsapp),
      'profilepic': xEncryptionx.encryptAES(customersModel.profilepic)
    };
    CreditBookFunctions.customerNotifier.value.add(customersModel);
    CreditBookFunctions.customerNotifier.notifyListeners();
    await db.insert('customers_table', data);
  }

  Future<void> getAllCustomers() async {
    final db = await openCreditBookDB();
    var value = await db.query('customers_table', orderBy: "id");
    customerNotifier.value.clear();
    for (var customer in value) {
      CustomersModel customerModel =
          CustomersModel.maptoCustomerModel(customer);
      CreditBookFunctions.customerNotifier.value.add(customerModel);
      CreditBookFunctions.customerNotifier.notifyListeners();
    }
  }
}
