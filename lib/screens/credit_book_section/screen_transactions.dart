import 'dart:io';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/credit_book_functions.dart';
import 'package:smartwalletx/models/transactions_model.dart';
import 'package:smartwalletx/screens/credit_book_section/screen_add_customer.dart';
import 'package:sms_mms/sms_mms.dart';

class CreditBookTransactionsScreen extends StatefulWidget {
  final int index;
  const CreditBookTransactionsScreen({super.key, required this.index});

  @override
  State<CreditBookTransactionsScreen> createState() =>
      _CreditBookTransactionsScreenState();
}

class _CreditBookTransactionsScreenState
    extends State<CreditBookTransactionsScreen> {
  double? displayamount;
  final List<TransactionModel> transactions = [];

  final MyTextField amount = MyTextField();

  final MyTextField note = MyTextField();

  final datecontroller = TextEditingController();

  final timecontroller = TextEditingController();

  final CreditBookFunctions creditBookFunctions = CreditBookFunctions();

  @override
  Widget build(BuildContext context) {
    creditBookFunctions.getAllCustomers();
    creditBookFunctions.getAllTransactions();
    setTransactionsList();
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: mediaquery.height * 0.025,
          ),
          ValueListenableBuilder(
              valueListenable: CreditBookFunctions.customerNotifier,
              builder: (context, value, child) {
                return appbarwithdelete(
                    'assets/back_arrow.png',
                    CreditBookFunctions
                        .customerNotifier.value[widget.index].customername,
                    'assets/delete.png',
                    context,
                    widget.index,
                    'Customer');
              }),
          SizedBox(
            height: mediaquery.height * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: mediaquery.width * 0.042),
            child: SizedBox(
              width: mediaquery.width,
              height: mediaquery.height * 0.135,
              child: Neumorphic(
                style: NeumorphicStyle(
                    border: const NeumorphicBorder(width: 1.5),
                    shadowLightColor: shadowcolor,
                    color: background,
                    intensity: 1),
                child: Padding(
                  padding: EdgeInsets.all(mediaquery.width * 0.03),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddEditCustomerScreen(
                                    isEditting: true,
                                    index: widget.index,
                                  )));
                        },
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 38,
                              backgroundColor: Colors.black,
                              child: ValueListenableBuilder(
                                valueListenable:
                                    CreditBookFunctions.customerNotifier,
                                builder: (context, value, child) {
                                  return CircleAvatar(
                                    radius: 36,
                                    backgroundImage: FileImage(File(
                                        CreditBookFunctions.customerNotifier
                                            .value[widget.index].profilepic)),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: mediaquery.height * 0,
                              right: mediaquery.height * 0,
                              child: SizedBox(
                                height: mediaquery.height * 0.035,
                                width: mediaquery.width * 0.07,
                                child: Neumorphic(
                                    style: const NeumorphicStyle(
                                        color:
                                            Color.fromARGB(255, 17, 120, 199),
                                        shape: NeumorphicShape.flat,
                                        boxShape: NeumorphicBoxShape.circle()),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 16,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: mediaquery.width * 0.1,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Remaining Balance',
                            style: TextStyle(
                                fontSize: 20,
                                overflow: TextOverflow.ellipsis,
                                color: Color.fromARGB(255, 35, 128, 204)),
                          ),
                          calculateSum(),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                                shadowLightColor: shadowcolor,
                                color: const Color.fromARGB(255, 35, 128, 204)),
                            onPressed: () {
                              sendReminder([
                                CreditBookFunctions.customerNotifier
                                    .value[widget.index].customerphone
                              ], "Hi ${CreditBookFunctions.customerNotifier.value[widget.index].customername},\nThis is a small reminder that ${displayamount! > 0 ? 'I have to give you' : 'You have to give me'} amount of ${displayamount! > -1 ? '₹$displayamount' : '₹${displayamount.toString().substring(1)}'}");
                            },
                            padding: EdgeInsets.symmetric(
                                horizontal: mediaquery.width * 0.035,
                                vertical: mediaquery.height * 0.004),
                            child: Row(
                              children: [
                                const Text(
                                  'Send Reminder SMS',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17,
                                      overflow: TextOverflow.ellipsis,
                                      color:
                                          Color.fromARGB(255, 243, 243, 243)),
                                ),
                                SizedBox(
                                  width: mediaquery.width * 0.02,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: mediaquery.height * 0.025,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mediaquery.width * 0.042),
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'All Transactions',
                        style: TextStyle(fontSize: 21, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: mediaquery.height * 0.018,
                  ),
                  SizedBox(
                    height: mediaquery.height * 0.497,
                    child: ValueListenableBuilder(
                      valueListenable: CreditBookFunctions.transactionNotifier,
                      builder: (context, value, child) {
                        return transactions.isNotEmpty
                            ? ListView.separated(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mediaquery.width * 0.055,
                                    vertical: mediaquery.width * 0.035),
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    onDismissed: (_) {
                                      showDeleteDialogue(index);
                                    },
                                    background: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                          SizedBox(
                                            width: mediaquery.width * 0.04,
                                          )
                                        ],
                                      ),
                                    ),
                                    child: SizedBox(
                                      height: mediaquery.height * 0.11,
                                      width: mediaquery.width,
                                      child: Neumorphic(
                                        padding: const EdgeInsets.all(0),
                                        style: NeumorphicStyle(
                                            shadowLightColor: shadowcolor,
                                            color: background,
                                            shape: NeumorphicShape.flat,
                                            intensity: 1,
                                            depth: 4,
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                                    BorderRadius.circular(15))),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              mediaquery.width * 0.05),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    transactions[index].note,
                                                    style: TextStyle(
                                                        color: mytextcolor,
                                                        fontSize: 22),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        transactions[index]
                                                            .date,
                                                        style: TextStyle(
                                                            color:
                                                                subtitlecolor,
                                                            fontSize: 17),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            mediaquery.width *
                                                                0.06,
                                                      ),
                                                      Text(
                                                        transactions[index]
                                                            .time,
                                                        style: TextStyle(
                                                            color:
                                                                subtitlecolor,
                                                            fontSize: 17),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                  width:
                                                      mediaquery.width * 0.2798,
                                                  child: checkAmount(
                                                      transactions[index]
                                                          .amount)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: mediaquery.height * 0.03,
                                  );
                                },
                                itemCount: transactions.length)
                            : Center(
                                child: Text(
                                  'Transactions Not Found',
                                  style: notfound,
                                ),
                              );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Neumorphic(
                      style: NeumorphicStyle(
                          shadowLightColor: shadowcolor,
                          color: background,
                          depth: 2,
                          intensity: 1,
                          shape: NeumorphicShape.convex,
                          boxShape: NeumorphicBoxShape.roundRect(
                              const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)))),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: mediaquery.height * 0.012,
                            top: mediaquery.height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: mediaquery.width * 0.4,
                              height: mediaquery.height * 0.065,
                              child: NeumorphicButton(
                                style: NeumorphicStyle(
                                    shadowLightColor: shadowcolor,
                                    color:
                                        const Color.fromARGB(255, 250, 50, 36),
                                    shape: NeumorphicShape.convex,
                                    intensity: 1,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(10))),
                                child: const Center(
                                  child: Text(
                                    'You Gave',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ),
                                onPressed: () {
                                  addTransactionBottomSheet(context, true);
                                },
                              ),
                            ),
                            SizedBox(
                              width: mediaquery.width * 0.4,
                              height: mediaquery.height * 0.065,
                              child: NeumorphicButton(
                                style: NeumorphicStyle(
                                    shadowLightColor: shadowcolor,
                                    color:
                                        const Color.fromARGB(255, 31, 173, 36),
                                    shape: NeumorphicShape.convex,
                                    intensity: 1,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(10))),
                                child: const Center(
                                  child: Text(
                                    'You Got',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  ),
                                ),
                                onPressed: () {
                                  addTransactionBottomSheet(context, false);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Future<dynamic> addTransactionBottomSheet(
      BuildContext bottomSheetContext, bool give) {
    final mediaquery = MediaQuery.of(bottomSheetContext);
    initialSetup();
    return showModalBottomSheet(
      backgroundColor: mycardcolor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      context: bottomSheetContext,
      builder: (context) {
        return Neumorphic(
          padding:
              EdgeInsets.symmetric(horizontal: mediaquery.size.width * 0.05),
          style: NeumorphicStyle(
              color: mycardcolor,
              shape: NeumorphicShape.convex,
              depth: 2,
              boxShape: NeumorphicBoxShape.roundRect(const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(),
              const Text(
                'Add New Transaction',
                style: TextStyle(fontSize: 22),
              ),
              amount.mytextfield(
                  context: context,
                  hint: 'Enter The Amount',
                  isdigitsonly: true,
                  pointsnotallowed: true,
                  limit: 6),
              note.mytextfield(context: context, hint: 'Enter The Reason/Note'),
              Neumorphic(
                style: NeumorphicStyle(
                  color: mycardcolor,
                  depth: -2,
                  intensity: 1,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: mediaquery.size.height * 0.026, horizontal: 18),
                child: TextField(
                  controller: datecontroller,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Select The Date'),
                  style:
                      const TextStyle(color: Color.fromARGB(255, 58, 58, 58)),
                  onTap: () async {
                    DateTime? selecteddate2 = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now());

                    String modified = selecteddate2.toString().substring(0, 10);
                    datecontroller.text =
                        '${modified.substring(8, 10)}/${modified.substring(5, 7)}/${modified.substring(0, 4)}';
                  },
                ),
              ),
              Neumorphic(
                style: NeumorphicStyle(
                  color: mycardcolor,
                  depth: -2,
                  intensity: 1,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: mediaquery.size.height * 0.026, horizontal: 18),
                child: TextField(
                  controller: timecontroller,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.none,
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Select The Time'),
                  style:
                      const TextStyle(color: Color.fromARGB(255, 58, 58, 58)),
                  onTap: () async {
                    final TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime: const TimeOfDay(hour: 12, minute: 00));

                    timecontroller.text = formatTime(selectedTime!);
                  },
                ),
              ),
              NeumorphicButton(
                padding: EdgeInsets.all(mediaquery.size.height * 0.016),
                style: NeumorphicStyle(
                    color: give ? Colors.red : Colors.green,
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(10))),
                child: const Text('Add Transaction',
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () {
                  addTransaction(give, bottomSheetContext);
                },
              )
            ],
          ),
        );
      },
    );
  }

  String formatTime(TimeOfDay time) {
    String period = 'AM';
    int hour = time.hourOfPeriod;
    int minute = time.minute;
    if (time.period == DayPeriod.pm) {
      period = 'PM';
    }
    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute $period';
  }

  void initialSetup() {
    final currentDate = DateTime.now().toString();
    datecontroller.text =
        '${currentDate.substring(8, 10)}/${currentDate.substring(5, 7)}/${currentDate.substring(0, 4)}';
    final currentTime = TimeOfDay.now();
    timecontroller.text = formatTime(currentTime);
  }

  Future<void> addTransaction(
      bool give, BuildContext bottomSheetContext) async {
    if (amount.controller.text.isEmpty) {
      wrong('Amount Field is Empty', bottomSheetContext);
    } else if (amount.controller.text == '0') {
      wrong('Please Enter An Amount Greate Than 0', bottomSheetContext);
    } else if (note.controller.text.isEmpty) {
      wrong('Reason/Note Field is Empty', bottomSheetContext);
    } else if (datecontroller.text.isEmpty) {
      wrong('Date Field is Empty', bottomSheetContext);
    } else if (timecontroller.text.isEmpty) {
      wrong('Time Field is Empty', bottomSheetContext);
    } else {
      TransactionModel transactionModel = TransactionModel(
          amount: give ? '-${amount.controller.text}' : amount.controller.text,
          note: note.controller.text,
          date: datecontroller.text,
          time: timecontroller.text,
          idofperson: (widget.index + 1).toString());
      await creditBookFunctions.addTransaction(transactionModel);
      amount.controller.text = '';
      note.controller.text = '';
      datecontroller.text = '';
      timecontroller.text = '';
      succcess(bottomSheetContext);
      setState(() {
        setTransactionsList();
      });
      Navigator.pop(bottomSheetContext);
    }
  }

  void wrong(String message, BuildContext bottomSheetContext) {
    ScaffoldMessenger.of(bottomSheetContext).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: const Color.fromARGB(255, 248, 85, 74),
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 2),
    ));
  }

  void succcess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Transaction Added Successfully'),
      backgroundColor: Color.fromARGB(255, 85, 230, 85),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
    ));
  }

  void setTransactionsList() {
    int? id = CreditBookFunctions.customerNotifier.value[widget.index].id;
    transactions.clear();
    for (var transaction in CreditBookFunctions.transactionNotifier.value) {
      if (transaction.idofperson == id.toString()) {
        transactions.add(transaction);
      }
    }
  }

  Widget checkAmount(String amount) {
    if (amount[0] == '-') {
      return Text(
        double.parse(amount.substring(1)) > 99999
            ? '${amount.substring(0, 1)}₹${amount[1]}.${amount[2]}L'
            : '${amount.substring(0, 1)}₹${amount.substring(1)}',
        textAlign: TextAlign.end,
        style: const TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 219, 39, 26),
            overflow: TextOverflow.ellipsis),
      );
    } else {
      return Text(
        double.parse(amount) > 99999
            ? '+₹${amount[0]}.${amount[1]}L'
            : '+₹$amount',
        textAlign: TextAlign.end,
        style: const TextStyle(
            fontSize: 25,
            color: Color.fromARGB(255, 40, 170, 44),
            overflow: TextOverflow.ellipsis),
      );
    }
  }

  Widget calculateSum() {
    double sum = 0;
    for (int i = 0; i < transactions.length; i++) {
      sum = sum + double.parse(transactions[i].amount);
    }
    displayamount = sum;
    String text = '';

    if (sum > 0) {
      text = '₹${sum.toString()}';
      if (text[text.length - 3] == '0') {
        text = text.substring(0, text.length - 2);
      }
    } else if (sum < 0) {
      text = '-₹${sum.toString().substring(1)}';
      if (text[text.length - 3] == '0') {
        text = text.substring(0, text.length - 2);
      }
    } else {
      text = '₹0.0';
      if (text[text.length - 3] == '0') {
        text = text.substring(0, text.length - 2);
      }
    }
    return Text(
      text,
      style: TextStyle(
          fontSize: 23,
          overflow: TextOverflow.ellipsis,
          color: sum > 0
              ? const Color.fromARGB(255, 40, 170, 44)
              : const Color.fromARGB(255, 219, 39, 26)),
    );
  }

  void sendReminder(List<String> recipients, String message) async {
    await SmsMms.send(recipients: recipients, message: message);
    succcessSMS();
  }

  void succcessSMS() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          'Reminder SMS Sent Successfully to ${CreditBookFunctions.customerNotifier.value[widget.index].customername}'),
      backgroundColor: Colors.blue,
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 2),
    ));
  }

  void showDeleteDialogue(int index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: mycardcolor,
            title: const Text('Do you want to delete the Transaction'),
            content: const Text(
              'The Translation will be cleared from the database',
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    CreditBookFunctions.transactionNotifier.notifyListeners();
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () async {
                    await creditBookFunctions.deleteTransaction(index);
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }
}
