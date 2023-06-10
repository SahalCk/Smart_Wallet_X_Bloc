import 'package:smartwalletx/database/data_encrption.dart';

class TransactionModel {
  String amount;
  String note;
  String date;
  String time;
  String idofperson;

  TransactionModel(
      {required this.amount,
      required this.note,
      required this.date,
      required this.time,
      required this.idofperson});

  static TransactionModel maptoTransactionModel(Map<String, Object?> map) {
    XEncryption xEncryption = XEncryption();
    String amount = xEncryption.decryptAES(map["amount"]);
    String note = xEncryption.decryptAES(map["note"]);
    String date = xEncryption.decryptAES(map["date"]);
    String time = xEncryption.decryptAES(map["time"]);
    String idofperson = xEncryption.decryptAES(map["customerid"]);

    TransactionModel transactionModel = TransactionModel(
        amount: amount,
        note: note,
        date: date,
        time: time,
        idofperson: idofperson);
    return transactionModel;
  }
}
