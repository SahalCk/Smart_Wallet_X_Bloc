import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/bank_functions.dart';
import 'package:smartwalletx/screens/banks_section/screen_add_edit_bank.dart';

class BankDetailsScreen extends StatefulWidget {
  final int index;
  const BankDetailsScreen({super.key, required this.index});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var list = BankFunctions.banknotifier.value[widget.index];
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: mediaquery.size.height * 0.025,
            ),
            appbarwithdelete('assets/back_arrow.png', '', 'assets/delete.png',
                context, widget.index, 'Bank'),
            SizedBox(
              height: mediaquery.size.height * 0.012,
            ),
            Expanded(
                child: SingleChildScrollView(
                    padding:
                        EdgeInsets.only(bottom: mediaquery.size.height * 0.02),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mediaquery.size.width * 0.03,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: mediaquery.size.height * 0.04,
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
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: mediaquery.size.height * 0.02,
                                        ),
                                        SizedBox(
                                          height: mediaquery.size.height * 0.02,
                                        ),
                                        const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            'Bank Details',
                                            style: adddetails,
                                          ),
                                        ),
                                        SizedBox(
                                          height: mediaquery.size.height * 0.05,
                                        ),
                                        addpagelabel('Bank Name'),
                                        gapfromtitletotext(context),
                                        Text(list.bankname, style: formdetails),
                                        gapfromtextfieldtotitle(context),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                addpagelabel('Account Number'),
                                                gapfromtitletotext(context),
                                                Text(list.accountnumber,
                                                    style: formdetails),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                await Clipboard.setData(
                                                    ClipboardData(
                                                        text: list
                                                            .accountnumber));
                                                copytoclipboard(
                                                    'Account Number');
                                              },
                                              icon: const Icon(
                                                  Icons.content_copy_rounded),
                                              iconSize: 33,
                                            )
                                          ],
                                        ),
                                        gapfromtextfieldtotitle(context),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                addpagelabel(
                                                    'Name As Per Passbook'),
                                                gapfromtitletotext(context),
                                                Text(list.nameasperpassbook,
                                                    style: formdetails),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                await Clipboard.setData(
                                                    ClipboardData(
                                                        text: list
                                                            .nameasperpassbook));
                                                copytoclipboard(
                                                    'Name As Per Passbook');
                                              },
                                              icon: const Icon(
                                                  Icons.content_copy_rounded),
                                              iconSize: 33,
                                            )
                                          ],
                                        ),
                                        gapfromtextfieldtotitle(context),
                                        addpagelabel('Account Type'),
                                        gapfromtitletotext(context),
                                        Text(list.accounttype,
                                            style: formdetails),
                                        gapfromtextfieldtotitle(context),
                                        addpagelabel('Linked Mobile Number'),
                                        gapfromtitletotext(context),
                                        Text(list.linkedmobile,
                                            style: formdetails),
                                        gapfromtextfieldtotitle(context),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                addpagelabel('IFSC Code'),
                                                gapfromtitletotext(context),
                                                Text(list.ifsc,
                                                    style: formdetails),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                await Clipboard.setData(
                                                    ClipboardData(
                                                        text: list.ifsc));
                                                copytoclipboard('IFSC Code');
                                              },
                                              icon: const Icon(
                                                  Icons.content_copy_rounded),
                                              iconSize: 33,
                                            )
                                          ],
                                        ),
                                        gapfromtextfieldtotitle(context),
                                        addpagelabel('Branch Name'),
                                        gapfromtitletotext(context),
                                        Text(list.branchname,
                                            style: formdetails),
                                        gapfromtextfieldtotitle(context),
                                        Align(
                                          alignment: Alignment.center,
                                          child: NeumorphicButton(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    mediaquery.size.width *
                                                        0.055,
                                                vertical:
                                                    mediaquery.size.height *
                                                        0.016),
                                            style: NeumorphicStyle(
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                  BorderRadius.circular(10),
                                                ),
                                                depth: 3,
                                                intensity: 1,
                                                color: const Color.fromARGB(
                                                    255, 60, 106, 190)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: mediaquery.size.width *
                                                      0.015,
                                                ),
                                                const Text(
                                                  'Edit Bank Details',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (ctx) {
                                                return AddEditBank(
                                                  isEditting: true,
                                                  index: widget.index,
                                                );
                                              }));
                                            },
                                          ),
                                        ),
                                        gapfromtitletotext(context),
                                        gapfromtitletotext(context),
                                      ]))),
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }

  void copytoclipboard(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$text Copied to Clipboard"),
      backgroundColor: const Color.fromARGB(255, 52, 118, 206),
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 2),
    ));
  }
}
