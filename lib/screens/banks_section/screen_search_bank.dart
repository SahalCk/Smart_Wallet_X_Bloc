import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/database/functions/bank_functions.dart';
import 'package:smartwalletx/models/bank_model.dart';
import 'package:smartwalletx/screens/banks_section/screen_bank_details.dart';

class BankSearchScreen extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(backgroundColor: background),
      scaffoldBackgroundColor: background,
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(
            Icons.clear,
            color: mytextcolor,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: mytextcolor,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return ValueListenableBuilder(
      valueListenable: BankFunctions.banknotifier,
      builder: (context, value, child) {
        final list = search(value);
        return list.isNotEmpty
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
                          return BankDetailsScreen(
                              index: BankFunctions.banknotifier.value
                                  .indexOf(list[index]));
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
                                  horizontal: mediaquery.size.width * 0.02,
                                  vertical: mediaquery.size.height * 0.012),
                              child: Center(
                                child: bankselecter(BankFunctions
                                    .banknotifier.value
                                    .indexOf(list[index])),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: mediaquery.size.width * 0.03,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  list[index].bankname,
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
                                  list[index].accountnumber,
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
                itemCount: list.length)
            : Center(
                child: Text(
                  'Bank Not Found !',
                  style: notfound,
                ),
              );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return ValueListenableBuilder(
      valueListenable: BankFunctions.banknotifier,
      builder: (context, value, child) {
        final list = search(value);
        return list.isNotEmpty
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
                          return BankDetailsScreen(
                              index: BankFunctions.banknotifier.value
                                  .indexOf(list[index]));
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
                                  horizontal: mediaquery.size.width * 0.02,
                                  vertical: mediaquery.size.height * 0.012),
                              child: Center(
                                child: bankselecter(BankFunctions
                                    .banknotifier.value
                                    .indexOf(list[index])),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: mediaquery.size.width * 0.03,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  list[index].bankname,
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
                                  list[index].accountnumber,
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
                itemCount: list.length)
            : Center(
                child: Text(
                  'Bank Not Found !',
                  style: notfound,
                ),
              );
      },
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
      return Text(
        BankFunctions.banknotifier.value[index].bankname[0].toUpperCase(),
        style: const TextStyle(
            color: Color.fromARGB(255, 65, 65, 65),
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis),
      );
    }
  }

  List<BankModel> search(List<BankModel> value) {
    List<BankModel> list = [];
    for (int i = 0; i < value.length; i++) {
      if (value[i]
          .bankname
          .toLowerCase()
          .trim()
          .contains(query.toLowerCase().trim())) {
        list.add(value[i]);
      }
    }
    return list;
  }
}
