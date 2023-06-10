import 'dart:io';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/credit_book_functions.dart';
import 'package:smartwalletx/models/customers_model.dart';
import 'package:smartwalletx/screens/credit_book_section/screen_add_customer.dart';
import 'package:smartwalletx/screens/credit_book_section/screen_transactions.dart';

class ViewCreditBookScreen extends StatefulWidget {
  const ViewCreditBookScreen({super.key});

  @override
  State<ViewCreditBookScreen> createState() => _ViewCreditBookScreenState();
}

class _ViewCreditBookScreenState extends State<ViewCreditBookScreen> {
  final searchcontroller = TextEditingController(text: '');

  List<CustomersModel> customerModel = [];
  FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    searchedList();
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      floatingActionButton: addcardfloating(
          mediaquery,
          context,
          'Add Customer',
          Icons.person_add_alt_outlined,
          const AddEditCustomerScreen(
            isEditting: false,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: mediaquery.size.height * 0.025,
            ),
            appbarwithouttrail(
                'assets/back_arrow.png', 'View Credit Book', context),
            SizedBox(
              height: mediaquery.size.height * 0.06,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaquery.size.width * 0.057),
              child: Row(
                children: const [
                  Text(
                    'My Customers',
                    style: TextStyle(fontSize: 21, color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: mediaquery.size.height * 0.02,
            ),
            SizedBox(
                width: mediaquery.size.width * 0.9,
                height: mediaquery.size.height * 0.075,
                child: Neumorphic(
                  style: NeumorphicStyle(
                    shadowLightColor: shadowcolor,
                    color: mycardcolor,
                    depth: -2,
                    intensity: 1,
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: mediaquery.size.width * 0.046),
                  child: Align(
                    alignment: Alignment.center,
                    child: TextField(
                      focusNode: _focusNode,
                      onChanged: (value) {
                        searchedList();
                      },
                      controller: searchcontroller,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search_rounded),
                          hintText: 'Search Here...'),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 58, 58, 58), fontSize: 20),
                    ),
                  ),
                )),
            SizedBox(
              height: mediaquery.size.height * 0.02,
            ),
            Expanded(
                child: CreditBookFunctions.customerNotifier.value.isNotEmpty
                    ? ValueListenableBuilder(
                        valueListenable: CreditBookFunctions.customerNotifier,
                        builder: (context, value, child) {
                          return customerModel.isNotEmpty
                              ? ListView.separated(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: mediaquery.size.width * 0.055,
                                      vertical: mediaquery.size.width * 0.035),
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      height: mediaquery.size.height * 0.11,
                                      width: mediaquery.size.width,
                                      child: NeumorphicButton(
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (ctx) {
                                            return CreditBookTransactionsScreen(
                                                index: index);
                                          }));
                                        },
                                        style: NeumorphicStyle(
                                            shadowLightColor: shadowcolor,
                                            color: background,
                                            shape: NeumorphicShape.flat,
                                            intensity: 1,
                                            depth: 4,
                                            boxShape:
                                                NeumorphicBoxShape.roundRect(
                                                    BorderRadius.circular(15))),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width:
                                                  mediaquery.size.width * 0.04,
                                            ),
                                            CircleAvatar(
                                              radius: 35,
                                              backgroundColor: Colors.black,
                                              child: CircleAvatar(
                                                radius: 33,
                                                backgroundImage: FileImage(File(
                                                    customerModel[index]
                                                        .profilepic)),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  mediaquery.size.width * 0.04,
                                            ),
                                            SizedBox(
                                              width:
                                                  mediaquery.size.width * 0.32,
                                              child: Text(
                                                customerModel[index]
                                                    .customername,
                                                style: floatingbuttontext,
                                              ),
                                            ),
                                            SizedBox(
                                                width: mediaquery.size.width *
                                                    0.2798,
                                                child: calculateSum(index)),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: mediaquery.size.height * 0.03,
                                    );
                                  },
                                  itemCount: customerModel.length)
                              : Center(
                                  child: Text(
                                  'Customer Not Found',
                                  style: notfound,
                                ));
                        },
                      )
                    : Center(
                        child: Text(
                          'Customer List is Empty',
                          style: notfound,
                        ),
                      )),
          ],
        ),
      ),
    );
  }

  void searchedList() {
    setState(() {
      customerModel.clear();
    });
    for (var element in CreditBookFunctions.customerNotifier.value) {
      if (element.customername
          .toLowerCase()
          .contains(searchcontroller.text.toLowerCase())) {
        setState(() {
          customerModel.add(element);
        });
      }
    }
  }

  Widget calculateSum(int index) {
    int? id = CreditBookFunctions.customerNotifier.value[index].id;
    double sum = 0;
    var transactions = [];
    for (var transaction in CreditBookFunctions.transactionNotifier.value) {
      if (transaction.idofperson == id.toString()) {
        transactions.add(transaction);
      }
    }
    for (int i = 0; i < transactions.length; i++) {
      sum = sum + double.parse(transactions[i].amount);
    }
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
      textAlign: TextAlign.right,
      style: TextStyle(
          fontSize: 25,
          overflow: TextOverflow.ellipsis,
          color: sum > 0
              ? const Color.fromARGB(255, 40, 170, 44)
              : const Color.fromARGB(255, 219, 39, 26)),
    );
  }
}
