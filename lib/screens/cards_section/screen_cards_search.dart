import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/database/functions/card_functions.dart';

import 'screen_card_details.dart';

class CardsSearchScreen extends SearchDelegate {
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mediaquery.size.width * 0.057),
      child: Padding(
        padding: EdgeInsets.only(top: mediaquery.size.height * 0.03),
        child: ValueListenableBuilder(
            valueListenable: CardFunctions.cardNotifier,
            builder: (context, cardslist, child) {
              return ListView.separated(
                  itemBuilder: ((context, index) {
                    final data = cardslist[index];
                    if (data.bankname
                        .toLowerCase()
                        .contains(query.toLowerCase().trim())) {
                      return SizedBox(
                        height: mediaquery.size.height * 0.11,
                        width: mediaquery.size.width,
                        child: NeumorphicButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (ctx) {
                              return CardDetailsScreen(index: index);
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
                                  color: Color(int.parse(
                                      cardslist[index]
                                          .cardcolor
                                          .split('(0x')[1]
                                          .split(')')[0],
                                      radix: 16)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: mediaquery.size.width * 0.02,
                                      vertical: mediaquery.size.height * 0.012),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              height:
                                                  mediaquery.size.height * 0.03,
                                              width:
                                                  mediaquery.size.width * 0.04,
                                              child: Image.asset(
                                                  'assets/card_chip.png')),
                                          SizedBox(
                                              height:
                                                  mediaquery.size.height * 0.03,
                                              width:
                                                  mediaquery.size.width * 0.04,
                                              child: bankselecter(
                                                  cardslist[index].bankname)),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: mediaquery.size.width * 0.04,
                                            height:
                                                mediaquery.size.height * 0.005,
                                            decoration: BoxDecoration(
                                                color: Color(int.parse(
                                                    cardslist[index]
                                                        .cardtextcolor
                                                        .split('(0x')[1]
                                                        .split(')')[0],
                                                    radix: 16)),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                          ),
                                          Container(
                                            width: mediaquery.size.width * 0.04,
                                            height:
                                                mediaquery.size.height * 0.005,
                                            decoration: BoxDecoration(
                                              color: Color(int.parse(
                                                  cardslist[index]
                                                      .cardtextcolor
                                                      .split('(0x')[1]
                                                      .split(')')[0],
                                                  radix: 16)),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          Container(
                                            width: mediaquery.size.width * 0.04,
                                            height:
                                                mediaquery.size.height * 0.005,
                                            decoration: BoxDecoration(
                                              color: Color(int.parse(
                                                  cardslist[index]
                                                      .cardtextcolor
                                                      .split('(0x')[1]
                                                      .split(')')[0],
                                                  radix: 16)),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
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
                                      cardslist[index].bankname,
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 75, 75, 75),
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    SizedBox(
                                      height: mediaquery.size.height * 0.002,
                                    ),
                                    Text(
                                      cardslist[index].cardnumber,
                                      style: TextStyle(color: subtitlecolor),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Text('');
                    }
                  }),
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: mediaquery.size.height * 0.03,
                    );
                  },
                  itemCount: cardslist.length);
            }),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.only(top: mediaquery.size.height * 0.03),
      child: ValueListenableBuilder(
          valueListenable: CardFunctions.cardNotifier,
          builder: (context, cardslist, child) {
            return ListView.separated(
                padding: EdgeInsets.symmetric(
                    horizontal: mediaquery.size.width * 0.055,
                    vertical: mediaquery.size.width * 0.035),
                itemBuilder: ((context, index) {
                  final data = cardslist[index];
                  if (data.bankname
                      .toLowerCase()
                      .contains(query.toLowerCase().trim())) {
                    return SizedBox(
                      height: mediaquery.size.height * 0.11,
                      width: mediaquery.size.width,
                      child: NeumorphicButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (ctx) {
                            return CardDetailsScreen(index: index);
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
                                color: Color(int.parse(
                                    cardslist[index]
                                        .cardcolor
                                        .split('(0x')[1]
                                        .split(')')[0],
                                    radix: 16)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mediaquery.size.width * 0.02,
                                    vertical: mediaquery.size.height * 0.012),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            height:
                                                mediaquery.size.height * 0.03,
                                            width: mediaquery.size.width * 0.04,
                                            child: Image.asset(
                                                'assets/card_chip.png')),
                                        SizedBox(
                                            height:
                                                mediaquery.size.height * 0.03,
                                            width: mediaquery.size.width * 0.04,
                                            child: bankselecter(
                                                cardslist[index].bankname)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: mediaquery.size.width * 0.04,
                                          height:
                                              mediaquery.size.height * 0.005,
                                          decoration: BoxDecoration(
                                              color: Color(int.parse(
                                                  cardslist[index]
                                                      .cardtextcolor
                                                      .split('(0x')[1]
                                                      .split(')')[0],
                                                  radix: 16)),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                        Container(
                                          width: mediaquery.size.width * 0.04,
                                          height:
                                              mediaquery.size.height * 0.005,
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(
                                                cardslist[index]
                                                    .cardtextcolor
                                                    .split('(0x')[1]
                                                    .split(')')[0],
                                                radix: 16)),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        Container(
                                          width: mediaquery.size.width * 0.04,
                                          height:
                                              mediaquery.size.height * 0.005,
                                          decoration: BoxDecoration(
                                            color: Color(int.parse(
                                                cardslist[index]
                                                    .cardtextcolor
                                                    .split('(0x')[1]
                                                    .split(')')[0],
                                                radix: 16)),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
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
                                    cardslist[index].bankname,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 75, 75, 75),
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  SizedBox(
                                    height: mediaquery.size.height * 0.002,
                                  ),
                                  Text(
                                    cardslist[index].cardnumber,
                                    style: TextStyle(color: subtitlecolor),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Text('');
                  }
                }),
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: mediaquery.size.height * 0.03,
                  );
                },
                itemCount: cardslist.length);
          }),
    );
  }

  Widget bankselecter(String bank) {
    bank = bank.toLowerCase();
    if (bank.contains('icic')) {
      return Image.asset('assets/bank_logos/icici_small_logo.png');
    } else if (bank.contains('federal')) {
      return Image.asset('assets/bank_logos/federal_small_logo.png');
    } else if (bank.contains('axis')) {
      return Image.asset('assets/bank_logos/axis_small_logo.png');
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
        bank[0].toUpperCase(),
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis),
      );
    }
  }
}
