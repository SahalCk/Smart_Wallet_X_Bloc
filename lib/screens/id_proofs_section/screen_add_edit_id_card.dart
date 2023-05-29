import 'dart:io';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/id_card_functions.dart';
import 'package:smartwalletx/database/functions/profile_functions.dart';
import 'package:smartwalletx/models/id_card_model.dart';

class AddEditIdCardScreen extends StatefulWidget {
  final bool iseditting;
  final int? index;
  const AddEditIdCardScreen({super.key, required this.iseditting, this.index});

  @override
  State<AddEditIdCardScreen> createState() => _AddEditIdCardScreenState();
}

class _AddEditIdCardScreenState extends State<AddEditIdCardScreen> {
  ProfileFunctions profileFunctions = ProfileFunctions();
  MyTextField cardname = MyTextField();
  MyTextField name = MyTextField();
  MyTextField cardnumber = MyTextField();
  MyTextField additionlabel1 = MyTextField();
  MyTextField additionlable2 = MyTextField();
  MyTextField additionans1 = MyTextField();
  MyTextField additionans2 = MyTextField();
  String carddesingn = 'Landscape';
  String backgrounddesign = 'defaultbg-landscape';

  @override
  void initState() {
    if (widget.iseditting == true) {
      getallvalues();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    profileFunctions.getprofile();
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: mediaquery.size.height * 0.025,
          ),
          appbarwithouttrail(
              'assets/back_arrow.png',
              widget.iseditting == false ? 'Add New ID Card' : 'Edit ID Card',
              context),
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
                          height: mediaquery.size.height * 0.06,
                        ),
                        (widget.iseditting == true && carddesingn.isNotEmpty) ||
                                (widget.iseditting) == false
                            ? Neumorphic(
                                style: NeumorphicStyle(
                                    shadowLightColor: shadowcolor,
                                    shape: NeumorphicShape.convex,
                                    intensity: 1,
                                    depth: 10,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        const BorderRadius.all(
                                            Radius.circular(10)))),
                                child: carddesingn == 'Portrait'
                                    ? Container(
                                        height: mediaquery.size.height * 0.32,
                                        width: mediaquery.size.width * 0.425,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                  'assets/id_card_designs/$backgrounddesign.jpg',
                                                ))),
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  textonid(
                                                      context: context,
                                                      text: cardname
                                                          .controller.text,
                                                      weigt: true),
                                                  SizedBox(
                                                    height:
                                                        mediaquery.size.height *
                                                            0.02,
                                                  ),
                                                  CircleAvatar(
                                                    radius:
                                                        mediaquery.size.height *
                                                            0.053,
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 82, 82, 82),
                                                    child:
                                                        ValueListenableBuilder(
                                                      valueListenable:
                                                          profileFunctions
                                                              .profilenotifier,
                                                      builder: (context, value,
                                                          child) {
                                                        return value.isNotEmpty
                                                            ? CircleAvatar(
                                                                radius: mediaquery
                                                                        .size
                                                                        .height *
                                                                    0.05,
                                                                backgroundImage:
                                                                    FileImage(File(profileFunctions
                                                                        .profilenotifier
                                                                        .value[
                                                                            0]
                                                                        .profilepic)),
                                                              )
                                                            : const Text(
                                                                'Loading');
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        mediaquery.size.height *
                                                            0.01,
                                                  ),
                                                  textonid(
                                                      context: context,
                                                      text:
                                                          name.controller.text),
                                                  SizedBox(
                                                      height: mediaquery
                                                              .size.height *
                                                          0.005),
                                                  textonid(
                                                      context: context,
                                                      text: additionans1
                                                          .controller.text),
                                                  SizedBox(
                                                      height: mediaquery
                                                              .size.height *
                                                          0.005),
                                                  textonid(
                                                      context: context,
                                                      text: additionans2
                                                          .controller.text),
                                                  SizedBox(
                                                      height: mediaquery
                                                              .size.height *
                                                          0.01),
                                                  textonid(
                                                      context: context,
                                                      text: cardnumber
                                                          .controller.text,
                                                      weigt: true)
                                                ],
                                              )
                                            ]),
                                      )
                                    : Container(
                                        width: mediaquery.size.width * 0.65,
                                        height: mediaquery.size.height * 0.21,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                    'assets/id_card_designs/$backgrounddesign.jpg'))),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: mediaquery.size.height *
                                                  0.015,
                                            ),
                                            textonid(
                                                context: context,
                                                text: cardname.controller.text,
                                                weigt: true),
                                            SizedBox(
                                              height:
                                                  mediaquery.size.height * 0.02,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                SizedBox(
                                                  width: mediaquery.size.width *
                                                      0.04,
                                                ),
                                                ValueListenableBuilder(
                                                  valueListenable:
                                                      profileFunctions
                                                          .profilenotifier,
                                                  builder:
                                                      (context, value, child) {
                                                    if (value.isNotEmpty) {
                                                      return Container(
                                                        height: mediaquery
                                                                .size.height *
                                                            0.1,
                                                        width: mediaquery
                                                                .size.width *
                                                            0.2,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                width: 1.5),
                                                            image: DecorationImage(
                                                                fit:
                                                                    BoxFit.fill,
                                                                image: FileImage(File(
                                                                    profileFunctions
                                                                        .profilenotifier
                                                                        .value[
                                                                            0]
                                                                        .profilepic)))),
                                                      );
                                                    } else {
                                                      return const Text(
                                                          'Loading...');
                                                    }
                                                  },
                                                ),
                                                SizedBox(
                                                  width: mediaquery.size.width *
                                                      0.02,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    textonid(
                                                        context: context,
                                                        text: name
                                                            .controller.text,
                                                        textalign: true),
                                                    SizedBox(
                                                      height: mediaquery
                                                              .size.height *
                                                          0.004,
                                                    ),
                                                    textonid(
                                                        context: context,
                                                        text: additionans1
                                                            .controller.text,
                                                        textalign: true),
                                                    SizedBox(
                                                      height: mediaquery
                                                              .size.height *
                                                          0.004,
                                                    ),
                                                    textonid(
                                                        context: context,
                                                        text: additionans2
                                                            .controller.text,
                                                        textalign: true),
                                                    SizedBox(
                                                      height: mediaquery
                                                              .size.height *
                                                          0.006,
                                                    ),
                                                    textonid(
                                                        context: context,
                                                        text: cardnumber
                                                            .controller.text,
                                                        weigt: true,
                                                        textalign: true)
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                            : const Text('Loading'),
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
                                    'ID Card Details',
                                    style: adddetails,
                                  ),
                                  SizedBox(
                                    height: mediaquery.size.height * 0.05,
                                  ),
                                  addpagelabel('Select Card Design'),
                                  gapfromtitletotextfield(context),
                                  Row(
                                    children: [
                                      NeumorphicRadio(
                                        style: NeumorphicRadioStyle(
                                          selectedColor: mycardcolor,
                                          unselectedColor: mycardcolor,
                                          selectedDepth: -2,
                                          intensity: 1,
                                        ),
                                        value: 'Landscape',
                                        groupValue: carddesingn,
                                        onChanged: (value) {
                                          setState(() {
                                            carddesingn = 'Landscape';
                                            backgrounddesign =
                                                'defaultbg-landscape';
                                          });
                                        },
                                        child: SizedBox(
                                          height:
                                              mediaquery.size.height * 0.055,
                                          width: mediaquery.size.width * 0.28,
                                          child: const Center(
                                              child: Text(
                                            'Landscape',
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
                                        style: NeumorphicRadioStyle(
                                          selectedColor: mycardcolor,
                                          unselectedColor: mycardcolor,
                                          selectedDepth: -2,
                                          intensity: 1,
                                        ),
                                        value: 'Portrait',
                                        groupValue: carddesingn,
                                        onChanged: (value) {
                                          setState(() {
                                            carddesingn = 'Portrait';
                                            backgrounddesign =
                                                'defaultbg_portrait';
                                          });
                                        },
                                        child: SizedBox(
                                          height:
                                              mediaquery.size.height * 0.055,
                                          width: mediaquery.size.width * 0.28,
                                          child: const Center(
                                              child: Text(
                                            'Portrait',
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
                                  addpagelabel('Card Name'),
                                  gapfromtitletotextfield(context),
                                  cardname.mytextfield(
                                      context: context,
                                      hint:
                                          'Enter Card Name (Eg:- Adhaar Card)'),
                                  gapfromtextfieldtotitle(context),
                                  addpagelabel('Name As Per ID Card'),
                                  gapfromtitletotextfield(context),
                                  name.mytextfield(
                                      context: context,
                                      hint: 'Enter Name As Per ID Card'),
                                  gapfromtextfieldtotitle(context),
                                  addpagelabel('Card Number'),
                                  gapfromtitletotextfield(context),
                                  cardnumber.mytextfield(
                                      context: context,
                                      hint:
                                          'Enter Your Unique Card Number or ID'),
                                  gapfromtextfieldtotitle(context),
                                  addpagelabel('Choose Background Design'),
                                  gapfromtitletotextfield(context),
                                  carddesingn == 'Portrait'
                                      ? Row(
                                          children: [
                                            NeumorphicRadio(
                                              style: const NeumorphicRadioStyle(
                                                intensity: 0.5,
                                                selectedDepth: -2,
                                              ),
                                              value: 'defaultbg_portrait',
                                              groupValue: backgrounddesign,
                                              onChanged: (value) {
                                                setState(() {
                                                  backgrounddesign =
                                                      'defaultbg_portrait';
                                                });
                                              },
                                              child: Center(
                                                child: SizedBox(
                                                  width: mediaquery.size.width *
                                                      0.106,
                                                  height:
                                                      mediaquery.size.height *
                                                          0.053,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        image:
                                                            const DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    AssetImage(
                                                                  'assets/id_card_designs/defaultbg_portrait.jpg',
                                                                )),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            width: 2,
                                                            color: backgrounddesign ==
                                                                    'defaultbg_portrait'
                                                                ? Colors.green
                                                                : Colors
                                                                    .black)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  mediaquery.size.width * 0.01,
                                            ),
                                            NeumorphicRadio(
                                              style: const NeumorphicRadioStyle(
                                                intensity: 0.5,
                                                selectedDepth: -2,
                                              ),
                                              value: 'indianbg_portrait',
                                              groupValue: backgrounddesign,
                                              onChanged: (value) {
                                                setState(() {
                                                  backgrounddesign =
                                                      'indianbg_portrait';
                                                });
                                              },
                                              child: Center(
                                                child: SizedBox(
                                                  width: mediaquery.size.width *
                                                      0.106,
                                                  height:
                                                      mediaquery.size.height *
                                                          0.053,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        image: const DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                                'assets/id_card_designs/indianbg_portrait.jpg')),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            width: 2,
                                                            color: backgrounddesign ==
                                                                    'indianbg_portrait'
                                                                ? Colors.green
                                                                : Colors
                                                                    .black)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  mediaquery.size.width * 0.01,
                                            ),
                                            NeumorphicRadio(
                                              style: const NeumorphicRadioStyle(
                                                intensity: 0.5,
                                                selectedDepth: -2,
                                              ),
                                              value: 'background2_portrait',
                                              groupValue: backgrounddesign,
                                              onChanged: (value) {
                                                setState(() {
                                                  backgrounddesign =
                                                      'background2_portrait';
                                                });
                                              },
                                              child: Center(
                                                child: SizedBox(
                                                  width: mediaquery.size.width *
                                                      0.106,
                                                  height:
                                                      mediaquery.size.height *
                                                          0.053,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        image: const DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                                'assets/id_card_designs/background2_portrait.jpg')),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            width: 2,
                                                            color: backgrounddesign ==
                                                                    'background2_portrait'
                                                                ? Colors.green
                                                                : Colors
                                                                    .black)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            NeumorphicRadio(
                                              style: const NeumorphicRadioStyle(
                                                intensity: 0.5,
                                                selectedDepth: -2,
                                              ),
                                              value: 'defaultbg-landscape',
                                              groupValue: backgrounddesign,
                                              onChanged: (value) {
                                                setState(() {
                                                  backgrounddesign =
                                                      'defaultbg-landscape';
                                                });
                                              },
                                              child: Center(
                                                child: SizedBox(
                                                  width: mediaquery.size.width *
                                                      0.106,
                                                  height:
                                                      mediaquery.size.height *
                                                          0.053,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        image:
                                                            const DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    AssetImage(
                                                                  'assets/id_card_designs/defaultbg-landscape.jpg',
                                                                )),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            width: 2,
                                                            color: backgrounddesign ==
                                                                    'defaultbg-landscape'
                                                                ? Colors.green
                                                                : Colors
                                                                    .black)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  mediaquery.size.width * 0.01,
                                            ),
                                            NeumorphicRadio(
                                              style: const NeumorphicRadioStyle(
                                                intensity: 0.5,
                                                selectedDepth: -2,
                                              ),
                                              value: 'indianbg_landscape',
                                              groupValue: backgrounddesign,
                                              onChanged: (value) {
                                                setState(() {
                                                  backgrounddesign =
                                                      'indianbg_landscape';
                                                });
                                              },
                                              child: Center(
                                                child: SizedBox(
                                                  width: mediaquery.size.width *
                                                      0.106,
                                                  height:
                                                      mediaquery.size.height *
                                                          0.053,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        image:
                                                            const DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    AssetImage(
                                                                  'assets/id_card_designs/indianbg_landscape.jpg',
                                                                )),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            width: 2,
                                                            color: backgrounddesign ==
                                                                    'indianbg_landscape'
                                                                ? Colors.green
                                                                : Colors
                                                                    .black)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  mediaquery.size.width * 0.01,
                                            ),
                                            NeumorphicRadio(
                                              style: const NeumorphicRadioStyle(
                                                intensity: 0.5,
                                                selectedDepth: -2,
                                              ),
                                              value: 'background2_landscape',
                                              groupValue: backgrounddesign,
                                              onChanged: (value) {
                                                setState(() {
                                                  backgrounddesign =
                                                      'background2_landscape';
                                                });
                                              },
                                              child: Center(
                                                child: SizedBox(
                                                  width: mediaquery.size.width *
                                                      0.106,
                                                  height:
                                                      mediaquery.size.height *
                                                          0.053,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        image:
                                                            const DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    AssetImage(
                                                                  'assets/id_card_designs/background2_landscape.jpg',
                                                                )),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        border: Border.all(
                                                            width: 2,
                                                            color: backgrounddesign ==
                                                                    'background2_landscape'
                                                                ? Colors.green
                                                                : Colors
                                                                    .black)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  gapfromtextfieldtotitle(context),
                                  addpagelabel(
                                      'Add Additional Informations (Optional)'),
                                  gapfromtitletotextfield(context),
                                  additionlabel1.mytextfield(
                                      context: context,
                                      hint: 'Additional Information Title'),
                                  gapfromtitletotextfield(context),
                                  additionans1.mytextfield(
                                      context: context, hint: 'Enter The Data'),
                                  gapfromtextfieldtotitle(context),
                                  additionlable2.mytextfield(
                                      context: context,
                                      hint: 'Additional Information Title'),
                                  gapfromtitletotextfield(context),
                                  additionans2.mytextfield(
                                      context: context, hint: 'Enter The Data'),
                                  gapfromtextfieldtotitle(context),
                                  NeumorphicButton(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            mediaquery.size.width * 0.055,
                                        vertical:
                                            mediaquery.size.height * 0.0135),
                                    style: NeumorphicStyle(
                                        boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(10),
                                        ),
                                        depth: 3,
                                        intensity: 1,
                                        color: Colors.green),
                                    child: Text(
                                      widget.iseditting == false
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
                                ],
                              ),
                            )),
                      ],
                    ),
                  )))
        ],
      )),
    );
  }

  void validate() {
    if (name.controller.text.isEmpty) {
      emptyfield('Name');
    } else if (cardname.controller.text.isEmpty) {
      emptyfield('Card Name');
    } else if (cardnumber.controller.text.isEmpty) {
      emptyfield('Card Number or ID');
    } else if ((additionlabel1.controller.text.isEmpty &&
            additionans1.controller.text.isNotEmpty) ||
        (additionlabel1.controller.text.isNotEmpty &&
            additionans1.controller.text.isEmpty)) {
      wrong(
          'Both Additional Information Field and Its Data Field Should be Filled');
    } else if ((additionlable2.controller.text.isEmpty &&
            additionans2.controller.text.isNotEmpty) ||
        (additionlable2.controller.text.isNotEmpty &&
            additionans2.controller.text.isEmpty)) {
      wrong(
          'Both Additional Information Field and Its Data Field Should be Filled');
    } else {
      widget.iseditting == true ? update() : submit();
    }
  }

  void submit() async {
    IdCardModel idCardModel = IdCardModel(
        name: name.controller.text.trim(),
        cardname: cardname.controller.text.trim(),
        cardnumber: cardnumber.controller.text.trim(),
        additionalinfotitle1: additionlabel1.controller.text.trim(),
        additionalinfoans1: additionans1.controller.text.trim(),
        additionalinfotitle2: additionlable2.controller.text.trim(),
        additionalinfoans2: additionans2.controller.text.trim(),
        carddesign: carddesingn,
        backgrounddesign: backgrounddesign);
    IdCardFunctions idCardFunctions = IdCardFunctions();
    await idCardFunctions.addIdCard(idCardModel);
    succcess('New ID Card Added Successfully');
    Navigator.of(context).pop();
  }

  void update() async {
    IdCardFunctions idCardFunctions = IdCardFunctions();
    IdCardModel idCardModel = IdCardModel(
        name: name.controller.text,
        cardname: cardname.controller.text,
        cardnumber: cardnumber.controller.text,
        additionalinfotitle1: additionlabel1.controller.text,
        additionalinfoans1: additionans1.controller.text,
        additionalinfotitle2: additionlable2.controller.text,
        additionalinfoans2: additionans2.controller.text,
        carddesign: carddesingn,
        backgrounddesign: backgrounddesign);
    await idCardFunctions.idCardUpdate(idCardModel, widget.index!);
    succcess('ID Card Updated Successfully');
    Navigator.of(context).pop();
    Navigator.of(context).pop();
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

  void getallvalues() {
    final list = IdCardFunctions.idcardlist.value[widget.index!];
    cardname.controller.text = list.cardname;
    name.controller.text = list.name;
    cardnumber.controller.text = list.cardnumber;
    additionlabel1.controller.text = list.additionalinfotitle1;
    additionans1.controller.text = list.additionalinfoans1;
    additionlable2.controller.text = list.additionalinfotitle2;
    additionans2.controller.text = list.additionalinfoans2;
    carddesingn = list.carddesign;
    backgrounddesign = list.backgrounddesign;
  }
}
