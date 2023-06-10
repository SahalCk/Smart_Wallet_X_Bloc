import 'dart:io';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartwalletx/database/data_encrption.dart';
import 'package:smartwalletx/models/customers_model.dart';
import 'package:smartwalletx/models/transactions_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class CreditBookFunctions {
  static ValueNotifier<List<CustomersModel>> customerNotifier =
      ValueNotifier([]);
  static ValueNotifier<List<TransactionModel>> transactionNotifier =
      ValueNotifier([]);
  XEncryption xEncryptionx = XEncryption();

  Future<void> createCreditBookDB(sql.Database db) async {
    await db.execute(
        """CREATE TABLE customers_table (id INTEGER PRIMARY KEY, customername TEXT, customerphone TEXT, customerwhatsapp TEXT, profilepic TEXT)""");
    await db.execute(
        """CREATE TABLE transactions (id INTEGER PRIMARY KEY, amount TEXT, note TEXT, date TEXT, time TEXT,customerid TEXT)""");
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
    int id = await db.insert('customers_table', data);
    customersModel.id = id;
    CreditBookFunctions.customerNotifier.value.add(customersModel);
    CreditBookFunctions.customerNotifier.notifyListeners();
  }

  Future<void> updateCustomer(CustomersModel customersModel, int index) async {
    final db = await openCreditBookDB();
    await db.rawUpdate(
        'UPDATE customers_table SET '
        'customername = ?,'
        'customerphone = ?,'
        'customerwhatsapp = ?,'
        'profilepic = ?'
        'WHERE id = ?',
        [
          xEncryptionx.encryptAES(customersModel.customername),
          xEncryptionx.encryptAES(customersModel.customerphone),
          xEncryptionx.encryptAES(customersModel.customerwhatsapp),
          xEncryptionx.encryptAES(customersModel.profilepic),
          index + 1
        ]);
    await getAllCustomers();
  }

  Future<void> addTransaction(TransactionModel transactionModel) async {
    final db = await openCreditBookDB();
    var data = {
      'amount': xEncryptionx.encryptAES(transactionModel.amount),
      'note': xEncryptionx.encryptAES(transactionModel.note),
      'date': xEncryptionx.encryptAES(transactionModel.date),
      'time': xEncryptionx.encryptAES(transactionModel.time),
      'customerid': xEncryptionx.encryptAES(transactionModel.idofperson)
    };
    await db.insert('transactions', data);
    transactionNotifier.value.add(transactionModel);
    transactionNotifier.notifyListeners();
  }

  Future<void> deleteCustomer(int index) async {
    final db = await openCreditBookDB();
    await db.rawDelete('DELETE FROM customers_table WHERE id = ?', [index + 1]);
    await db.rawDelete('DELETE FROM transactions WHERE customerid = ?',
        [xEncryptionx.encryptAES((index + 1).toString())]);
    await getAllCustomers();
    await getAllTransactions();
  }

  Future<void> deleteTransaction(int index) async {
    final db = await openCreditBookDB();
    await db.rawDelete('DELETE FROM transactions WHERE id = ?', [index + 1]);
    await getAllTransactions();
  }

  Future<void> getAllCustomers() async {
    final db = await openCreditBookDB();
    var value = await db.query('customers_table', orderBy: "id");
    customerNotifier.value.clear();
    for (int index = 0; index < value.length; index++) {
      CustomersModel customerModel =
          CustomersModel.maptoCustomerModel(value[index]);
      CreditBookFunctions.customerNotifier.value.add(customerModel);
      CreditBookFunctions.customerNotifier.notifyListeners();
    }
  }

  Future<void> getAllTransactions() async {
    final db = await openCreditBookDB();
    var value = await db.query('transactions', orderBy: "id");
    CreditBookFunctions.transactionNotifier.value.clear();
    for (var transaction in value) {
      TransactionModel transactionModel =
          TransactionModel.maptoTransactionModel(transaction);
      CreditBookFunctions.transactionNotifier.value.add(transactionModel);
      CreditBookFunctions.transactionNotifier.notifyListeners();
    }
  }

  Future<void> deleteDatabase() async {
    final database = await openCreditBookDB();
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/creditbookDB';
    await database.close();
    await sql.deleteDatabase(path);
  }
}
