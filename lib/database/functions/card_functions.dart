import 'dart:io';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartwalletx/database/data_encrption.dart';
import 'package:smartwalletx/models/card_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class CardFunctions {
  static ValueNotifier<List<CardModel>> cardNotifier = ValueNotifier([]);
  static XEncryption xEncryptionx = XEncryption();

  static Future<void> createcardtable(sql.Database database) async {
    await database.execute(
        """CREATE TABLE cards_table (id INTEGER PRIMARY KEY, cardholdername TEXT, cardnumber TEXT, cvv TEXT, validfrom TEXT, validthru TEXT,cardtype TEXT, bankname TEXT, cardcolor TEXT, cardtextcolor TEXT,paymentnetwork TEXT)""");
  }

  static Future<sql.Database> openCardDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return sql.openDatabase(
      '${directory.path}/cardsDB',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createcardtable(database);
      },
    );
  }

  static Future<int> addcard(CardModel newcard) async {
    final db = await CardFunctions.openCardDB();
    final data = {
      'cardholdername': xEncryptionx.encryptAES(newcard.cardholdername),
      'cardnumber': xEncryptionx.encryptAES(newcard.cardnumber),
      'cvv': xEncryptionx.encryptAES(newcard.cvv),
      'validfrom': xEncryptionx.encryptAES(newcard.validfrom),
      'validthru': xEncryptionx.encryptAES(newcard.validthru),
      'cardtype': xEncryptionx.encryptAES(newcard.cardtype),
      'bankname': xEncryptionx.encryptAES(newcard.bankname),
      'cardcolor': newcard.cardcolor,
      'cardtextcolor': newcard.cardtextcolor,
      'paymentnetwork': xEncryptionx.encryptAES(newcard.paymentnetwork),
    };
    cardNotifier.value.add(newcard);
    cardNotifier.notifyListeners();
    final id = await db.insert('cards_table', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<void> deletecard(int index) async {
    final db = await CardFunctions.openCardDB();
    await db.rawDelete('DELETE FROM cards_table WHERE cardnumber = ?',
        [xEncryptionx.encryptAES(cardNotifier.value[index].cardnumber)]);
    cardNotifier.value.removeAt(index);
    cardNotifier.notifyListeners();
  }

  static Future<void> updatecard(int index, CardModel newcard) async {
    final db = await CardFunctions.openCardDB();

    await db.rawUpdate(
      'UPDATE cards_table SET '
      'cardholdername = ?, '
      'cardnumber = ?, '
      'cvv = ?, '
      'validfrom = ?, '
      'validthru = ?, '
      'cardtype = ?, '
      'bankname = ?, '
      'cardcolor = ?, '
      'cardtextcolor = ?, '
      'paymentnetwork = ? '
      'WHERE id = ?',
      [
        xEncryptionx.encryptAES(newcard.cardholdername),
        xEncryptionx.encryptAES(newcard.cardnumber),
        xEncryptionx.encryptAES(newcard.cvv),
        xEncryptionx.encryptAES(newcard.validfrom),
        xEncryptionx.encryptAES(newcard.validthru),
        xEncryptionx.encryptAES(newcard.cardtype),
        xEncryptionx.encryptAES(newcard.bankname),
        newcard.cardcolor,
        newcard.cardtextcolor,
        xEncryptionx.encryptAES(newcard.paymentnetwork),
        index + 1,
      ],
    );
    await CardFunctions.getallcarddatas();
  }

  static Future<void> getallcarddatas() async {
    final db = await CardFunctions.openCardDB();
    final values = await db.query('cards_table', orderBy: "id");
    cardNotifier.value.clear();
    for (int i = 0; i < values.length; i++) {
      final card = CardModel.maptoobject(values[i]);
      cardNotifier.value.add(card);
      cardNotifier.notifyListeners();
    }
  }

  static Future<void> deleteDatabase() async {
    final db = await CardFunctions.openCardDB();
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/cardsDB';
    await db.close();
    await sql.deleteDatabase(path);
  }
}
