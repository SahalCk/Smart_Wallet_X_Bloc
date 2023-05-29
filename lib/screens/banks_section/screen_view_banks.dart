import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/bank_functions.dart';
import 'package:smartwalletx/screens/banks_section/screen_add_edit_bank.dart';
import 'package:smartwalletx/screens/banks_section/screen_bank_details.dart';
import 'package:smartwalletx/screens/banks_section/screen_search_bank.dart';

class ViewBanksScreen extends StatefulWidget {
  const ViewBanksScreen({super.key});

  @override
  State<ViewBanksScreen> createState() => _ViewBanksScreenState();
}

class _ViewBanksScreenState extends State<ViewBanksScreen> {
  @override
  Widget build(BuildContext context) {
    BankFunctions bankFunctions = BankFunctions();
    bankFunctions.getAllBanks();
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      floatingActionButton: addcardfloating(
          mediaquery,
          context,
          'Add New Bank',
          Icons.domain_add_rounded,
          const AddEditBank(
            isEditting: false,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: mediaquery.size.height * 0.025,
          ),
          appbarwithouttrail('assets/back_arrow.png', 'View Banks', context),
          SizedBox(
            height: mediaquery.size.height * 0.06,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: mediaquery.size.width * 0.057),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Banks',
                  style: TextStyle(fontSize: 21, color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    showSearch(context: context, delegate: BankSearchScreen());
                  },
                  child: Image.asset(
                    'assets/search.png',
                    width: 21,
                    height: 21,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: mediaquery.size.height * 0.02,
          ),
          Expanded(
              child: ValueListenableBuilder(
            valueListenable: BankFunctions.banknotifier,
            builder: (context, value, child) {
              return value.isNotEmpty
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
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctx) {
                                return BankDetailsScreen(index: index);
                              }));
                            },
                            style: NeumorphicStyle(
                                shadowLightColor: shadowcolor,
                                color: background,
                                shape: NeumorphicShape.flat,
                                intensity: 1,
                                depth: 4,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(15))),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: mediaquery.size.width * 0.05,
                                ),
                                Container(
                                  width: mediaquery.size.width * 0.19,
                                  height: mediaquery.size.height * 0.07,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            mediaquery.size.width * 0.02,
                                        vertical:
                                            mediaquery.size.height * 0.012),
                                    child: Center(
                                      child: bankselecter(index),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: mediaquery.size.width * 0.03,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        BankFunctions
                                            .banknotifier.value[index].bankname,
                                        style: TextStyle(
                                            color: mytextcolor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w800,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      SizedBox(
                                        height: mediaquery.size.height * 0.002,
                                      ),
                                      Text(
                                        BankFunctions.banknotifier.value[index]
                                            .accountnumber,
                                        style: TextStyle(
                                            color: subtitlecolor, fontSize: 20),
                                      )
                                    ],
                                  ),
                                )
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
                      itemCount: BankFunctions.banknotifier.value.length)
                  : Center(
                      child: Text(
                        'Banks Not Found !',
                        style: notfound,
                      ),
                    );
            },
          ))
        ],
      )),
    );
  }

  Widget bankselecter(int index) {
    String bank =
        BankFunctions.banknotifier.value[index].bankname.toLowerCase();

    if (bank.contains('icic')) {
      return Image.asset('assets/bank_logos/icici_small_logo.png');
    } else if (bank.contains('federal')) {
      return Image.asset('assets/bank_logos/federal_small_logo.png');
    } else if (bank.contains('axis')) {
      return Image.asset('assets/bank_logos/axis_full_logo.png');
    } else if (bank.contains('equitas')) {
      return Image.asset('assets/bank_logos/equitas_small_logo.png');
    } else if (bank.contains('fi')) {
      return Image.asset('assets/bank_logos/fi_small_logo.png');
    } else if (bank.contains('idbi')) {
      return Image.asset('assets/bank_logos/idbi_small_logo.png');
    } else if (bank.contains('induslnd')) {
      return Image.asset('assets/bank_logos/induslnd_small_logo.png');
    } else if (bank.contains('jupiter')) {
      return Image.asset('assets/bank_logos/jupiter_small_logo.png');
    } else if (bank.contains('kotak')) {
      return Image.asset('assets/bank_logos/kotak_small_logo.png');
    } else if (bank.contains('paytm')) {
      return Image.asset('assets/bank_logos/paytm_small_logo.png');
    } else if (bank.contains('sbi')) {
      return Image.asset('assets/bank_logos/sbi_small_logo.png');
    } else if (bank.contains('slice')) {
      return Image.asset('assets/bank_logos/slice_small_logo.png');
    } else {
      return Image.asset('assets/bank_logos/bank.png');
    }
  }
}
