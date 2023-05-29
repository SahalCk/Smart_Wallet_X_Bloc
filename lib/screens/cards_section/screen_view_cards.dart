import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/card_functions.dart';
import 'package:smartwalletx/screens/cards_section/screen_add_new_card.dart';
import 'package:smartwalletx/screens/cards_section/screen_card_details.dart';
import 'package:smartwalletx/screens/cards_section/screen_cards_search.dart';

class ViewCardsScreen extends StatefulWidget {
  const ViewCardsScreen({super.key});

  @override
  State<ViewCardsScreen> createState() => _ViewCardsScreenState();
}

class _ViewCardsScreenState extends State<ViewCardsScreen> {
  @override
  Widget build(BuildContext context) {
    CardFunctions.getallcarddatas();
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      floatingActionButton: addcardfloating(mediaquery, context, 'Add New Card',
          Icons.add_card_rounded, const AddCardScreen()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: mediaquery.size.height * 0.025,
            ),
            appbarwithouttrail('assets/back_arrow.png', 'View Cards', context),
            SizedBox(
              height: mediaquery.size.height * 0.06,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mediaquery.size.width * 0.057),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Cards',
                    style: TextStyle(fontSize: 21, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      showSearch(
                          context: context, delegate: CardsSearchScreen());
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
                valueListenable: CardFunctions.cardNotifier,
                builder: (context, cardslist, child) {
                  return cardslist.isNotEmpty
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
                                            horizontal:
                                                mediaquery.size.width * 0.02,
                                            vertical:
                                                mediaquery.size.height * 0.012),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                    height:
                                                        mediaquery.size.height *
                                                            0.03,
                                                    width:
                                                        mediaquery.size.width *
                                                            0.04,
                                                    child: Image.asset(
                                                        'assets/card_chip.png')),
                                                SizedBox(
                                                    height:
                                                        mediaquery.size.height *
                                                            0.03,
                                                    width:
                                                        mediaquery.size.width *
                                                            0.04,
                                                    child: bankselecter(
                                                        cardslist[index]
                                                            .bankname)),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: mediaquery.size.width *
                                                      0.04,
                                                  height:
                                                      mediaquery.size.height *
                                                          0.005,
                                                  decoration: BoxDecoration(
                                                      color: Color(int.parse(
                                                          cardslist[index]
                                                              .cardtextcolor
                                                              .split('(0x')[1]
                                                              .split(')')[0],
                                                          radix: 16)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                ),
                                                Container(
                                                  width: mediaquery.size.width *
                                                      0.04,
                                                  height:
                                                      mediaquery.size.height *
                                                          0.005,
                                                  decoration: BoxDecoration(
                                                    color: Color(int.parse(
                                                        cardslist[index]
                                                            .cardtextcolor
                                                            .split('(0x')[1]
                                                            .split(')')[0],
                                                        radix: 16)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                Container(
                                                  width: mediaquery.size.width *
                                                      0.04,
                                                  height:
                                                      mediaquery.size.height *
                                                          0.005,
                                                  decoration: BoxDecoration(
                                                    color: Color(int.parse(
                                                        cardslist[index]
                                                            .cardtextcolor
                                                            .split('(0x')[1]
                                                            .split(')')[0],
                                                        radix: 16)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            cardslist[index].bankname,
                                            style: TextStyle(
                                                color: mytextcolor,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w800,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          SizedBox(
                                            height:
                                                mediaquery.size.height * 0.002,
                                          ),
                                          Text(
                                            cardslist[index].cardnumber,
                                            style: TextStyle(
                                                color: subtitlecolor,
                                                fontSize: 20),
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
                          itemCount: CardFunctions.cardNotifier.value.length)
                      : Center(
                          child: Text(
                            'Cards Not Found !',
                            style: notfound,
                          ),
                        );
                },
              ),
            )
          ],
        ),
      ),
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

  String spacebetweencardnumber(String cardnumber) {
    List<String> list = cardnumber.split('');
    for (int i = 0; i < list.length; i++) {
      if (i % 5 == 0) {
        list.insert(i, ' ');
      }
    }
    list.removeAt(0);
    return list.join();
  }
}
