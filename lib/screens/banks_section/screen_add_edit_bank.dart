import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/bank_functions.dart';
import 'package:smartwalletx/models/bank_model.dart';

class AddEditBank extends StatefulWidget {
  final bool isEditting;
  final int? index;
  static ValueNotifier<String> bankname = ValueNotifier('Axis Bank');
  const AddEditBank({super.key, required this.isEditting, this.index});

  @override
  State<AddEditBank> createState() => _AddEditBankState();
}

class _AddEditBankState extends State<AddEditBank> {
  MyTextField accountnumber = MyTextField();
  final banknamecontroller = TextEditingController();
  MyTextField nameasperpassbook = MyTextField();
  String? accounttype;
  MyTextField linkedmobile = MyTextField();
  MyTextField ifsc = MyTextField();
  MyTextField branchname = MyTextField();

  @override
  void initState() {
    super.initState();
    if (widget.isEditting) {
      setvalues();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: mediaquery.size.height * 0.025,
            ),
            appbarwithouttrail('assets/back_arrow.png',
                widget.isEditting ? 'Edit Bank' : 'Add New Bank', context),
            SizedBox(
              height: mediaquery.size.height * 0.02,
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: mediaquery.size.height * 0.02),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaquery.size.width * 0.03,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: mediaquery.size.height * 0.02,
                    ),
                    Neumorphic(
                        style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            depth: 2,
                            intensity: 1,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(12)),
                            color: mycardcolor),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: mediaquery.size.width * 0.04,
                                vertical: mediaquery.size.height * 0.01),
                            child: Column(children: [
                              SizedBox(
                                height: mediaquery.size.height * 0.02,
                              ),
                              info(context, 'bank'),
                              SizedBox(
                                height: mediaquery.size.height * 0.02,
                              ),
                              const Text(
                                'Bank Details',
                                style: adddetails,
                              ),
                              SizedBox(
                                height: mediaquery.size.height * 0.05,
                              ),
                              addpagelabel('Bank Name'),
                              gapfromtitletotextfield(context),
                              Neumorphic(
                                style: NeumorphicStyle(
                                  color: mycardcolor,
                                  depth: -2,
                                  intensity: 1,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(8)),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: mediaquery.size.height * 0.026,
                                    horizontal: mediaquery.size.width * 0.046),
                                child: TextField(
                                  keyboardType: TextInputType.none,
                                  controller: banknamecontroller,
                                  onTap: () {
                                    selectbank(context);
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: const InputDecoration.collapsed(
                                      hintText: 'Select Bank Name'),
                                ),
                              ),
                              gapfromtextfieldtotitle(context),
                              addpagelabel('Account Number'),
                              gapfromtitletotextfield(context),
                              accountnumber.mytextfield(
                                  context: context,
                                  hint: 'Enter Account Number',
                                  isdigitsonly: true,
                                  limit: 18),
                              gapfromtextfieldtotitle(context),
                              addpagelabel('Name As Per Passbook'),
                              gapfromtitletotextfield(context),
                              nameasperpassbook.mytextfield(
                                  context: context,
                                  hint: 'Enter Name As Per Passbook'),
                              gapfromtextfieldtotitle(context),
                              addpagelabel('Account Type'),
                              gapfromtitletotextfield(context),
                              SizedBox(
                                height: mediaquery.size.height * 0.076,
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    color: mycardcolor,
                                    depth: -2,
                                    intensity: 1,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  padding: EdgeInsets.only(
                                      top: mediaquery.size.height * 0.01,
                                      bottom: 0,
                                      left: mediaquery.size.width * 0.046,
                                      right: mediaquery.size.width * 0.046),
                                  child: TextField(
                                    keyboardType: TextInputType.none,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        suffixIcon: DropdownButtonFormField(
                                            decoration: const InputDecoration(
                                                border: InputBorder.none),
                                            hint: const Text(
                                                'Select Account Type'),
                                            dropdownColor: mycardcolor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            value: accounttype,
                                            items: <String>[
                                              'Current Deposit Account',
                                              'Savings Bank Account',
                                              'Fixed Deposit Account',
                                              'Recurring Deposit Account'
                                            ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                accounttype = newValue!;
                                              });
                                            })),
                                  ),
                                ),
                              ),
                              gapfromtextfieldtotitle(context),
                              addpagelabel('Linked Mobile Number'),
                              gapfromtitletotextfield(context),
                              linkedmobile.mytextfield(
                                  context: context,
                                  hint: 'Enter Linked Mobile Number',
                                  isdigitsonly: true,
                                  limit: 10),
                              gapfromtextfieldtotitle(context),
                              addpagelabel('IFCS Code'),
                              gapfromtitletotextfield(context),
                              ifsc.mytextfield(
                                  context: context,
                                  hint: 'Enter IFSC Code',
                                  limit: 11),
                              gapfromtextfieldtotitle(context),
                              addpagelabel('Branch Name'),
                              gapfromtitletotextfield(context),
                              branchname.mytextfield(
                                  context: context, hint: 'Enter Branch Name'),
                              gapfromtextfieldtotitle(context),
                              NeumorphicButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mediaquery.size.width * 0.055,
                                    vertical: mediaquery.size.height * 0.0135),
                                style: NeumorphicStyle(
                                    boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(10),
                                    ),
                                    depth: 3,
                                    intensity: 1,
                                    color: Colors.green),
                                child: Text(
                                  widget.isEditting == false
                                      ? 'Submit'
                                      : 'Update',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                onPressed: () {
                                  validate();
                                },
                              ),
                              gapfromtitletotextfield(context),
                              gapfromtitletotextfield(context),
                            ]))),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  void validate() {
    if (banknamecontroller.text.isEmpty) {
      emptyfield('Bank Name');
    } else if (accountnumber.controller.text.isEmpty) {
      emptyfield('Account Number');
    } else if (accountnumber.controller.text.length < 9) {
      wrong('Please Enter Valid Account Number');
    } else if (nameasperpassbook.controller.text.isEmpty) {
      emptyfield('Name As Per Passbook');
    } else if (accounttype == null) {
      emptyfield('Account Type');
    } else if (linkedmobile.controller.text.isEmpty) {
      emptyfield('Linked Mobile Number');
    } else if (linkedmobile.controller.text.length < 10) {
      wrong('Please Enter Valid Linked Mobile Number');
    } else if (ifsc.controller.text.isEmpty) {
      emptyfield('IFSC Code');
    } else if (ifsc.controller.text.length < 11) {
      wrong('Please Enter Valid IFSC Code');
    } else if (branchname.controller.text.isEmpty) {
      emptyfield('Branch Name');
    } else {
      widget.isEditting ? update() : submit();
    }
  }

  Future<void> update() async {
    BankModel bankModel = BankModel(
        bankname: banknamecontroller.text.trim(),
        accountnumber: accountnumber.controller.text.trim(),
        nameasperpassbook: nameasperpassbook.controller.text.trim(),
        accounttype: accounttype!,
        linkedmobile: linkedmobile.controller.text.trim(),
        ifsc: ifsc.controller.text.trim(),
        branchname: branchname.controller.text.trim());
    BankFunctions bankFunctions = BankFunctions();
    await bankFunctions.updateBank(bankModel, widget.index!);
    succcess('Bank Details Updated Successfully');
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  Future<void> submit() async {
    BankModel bankModel = BankModel(
        bankname: banknamecontroller.text.trim(),
        accountnumber: accountnumber.controller.text.trim(),
        nameasperpassbook: nameasperpassbook.controller.text.trim(),
        accounttype: accounttype!,
        linkedmobile: linkedmobile.controller.text.trim(),
        ifsc: ifsc.controller.text.trim().toUpperCase(),
        branchname: branchname.controller.text.trim());
    BankFunctions bankFunctions = BankFunctions();
    await bankFunctions.addBank(bankModel);
    succcess('New Bank Added Successfully');
    Navigator.of(context).pop();
  }

  void succcess(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      backgroundColor: const Color.fromARGB(255, 85, 230, 85),
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 2),
    ));
  }

  void emptyfield(String field) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$field field is Empty"),
      backgroundColor: const Color.fromARGB(255, 248, 85, 74),
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 2),
    ));
  }

  void wrong(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: const Color.fromARGB(255, 248, 85, 74),
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 2),
    ));
  }

  Future<dynamic> selectbank(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: mycardcolor,
            title: const Text(
              'Select Your Bank',
              style: TextStyle(fontSize: 18),
            ),
            content: SingleChildScrollView(
              child: ValueListenableBuilder(
                valueListenable: AddEditBank.bankname,
                builder: (context, value, child) {
                  return Column(
                    children: [
                      bankradio(context, 'Axis Bank',
                          'assets/bank_logos/axis_small_logo.png'),
                      bankradio(context, 'Equitas Bank',
                          'assets/bank_logos/equitas_small_logo.png'),
                      bankradio(context, 'Federal Bank',
                          'assets/bank_logos/federal_small_logo.png'),
                      bankradio(context, 'Fi Bank',
                          'assets/bank_logos/fi_small_logo.png'),
                      bankradio(context, 'ICICI Bank',
                          'assets/bank_logos/icici_small_logo.png'),
                      bankradio(context, 'IDBI Bank',
                          'assets/bank_logos/idbi_small_logo.png'),
                      bankradio(context, 'Induslnd Bank',
                          'assets/bank_logos/induslnd_small_logo.png'),
                      bankradio(context, 'Jupiter Bank',
                          'assets/bank_logos/jupiter_small_logo.png'),
                      bankradio(context, 'Kotak Bank',
                          'assets/bank_logos/kotak_small_logo.png'),
                      bankradio(context, 'PayTm Bank',
                          'assets/bank_logos/paytm_small_logo.png'),
                      bankradio(context, 'SBI Bank',
                          'assets/bank_logos/sbi_small_logo.png'),
                      bankradio(context, 'Slice Bank',
                          'assets/bank_logos/slice_small_logo.png'),
                      bankradio(
                          context, 'Other Bank', 'assets/bank_logos/bank.png')
                    ],
                  );
                },
              ),
            ),
            actions: [
              Align(
                alignment: Alignment.center,
                child: NeumorphicButton(
                  style: const NeumorphicStyle(
                    color: Colors.green,
                    intensity: 1,
                    depth: 2,
                  ),
                  onPressed: () {
                    setState(() {
                      banknamecontroller.text = AddEditBank.bankname.value;
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
              gapfromtitletotextfield(context)
            ],
          );
        });
  }

  void setvalues() {
    var list = BankFunctions.banknotifier.value[widget.index!];
    banknamecontroller.text = list.bankname;
    accountnumber.controller.text = list.accountnumber;
    nameasperpassbook.controller.text = list.nameasperpassbook;
    accounttype = list.accounttype;
    linkedmobile.controller.text = list.linkedmobile;
    ifsc.controller.text = list.ifsc;
    branchname.controller.text = list.branchname;
  }
}
