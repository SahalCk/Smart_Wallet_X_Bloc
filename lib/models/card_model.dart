import 'package:smartwalletx/database/data_encrption.dart';

class CardModel {
  int? id;
  String cardholdername;
  String cardnumber;
  String cvv;
  String validfrom;
  String validthru;
  String cardtype;
  String bankname;
  String cardcolor;
  String cardtextcolor;
  String paymentnetwork;

  CardModel(
      {id,
      required this.cardholdername,
      required this.cardnumber,
      required this.cvv,
      required this.validfrom,
      required this.validthru,
      required this.cardtype,
      required this.bankname,
      required this.cardcolor,
      required this.cardtextcolor,
      required this.paymentnetwork});

  static CardModel maptoobject(Map<String, Object?> map) {
    XEncryption myEncrption = XEncryption();
    final id = map['id'] as int;
    final cardholdername = myEncrption.decryptAES(map['cardholdername']);
    final cardnumber = myEncrption.decryptAES(map['cardnumber']);
    final cvv = myEncrption.decryptAES(map['cvv']);
    final validfrom = myEncrption.decryptAES(map['validfrom']);
    final validthru = myEncrption.decryptAES(map['validthru']);
    final cardtype = myEncrption.decryptAES(map['cardtype']);
    final bankname = myEncrption.decryptAES(map['bankname']);
    final cardcolor = map['cardcolor'] as String;
    final cardtextcolor = map['cardtextcolor'] as String;
    final paymentnetwork = myEncrption.decryptAES(map['paymentnetwork']);

    return CardModel(
        id: id,
        cardholdername: cardholdername,
        cardnumber: cardnumber,
        cvv: cvv,
        validfrom: validfrom,
        validthru: validthru,
        cardtype: cardtype,
        bankname: bankname,
        cardcolor: cardcolor,
        cardtextcolor: cardtextcolor,
        paymentnetwork: paymentnetwork);
  }
}
