import 'package:smartwalletx/database/data_encrption.dart';

class IdCardModel {
  String name;
  String cardname;
  String cardnumber;
  String additionalinfotitle1;
  String additionalinfoans1;
  String additionalinfotitle2;
  String additionalinfoans2;
  String carddesign;
  String backgrounddesign;

  IdCardModel(
      {required this.name,
      required this.cardname,
      required this.cardnumber,
      required this.additionalinfotitle1,
      required this.additionalinfoans1,
      required this.additionalinfotitle2,
      required this.additionalinfoans2,
      required this.carddesign,
      required this.backgrounddesign});

  static IdCardModel maptomodel(Map<String, Object?> map) {
    XEncryption xEncryption = XEncryption();
    String name = xEncryption.decryptAES(map['name']);
    String cardname = xEncryption.decryptAES(map['cardname']);
    String cardnumber = xEncryption.decryptAES(map['cardnumber']);
    String additionalinfotitle1 =
        xEncryption.decryptAES(map['additionalinfotitle1']);
    String additionalinfoans1 =
        xEncryption.decryptAES(map['additionalinfoans1']);
    String additionalinfotitle2 =
        xEncryption.decryptAES(map['additionalinfotitle2']);
    String additionalinfoans2 =
        xEncryption.decryptAES(map['additionalinfoans2']);
    String carddesign = map['carddesign'] as String;
    String backgrounddesign = map['backgrounddesign'] as String;

    IdCardModel idCardModel = IdCardModel(
        name: name,
        cardname: cardname,
        cardnumber: cardnumber,
        additionalinfotitle1: additionalinfotitle1,
        additionalinfoans1: additionalinfoans1,
        additionalinfotitle2: additionalinfotitle2,
        additionalinfoans2: additionalinfoans2,
        carddesign: carddesign,
        backgrounddesign: backgrounddesign);
    return idCardModel;
  }
}
