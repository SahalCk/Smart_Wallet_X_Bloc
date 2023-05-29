import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/card_functions.dart';
import 'package:smartwalletx/database/data_encrption.dart';
import 'package:smartwalletx/screens/cards_section/screen_edit_card.dart';

class CardDetailsScreen extends StatefulWidget {
  final int index;
  const CardDetailsScreen({super.key, required this.index});

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  final list = CardFunctions.cardNotifier.value;
  XEncryption xEncryption = XEncryption();

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
            appbarwithdelete('assets/back_arrow.png', '', 'assets/delete.png',
                context, widget.index, 'Card'),
            SizedBox(
              height: mediaquery.size.height * 0.012,
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
                        height: mediaquery.size.height * 0.06,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Neumorphic(
                            style: NeumorphicStyle(
                                shadowLightColor: shadowcolor,
                                shape: NeumorphicShape.convex,
                                intensity: 1,
                                depth: 10,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    const BorderRadius.all(
                                        Radius.circular(10)))),
                            child: Container(
                              height: mediaquery.size.height * 0.3265,
                              width: mediaquery.size.width * 0.425,
                              color: Color(int.parse(
                                  list[widget.index]
                                      .cardcolor
                                      .split('(0x')[1]
                                      .split(')')[0],
                                  radix: 16)),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    mediaquery.size.width * 0.025),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: mediaquery.size.height * 0.03,
                                      width: mediaquery.size.width * 0.26,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: bankselecter(
                                            list[widget.index].bankname),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: mediaquery.size.height * 0.007,
                                            right:
                                                mediaquery.size.width * 0.025),
                                        child: SizedBox(
                                          height:
                                              mediaquery.size.height * 0.048,
                                          width: mediaquery.size.width * 0.09,
                                          child: Image.asset(
                                              'assets/card_chip.png'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: mediaquery.size.height * 0.06,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              'Valid From',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(int.parse(
                                                    list[widget.index]
                                                        .cardtextcolor
                                                        .split('(0x')[1]
                                                        .split(')')[0],
                                                    radix: 16)),
                                              ),
                                            ),
                                            Text(
                                              list[widget.index].validfrom,
                                              style: TextStyle(
                                                color: Color(int.parse(
                                                    list[widget.index]
                                                        .cardtextcolor
                                                        .split('(0x')[1]
                                                        .split(')')[0],
                                                    radix: 16)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Valid Thru',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(int.parse(
                                                    list[widget.index]
                                                        .cardtextcolor
                                                        .split('(0x')[1]
                                                        .split(')')[0],
                                                    radix: 16)),
                                              ),
                                            ),
                                            Text(
                                              list[widget.index].validthru,
                                              style: TextStyle(
                                                color: Color(int.parse(
                                                    list[widget.index]
                                                        .cardtextcolor
                                                        .split('(0x')[1]
                                                        .split(')')[0],
                                                    radix: 16)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mediaquery.size.height * 0.02,
                                    ),
                                    SizedBox(
                                        width: mediaquery.size.width * 0.36,
                                        child: Text(
                                          list[widget.index].cardholdername,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Color(int.parse(
                                                list[widget.index]
                                                    .cardtextcolor
                                                    .split('(0x')[1]
                                                    .split(')')[0],
                                                radix: 16)),
                                          ),
                                        )),
                                    SizedBox(
                                      height: mediaquery.size.height * 0.003,
                                    ),
                                    SizedBox(
                                        width: mediaquery.size.width * 0.36,
                                        child: Text(
                                          list[widget.index].cardnumber,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 13.7,
                                            overflow: TextOverflow.ellipsis,
                                            color: Color(int.parse(
                                                list[widget.index]
                                                    .cardtextcolor
                                                    .split('(0x')[1]
                                                    .split(')')[0],
                                                radix: 16)),
                                          ),
                                        )),
                                    SizedBox(
                                      height: mediaquery.size.height * 0.02,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        height: mediaquery.size.height * 0.028,
                                        width: mediaquery.size.width * 0.2,
                                        child: Image.asset(
                                          'assets/card_network/${networkselector(list[widget.index].paymentnetwork)}.png',
                                          alignment: Alignment.centerRight,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    'Card Details',
                                    style: adddetails,
                                  ),
                                ),
                                SizedBox(
                                  height: mediaquery.size.height * 0.05,
                                ),
                                addpagelabel('Card Holder Name'),
                                gapfromtitletotext(context),
                                Text(list[widget.index].cardholdername,
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
                                        addpagelabel('Card Number'),
                                        gapfromtitletotext(context),
                                        Text(list[widget.index].cardnumber,
                                            style: formdetails),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await Clipboard.setData(ClipboardData(
                                            text:
                                                list[widget.index].cardnumber));
                                        copytoclipboard();
                                      },
                                      icon: const Icon(
                                          Icons.content_copy_rounded),
                                      iconSize: 33,
                                    )
                                  ],
                                ),
                                gapfromtextfieldtotitle(context),
                                addpagelabel('Valid From'),
                                gapfromtitletotext(context),
                                Text(list[widget.index].validfrom,
                                    style: formdetails),
                                gapfromtextfieldtotitle(context),
                                addpagelabel('Valid Thru'),
                                gapfromtitletotext(context),
                                Text(list[widget.index].validthru,
                                    style: formdetails),
                                gapfromtextfieldtotitle(context),
                                addpagelabel('Card Type'),
                                gapfromtitletotext(context),
                                Text(list[widget.index].cardtype,
                                    style: formdetails),
                                gapfromtextfieldtotitle(context),
                                addpagelabel('Bank/Card Provider Name'),
                                gapfromtitletotext(context),
                                Text(list[widget.index].bankname,
                                    style: formdetails),
                                gapfromtextfieldtotitle(context),
                                addpagelabel('Payment Network'),
                                gapfromtitletotext(context),
                                Text(list[widget.index].paymentnetwork,
                                    style: formdetails),
                                gapfromtextfieldtotitle(context),
                                Align(
                                  alignment: Alignment.center,
                                  child: NeumorphicButton(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            mediaquery.size.width * 0.055,
                                        vertical:
                                            mediaquery.size.height * 0.016),
                                    style: NeumorphicStyle(
                                        boxShape: NeumorphicBoxShape.roundRect(
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
                                          width: mediaquery.size.width * 0.015,
                                        ),
                                        const Text(
                                          'Edit Card Details',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (ctx) {
                                        return CardEditScreen(
                                            index: widget.index);
                                      }));
                                    },
                                  ),
                                ),
                                gapfromtitletotext(context),
                                gapfromtitletotext(context),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
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
      return Image.asset('assets/bank_logos/icici_full_logo.png');
    } else if (bank.contains('federal')) {
      return Image.asset('assets/bank_logos/federal_full_logo.png');
    } else if (bank.contains('axis')) {
      return Image.asset('assets/bank_logos/axis_full_logo.png');
    } else if (bank.contains('equitas')) {
      return Image.asset('assets/bank_logos/equitas_full_logo.png');
    } else if (bank.contains('fi')) {
      return Image.asset('assets/bank_logos/fi_full_logo.png');
    } else if (bank.contains('idbi')) {
      return Image.asset('assets/bank_logos/idbi_full_logo.png');
    } else if (bank.contains('induslnd')) {
      return Image.asset('assets/bank_logos/induslnd_full_logo.png');
    } else if (bank.contains('jupiter')) {
      return Image.asset('assets/bank_logos/jupiter_full_logo.png');
    } else if (bank.contains('kotak')) {
      return Image.asset('assets/bank_logos/kotak_full_logo.png');
    } else if (bank.contains('paytm')) {
      return Image.asset('assets/bank_logos/paytm_full_logo.png');
    } else if (bank.contains('sbi')) {
      return Image.asset('assets/bank_logos/sbi_full_logo.png');
    } else if (bank.contains('slice')) {
      return Image.asset('assets/bank_logos/slice_full_logo.png');
    } else {
      return Text(
        bank.toUpperCase(),
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis),
      );
    }
  }

  void copytoclipboard() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Card Number Copied to Clipboard"),
      backgroundColor: Color.fromARGB(255, 52, 118, 206),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
    ));
  }

  String networkselector(String bank) {
    if (bank.toLowerCase().contains('american')) {
      return 'american_express';
    } else if (bank.toLowerCase().contains('visa')) {
      return 'visa';
    } else if (bank.toLowerCase().contains('rupay')) {
      return 'rupay';
    } else if (bank.toLowerCase().contains('master')) {
      return 'master_card';
    } else {
      return '';
    }
  }
}
