import 'package:smartwalletx/database/data_encrption.dart';

class BankModel {
  String bankname;
  String accountnumber;
  String nameasperpassbook;
  String accounttype;
  String linkedmobile;
  String ifsc;
  String branchname;

  BankModel(
      {required this.bankname,
      required this.accountnumber,
      required this.nameasperpassbook,
      required this.accounttype,
      required this.linkedmobile,
      required this.ifsc,
      required this.branchname});

  static BankModel maptomodel(Map<String, Object?> map) {
    XEncryption xEncryption = XEncryption();
    String bankname = xEncryption.decryptAES(map['bankname']);
    String accountnumber = xEncryption.decryptAES(map['accountnumber']);
    String nameasperpassbook = xEncryption.decryptAES(map['nameasperpassbook']);
    String accounttype = xEncryption.decryptAES(map['accounttype']);
    String linkedmobile = xEncryption.decryptAES(map['linkedmobile']);
    String ifsc = xEncryption.decryptAES(map['ifsc']);
    String branchname = xEncryption.decryptAES(map['branchname']);

    BankModel bankModel = BankModel(
        bankname: bankname,
        accountnumber: accountnumber,
        nameasperpassbook: nameasperpassbook,
        accounttype: accounttype,
        linkedmobile: linkedmobile,
        ifsc: ifsc,
        branchname: branchname);
    return bankModel;
  }
}
