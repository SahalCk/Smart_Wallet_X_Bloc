import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/card_functions.dart';
import 'package:smartwalletx/models/card_model.dart';

class CardEditScreen extends StatefulWidget {
  final int index;
  const CardEditScreen({super.key, required this.index});

  @override
  State<CardEditScreen> createState() => _CardEditScreenState();
}

class _CardEditScreenState extends State<CardEditScreen> {
  var list = CardFunctions.cardNotifier.value;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController cardnumbercontroller = TextEditingController();
  TextEditingController cvvcontroller = TextEditingController();
  TextEditingController cardissuedatecontroller = TextEditingController();
  TextEditingController banknamecontroller = TextEditingController();
  TextEditingController cardexpdatecontroller = TextEditingController();
  String? cardtype;
  Color? cardcolor;
  Color? cardtextcolor;
  String? paymentnetwork;

  @override
  void initState() {
    namecontroller =
        TextEditingController(text: list[widget.index].cardholdername);
    cardnumbercontroller = TextEditingController(
        text: removespaces(list[widget.index].cardnumber));
    cvvcontroller = TextEditingController(text: list[widget.index].cvv);
    cardissuedatecontroller =
        TextEditingController(text: list[widget.index].validfrom);
    banknamecontroller =
        TextEditingController(text: list[widget.index].bankname);
    cardexpdatecontroller =
        TextEditingController(text: list[widget.index].validthru);
    cardtype = list[widget.index].cardtype;
    cardcolor = Color(int.parse(
        list[widget.index].cardcolor.split('(0x')[1].split(')')[0],
        radix: 16));
    cardtextcolor = Color(int.parse(
        list[widget.index].cardtextcolor.split('(0x')[1].split(')')[0],
        radix: 16));
    paymentnetwork = list[widget.index].paymentnetwork;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: mediaquery.size.height * 0.025,
            ),
            appbarwithouttrail('assets/back_arrow.png', 'Edit Card', context),
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
                                shape: NeumorphicShape.convex,
                                intensity: 1,
                                depth: 10,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    const BorderRadius.all(
                                        Radius.circular(10)))),
                            child: Container(
                              height: mediaquery.size.height * 0.3265,
                              width: mediaquery.size.width * 0.425,
                              color: cardcolor,
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
                                            banknamecontroller.text),
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
                                                  color: cardtextcolor),
                                            ),
                                            Text(
                                              cardissuedatecontroller.text,
                                              style: TextStyle(
                                                  color: cardtextcolor),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Valid Thru',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: cardtextcolor),
                                            ),
                                            Text(
                                              cardexpdatecontroller.text,
                                              style: TextStyle(
                                                  color: cardtextcolor),
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
                                          namecontroller.text.trim(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: cardtextcolor),
                                        )),
                                    SizedBox(
                                      height: mediaquery.size.height * 0.003,
                                    ),
                                    SizedBox(
                                        width: mediaquery.size.width * 0.36,
                                        child: Text(
                                          cardnumbercontroller.text.trim(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 13.7,
                                              overflow: TextOverflow.ellipsis,
                                              color: cardtextcolor),
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
                              children: [
                                SizedBox(
                                  height: mediaquery.size.height * 0.02,
                                ),
                                info(context, 'card'),
                                SizedBox(
                                  height: mediaquery.size.height * 0.02,
                                ),
                                const Text(
                                  'Card Details',
                                  style: adddetails,
                                ),
                                SizedBox(
                                  height: mediaquery.size.height * 0.05,
                                ),
                                addpagelabel('Card Holder Name'),
                                gapfromtitletotextfield(context),
                                Neumorphic(
                                  style: NeumorphicStyle(
                                    color: const Color.fromARGB(
                                        255, 231, 235, 240),
                                    depth: -2,
                                    intensity: 1,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaquery.size.height * 0.026,
                                      horizontal: 18),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    controller: namecontroller,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: 'Enter Card Holder Name'),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 58, 58, 58)),
                                  ),
                                ),
                                gapfromtextfieldtotitle(context),
                                addpagelabel('Card Number'),
                                gapfromtitletotextfield(context),
                                Neumorphic(
                                  style: NeumorphicStyle(
                                    color: const Color.fromARGB(
                                        255, 231, 235, 240),
                                    depth: -2,
                                    intensity: 1,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaquery.size.height * 0.026,
                                      horizontal: 18),
                                  child: TextField(
                                    controller: cardnumbercontroller,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: 'Enter Card Number'),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(16)
                                    ],
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 58, 58, 58)),
                                  ),
                                ),
                                gapfromtextfieldtotitle(context),
                                addpagelabel('CVV'),
                                gapfromtitletotextfield(context),
                                Neumorphic(
                                  style: NeumorphicStyle(
                                    color: const Color.fromARGB(
                                        255, 231, 235, 240),
                                    depth: -2,
                                    intensity: 1,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaquery.size.height * 0.026,
                                      horizontal: 18),
                                  child: TextField(
                                    controller: cvvcontroller,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: 'Enter CVV Number'),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(3)
                                    ],
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 58, 58, 58)),
                                  ),
                                ),
                                gapfromtextfieldtotitle(context),
                                addpagelabel('Valid From'),
                                gapfromtitletotextfield(context),
                                Neumorphic(
                                  style: NeumorphicStyle(
                                    color: const Color.fromARGB(
                                        255, 231, 235, 240),
                                    depth: -2,
                                    intensity: 1,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaquery.size.height * 0.026,
                                      horizontal: 18),
                                  child: TextField(
                                    controller: cardissuedatecontroller,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.none,
                                    decoration: const InputDecoration.collapsed(
                                        hintText:
                                            'Select Card Valid From Date'),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 58, 58, 58)),
                                    onTap: () async {
                                      DateTime? selecteddate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime.now());

                                      String modified = selecteddate
                                          .toString()
                                          .substring(0, 7);
                                      cardissuedatecontroller.text =
                                          '${modified.substring(5, 7)} / ${modified.substring(0, 4)}';
                                    },
                                  ),
                                ),
                                gapfromtextfieldtotitle(context),
                                addpagelabel('Valid Thru'),
                                gapfromtitletotextfield(context),
                                Neumorphic(
                                  style: NeumorphicStyle(
                                    color: const Color.fromARGB(
                                        255, 231, 235, 240),
                                    depth: -2,
                                    intensity: 1,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaquery.size.height * 0.026,
                                      horizontal: 18),
                                  child: TextField(
                                    controller: cardexpdatecontroller,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.none,
                                    decoration: const InputDecoration.collapsed(
                                        hintText:
                                            'Select Card Valid Thru Date'),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 58, 58, 58)),
                                    onTap: () async {
                                      DateTime? selecteddate2 =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2100));

                                      String modified = selecteddate2
                                          .toString()
                                          .substring(0, 7);
                                      cardexpdatecontroller.text =
                                          '${modified.substring(5, 7)} / ${modified.substring(0, 4)}';
                                    },
                                  ),
                                ),
                                gapfromtextfieldtotitle(context),
                                addpagelabel('Card Type'),
                                gapfromtitletotextfield(context),
                                Row(
                                  children: [
                                    NeumorphicRadio(
                                      style: const NeumorphicRadioStyle(
                                        selectedDepth: -2,
                                        intensity: 1,
                                      ),
                                      value: 'Credit Card',
                                      groupValue: cardtype,
                                      onChanged: (value) {
                                        setState(() {
                                          cardtype = value!;
                                        });
                                      },
                                      child: SizedBox(
                                        height: mediaquery.size.height * 0.055,
                                        width: mediaquery.size.width * 0.28,
                                        child: const Center(
                                            child: Text(
                                          'Credit Card',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 58, 58, 58)),
                                        )),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.05,
                                    ),
                                    NeumorphicRadio(
                                      style: const NeumorphicRadioStyle(
                                        selectedDepth: -2,
                                        intensity: 1,
                                      ),
                                      value: 'Debit Card',
                                      groupValue: cardtype,
                                      onChanged: (value) {
                                        setState(() {
                                          cardtype = value!;
                                        });
                                      },
                                      child: SizedBox(
                                        height: mediaquery.size.height * 0.055,
                                        width: mediaquery.size.width * 0.28,
                                        child: const Center(
                                            child: Text(
                                          'Debit Card',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 58, 58, 58)),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                                gapfromtextfieldtotitle(context),
                                addpagelabel('Bank/Card Provider Name'),
                                gapfromtitletotextfield(context),
                                Neumorphic(
                                  style: NeumorphicStyle(
                                    color: const Color.fromARGB(
                                        255, 231, 235, 240),
                                    depth: -2,
                                    intensity: 1,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(8)),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: mediaquery.size.height * 0.026,
                                      horizontal: 18),
                                  child: TextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    controller: banknamecontroller,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration.collapsed(
                                        hintText:
                                            'Enter Bank/Card Provider Name'),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 58, 58, 58)),
                                  ),
                                ),
                                gapfromtextfieldtotitle(context),
                                addpagelabel('Select Card Colour'),
                                gapfromtitletotextfield(context),
                                Row(
                                  children: [
                                    NeumorphicRadio(
                                      style: const NeumorphicRadioStyle(
                                        intensity: 0.5,
                                        selectedDepth: -2,
                                      ),
                                      value:
                                          const Color.fromARGB(255, 27, 27, 27),
                                      groupValue: cardcolor,
                                      onChanged: (value) {
                                        setState(() {
                                          cardcolor = const Color.fromARGB(
                                              255, 27, 27, 27);
                                        });
                                      },
                                      child: Center(
                                        child: SizedBox(
                                          width: mediaquery.size.width * 0.106,
                                          height:
                                              mediaquery.size.height * 0.053,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 27, 27, 27),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 2,
                                                    color: cardcolor ==
                                                            const Color
                                                                    .fromARGB(
                                                                255, 27, 27, 27)
                                                        ? Colors.green
                                                        : Colors.white)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.01,
                                    ),
                                    NeumorphicRadio(
                                      style: const NeumorphicRadioStyle(
                                        intensity: 0.5,
                                        selectedDepth: -2,
                                      ),
                                      value: const Color.fromARGB(
                                          255, 235, 235, 235),
                                      groupValue: cardcolor,
                                      onChanged: (value) {
                                        setState(() {
                                          cardcolor = const Color.fromARGB(
                                              255, 235, 235, 235);
                                        });
                                      },
                                      child: Center(
                                        child: SizedBox(
                                          width: mediaquery.size.width * 0.106,
                                          height:
                                              mediaquery.size.height * 0.053,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 235, 235, 235),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 2,
                                                    color: cardcolor ==
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                235,
                                                                235,
                                                                235)
                                                        ? Colors.green
                                                        : Colors.black)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.01,
                                    ),
                                    NeumorphicRadio(
                                      style: const NeumorphicRadioStyle(
                                        intensity: 0.5,
                                        selectedDepth: -2,
                                      ),
                                      value: const Color.fromARGB(
                                          255, 177, 37, 200),
                                      groupValue: cardcolor,
                                      onChanged: (value) {
                                        setState(() {
                                          cardcolor = const Color.fromARGB(
                                              255, 177, 37, 200);
                                        });
                                      },
                                      child: Center(
                                        child: SizedBox(
                                          width: mediaquery.size.width * 0.106,
                                          height:
                                              mediaquery.size.height * 0.053,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 177, 37, 200),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 2,
                                                    color: cardcolor ==
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                177,
                                                                37,
                                                                200)
                                                        ? Colors.green
                                                        : Colors.black)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.01,
                                    ),
                                    NeumorphicRadio(
                                      style: const NeumorphicRadioStyle(
                                        intensity: 0.5,
                                        selectedDepth: -2,
                                      ),
                                      value: const Color.fromARGB(
                                          255, 232, 56, 56),
                                      groupValue: cardcolor,
                                      onChanged: (value) {
                                        setState(() {
                                          cardcolor = const Color.fromARGB(
                                              255, 232, 56, 56);
                                        });
                                      },
                                      child: Center(
                                        child: SizedBox(
                                          width: mediaquery.size.width * 0.106,
                                          height:
                                              mediaquery.size.height * 0.053,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 232, 56, 56),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 2,
                                                    color: cardcolor ==
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                232,
                                                                56,
                                                                56)
                                                        ? Colors.green
                                                        : Colors.black)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.01,
                                    ),
                                    NeumorphicRadio(
                                      style: const NeumorphicRadioStyle(
                                        intensity: 0.5,
                                        selectedDepth: -2,
                                      ),
                                      value:
                                          const Color.fromARGB(255, 27, 27, 27),
                                      groupValue: cardcolor,
                                      onChanged: (value) {
                                        setState(() {
                                          cardcolor = const Color.fromARGB(
                                              255, 16, 243, 84);
                                        });
                                      },
                                      child: Center(
                                        child: SizedBox(
                                          width: mediaquery.size.width * 0.106,
                                          height:
                                              mediaquery.size.height * 0.053,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 16, 243, 84),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 2,
                                                    color: cardcolor ==
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                16,
                                                                243,
                                                                84)
                                                        ? Colors.green
                                                        : Colors.black)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                gapfromtextfieldtotitle(context),
                                addpagelabel('Select Card Text Colour'),
                                gapfromtitletotextfield(context),
                                Row(
                                  children: [
                                    NeumorphicRadio(
                                      style: const NeumorphicRadioStyle(
                                        intensity: 0.5,
                                        selectedDepth: -2,
                                      ),
                                      value: const Color.fromARGB(
                                          255, 192, 192, 192),
                                      groupValue: cardtextcolor,
                                      onChanged: (value) {
                                        setState(() {
                                          cardtextcolor = const Color.fromARGB(
                                              255, 192, 192, 192);
                                        });
                                      },
                                      child: Center(
                                        child: SizedBox(
                                          width: mediaquery.size.width * 0.106,
                                          height:
                                              mediaquery.size.height * 0.053,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 192, 192, 192),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 2,
                                                    color: cardtextcolor ==
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                192,
                                                                192,
                                                                192)
                                                        ? Colors.green
                                                        : Colors.black)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.01,
                                    ),
                                    NeumorphicRadio(
                                      style: const NeumorphicRadioStyle(
                                        intensity: 0.5,
                                        selectedDepth: -2,
                                      ),
                                      value:
                                          const Color.fromARGB(255, 27, 27, 27),
                                      groupValue: cardtextcolor,
                                      onChanged: (value) {
                                        setState(() {
                                          cardtextcolor = const Color.fromARGB(
                                              255, 27, 27, 27);
                                        });
                                      },
                                      child: Center(
                                        child: SizedBox(
                                          width: mediaquery.size.width * 0.106,
                                          height:
                                              mediaquery.size.height * 0.053,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 27, 27, 27),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 2,
                                                    color: cardtextcolor ==
                                                            const Color
                                                                    .fromARGB(
                                                                255, 27, 27, 27)
                                                        ? Colors.green
                                                        : Colors.white)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.01,
                                    ),
                                    NeumorphicRadio(
                                      style: const NeumorphicRadioStyle(
                                        intensity: 0.5,
                                        selectedDepth: -2,
                                      ),
                                      value: const Color.fromARGB(
                                          255, 245, 245, 245),
                                      groupValue: cardtextcolor,
                                      onChanged: (value) {
                                        setState(() {
                                          cardtextcolor = const Color.fromARGB(
                                              255, 245, 245, 245);
                                        });
                                      },
                                      child: Center(
                                        child: SizedBox(
                                          width: mediaquery.size.width * 0.106,
                                          height:
                                              mediaquery.size.height * 0.053,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 245, 245, 245),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 2,
                                                    color: cardtextcolor ==
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                245,
                                                                245,
                                                                245)
                                                        ? Colors.green
                                                        : Colors.black)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.01,
                                    ),
                                    NeumorphicRadio(
                                      style: const NeumorphicRadioStyle(
                                        intensity: 0.5,
                                        selectedDepth: -2,
                                      ),
                                      value: const Color.fromARGB(
                                          255, 232, 56, 56),
                                      groupValue: cardtextcolor,
                                      onChanged: (value) {
                                        setState(() {
                                          cardtextcolor = const Color.fromARGB(
                                              255, 232, 56, 56);
                                        });
                                      },
                                      child: Center(
                                        child: SizedBox(
                                          width: mediaquery.size.width * 0.106,
                                          height:
                                              mediaquery.size.height * 0.053,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 232, 56, 56),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 2,
                                                    color: cardtextcolor ==
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                232,
                                                                56,
                                                                56)
                                                        ? Colors.green
                                                        : Colors.black)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.01,
                                    ),
                                    NeumorphicRadio(
                                      style: const NeumorphicRadioStyle(
                                        intensity: 0.5,
                                        selectedDepth: -2,
                                      ),
                                      value: const Color.fromARGB(
                                          255, 212, 175, 55),
                                      groupValue: cardtextcolor,
                                      onChanged: (value) {
                                        setState(() {
                                          cardtextcolor = const Color.fromARGB(
                                              255, 212, 175, 55);
                                        });
                                      },
                                      child: Center(
                                        child: SizedBox(
                                          width: mediaquery.size.width * 0.106,
                                          height:
                                              mediaquery.size.height * 0.053,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 212, 175, 55),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    width: 2,
                                                    color: cardtextcolor ==
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                212,
                                                                175,
                                                                55)
                                                        ? Colors.green
                                                        : Colors.black)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                gapfromtextfieldtotitle(context),
                                addpagelabel('Select Payment Network'),
                                gapfromtitletotextfield(context),
                                Row(
                                  children: [
                                    NeumorphicRadio(
                                      value: 'Visa',
                                      groupValue: paymentnetwork,
                                      onChanged: (value) {
                                        setState(() {
                                          paymentnetwork = value!;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            mediaquery.size.width * 0.01),
                                        height: mediaquery.size.height * 0.056,
                                        width: mediaquery.size.width * 0.15,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 2,
                                                color: paymentnetwork == 'Visa'
                                                    ? Colors.green
                                                    : Colors.black)),
                                        child: Image.asset(
                                            'assets/card_network/visa.png'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.01,
                                    ),
                                    NeumorphicRadio(
                                      value: 'Master Card',
                                      groupValue: paymentnetwork,
                                      onChanged: (value) {
                                        setState(() {
                                          paymentnetwork = value!;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            mediaquery.size.width * 0.01),
                                        height: mediaquery.size.height * 0.056,
                                        width: mediaquery.size.width * 0.15,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 2,
                                                color: paymentnetwork ==
                                                        'Master Card'
                                                    ? Colors.green
                                                    : Colors.black)),
                                        child: Image.asset(
                                            'assets/card_network/master_card.png'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.01,
                                    ),
                                    NeumorphicRadio(
                                      value: 'Rupay',
                                      groupValue: paymentnetwork,
                                      onChanged: (value) {
                                        setState(() {
                                          paymentnetwork = value!;
                                        });
                                      },
                                      style: const NeumorphicRadioStyle(
                                        selectedDepth: -2,
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            mediaquery.size.width * 0.01),
                                        height: mediaquery.size.height * 0.056,
                                        width: mediaquery.size.width * 0.15,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 2,
                                                color: paymentnetwork == 'Rupay'
                                                    ? Colors.green
                                                    : Colors.black)),
                                        child: Image.asset(
                                            'assets/card_network/rupay.png'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.01,
                                    ),
                                    NeumorphicRadio(
                                      value: 'American Express',
                                      groupValue: paymentnetwork,
                                      onChanged: (value) {
                                        setState(() {
                                          paymentnetwork = value!;
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            mediaquery.size.width * 0.01),
                                        height: mediaquery.size.height * 0.056,
                                        width: mediaquery.size.width * 0.15,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 2,
                                                color: paymentnetwork ==
                                                        'American Express'
                                                    ? Colors.green
                                                    : Colors.black)),
                                        child: Image.asset(
                                            'assets/card_network/american_express.png'),
                                      ),
                                    )
                                  ],
                                ),
                                gapfromtextfieldtotitle(context),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    NeumorphicButton(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              mediaquery.size.width * 0.055,
                                          vertical:
                                              mediaquery.size.height * 0.0135),
                                      style: NeumorphicStyle(
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(10),
                                          ),
                                          depth: 3,
                                          intensity: 1,
                                          color: const Color.fromARGB(
                                              255, 190, 60, 60)),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      onPressed: () {
                                        cancelShowAlert(context, widget.index);
                                      },
                                    ),
                                    NeumorphicButton(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              mediaquery.size.width * 0.055,
                                          vertical:
                                              mediaquery.size.height * 0.0135),
                                      style: NeumorphicStyle(
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(10),
                                          ),
                                          depth: 3,
                                          intensity: 1,
                                          color: const Color.fromARGB(
                                              255, 60, 190, 65)),
                                      child: const Text(
                                        'Submit',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                      onPressed: () {
                                        validate();
                                      },
                                    ),
                                  ],
                                ),
                                gapfromtitletotextfield(context),
                                gapfromtitletotextfield(context),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String spacebetweencardnumber() {
    List<String> list = cardnumbercontroller.text.trim().split('');
    for (int i = 0; i < list.length; i++) {
      if (i % 5 == 0) {
        list.insert(i, ' ');
      }
    }
    list.removeAt(0);
    return list.join();
  }

  String removespaces(String cardnumber) {
    return cardnumber.replaceAll(' ', '');
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

  void validate() {
    if (namecontroller.text.isEmpty) {
      emptyfield('Card Holder Name');
    } else if (cardnumbercontroller.text.isEmpty) {
      emptyfield('Card Number');
    } else if (cardnumbercontroller.text.length < 16) {
      wrong('Please Enter Valid Card Number');
    } else if (cvvcontroller.text.isEmpty) {
      emptyfield('CVV');
    } else if (cardissuedatecontroller.text.isEmpty) {
      emptyfield('Card Valid From Date');
    } else if (cvvcontroller.text.length < 3) {
      wrong('Please Enter Valid CVV');
    } else if (cardexpdatecontroller.text.isEmpty) {
      emptyfield('Card Valid Thru Date');
    } else if (banknamecontroller.text.isEmpty) {
      emptyfield('Bank/Card Provider Name');
    } else {
      submitcard();
    }
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

  submitcard() async {
    spacebetweencardnumber();
    CardModel newcard = CardModel(
        cardholdername: namecontroller.text.trim(),
        cardnumber: spacebetweencardnumber(),
        cvv: cvvcontroller.text,
        validfrom: cardissuedatecontroller.text.trim(),
        validthru: cardexpdatecontroller.text.trim(),
        cardtype: cardtype!,
        bankname: banknamecontroller.text.trim(),
        cardcolor: cardcolor.toString(),
        cardtextcolor: cardtextcolor.toString(),
        paymentnetwork: paymentnetwork!);
    await CardFunctions.updatecard(widget.index, newcard);
    succcess();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  void succcess() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('New Card Added Successfully'),
      backgroundColor: Color.fromARGB(255, 85, 230, 85),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
    ));
  }

  void cancelShowAlert(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Do you want to cancel?'),
            content: const Text(
              'All the modified datas will be cleared and not stored anywhere',
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("Yes"))
            ],
          );
        });
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
