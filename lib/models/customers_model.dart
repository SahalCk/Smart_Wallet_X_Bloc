import 'package:smartwalletx/database/data_encrption.dart';

class CustomersModel {
  String customername;
  String customerphone;
  String customerwhatsapp;
  String profilepic;

  CustomersModel(
      {required this.customername,
      required this.customerphone,
      required this.customerwhatsapp,
      required this.profilepic});

  static CustomersModel maptoCustomerModel(Map<String, Object?> map) {
    XEncryption xEncryption = XEncryption();
    String customername = xEncryption.decryptAES(map["customername"]);
    String customerphone = xEncryption.decryptAES(map["customerphone"]);
    String customerwhatsapp = xEncryption.decryptAES(map["customerwhatsapp"]);
    String profilepic = xEncryption.decryptAES(map["profilepic"]);

    CustomersModel customersModel = CustomersModel(
        customername: customername,
        customerphone: customerphone,
        customerwhatsapp: customerwhatsapp,
        profilepic: profilepic);
    return customersModel;
  }
}
