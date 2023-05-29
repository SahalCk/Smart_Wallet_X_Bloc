import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/id_card_functions.dart';
import 'package:smartwalletx/database/functions/profile_functions.dart';
import 'package:smartwalletx/screens/id_proofs_section/screen_add_edit_id_card.dart';

class IDCardDetailsScreen extends StatefulWidget {
  final int index;
  const IDCardDetailsScreen({
    super.key,
    required this.index,
  });

  @override
  State<IDCardDetailsScreen> createState() => _IDCardDetailsScreenState();
}

class _IDCardDetailsScreenState extends State<IDCardDetailsScreen> {
  final list = IdCardFunctions.idcardlist.value;
  ProfileFunctions profileFunctions = ProfileFunctions();

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    profileFunctions.getprofile();
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: mediaquery.size.height * 0.025,
            ),
            appbarwithdelete('assets/back_arrow.png', '', 'assets/delete.png',
                context, widget.index, 'ID Card'),
            SizedBox(
              height: mediaquery.size.height * 0.012,
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: mediaquery.size.height * 0.02),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mediaquery.size.width * 0.03),
                child: Column(
                  children: [
                    SizedBox(
                      height: mediaquery.size.height * 0.06,
                    ),
                    Neumorphic(
                        style: NeumorphicStyle(
                            shadowLightColor: shadowcolor,
                            shape: NeumorphicShape.convex,
                            intensity: 1,
                            depth: 10,
                            boxShape: NeumorphicBoxShape.roundRect(
                                const BorderRadius.all(Radius.circular(10)))),
                        child: IdCardFunctions.idcardlist.value[widget.index]
                                    .carddesign ==
                                'Portrait'
                            ? Container(
                                height: mediaquery.size.height * 0.32,
                                width: mediaquery.size.width * 0.425,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                          'assets/id_card_designs/${list[widget.index].backgrounddesign}.jpg',
                                        ))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    textonid(
                                        context: context,
                                        text: list[widget.index].cardname,
                                        weigt: true),
                                    SizedBox(
                                      height: mediaquery.size.height * 0.02,
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable:
                                          profileFunctions.profilenotifier,
                                      builder: (context, value, child) {
                                        if (value.isNotEmpty) {
                                          return CircleAvatar(
                                              radius: mediaquery.size.height *
                                                  0.053,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 82, 82, 82),
                                              child: CircleAvatar(
                                                radius: mediaquery.size.height *
                                                    0.05,
                                                backgroundImage: FileImage(File(
                                                    profileFunctions
                                                        .profilenotifier
                                                        .value[0]
                                                        .profilepic)),
                                              ));
                                        } else {
                                          return const Text('Loading...');
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: mediaquery.size.height * 0.01,
                                    ),
                                    textonid(
                                        context: context,
                                        text: list[widget.index].name),
                                    SizedBox(
                                        height: mediaquery.size.height * 0.005),
                                    textonid(
                                        context: context,
                                        text: list[widget.index]
                                            .additionalinfoans1),
                                    SizedBox(
                                        height: mediaquery.size.height * 0.005),
                                    textonid(
                                        context: context,
                                        text: list[widget.index]
                                            .additionalinfoans2),
                                    SizedBox(
                                        height: mediaquery.size.height * 0.01),
                                    textonid(
                                        context: context,
                                        text: list[widget.index].cardnumber,
                                        weigt: true)
                                  ],
                                ),
                              )
                            : Container(
                                width: mediaquery.size.width * 0.65,
                                height: mediaquery.size.height * 0.21,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            'assets/id_card_designs/${list[widget.index].backgrounddesign}.jpg'))),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: mediaquery.size.height * 0.015,
                                    ),
                                    textonid(
                                        context: context,
                                        text: list[widget.index].cardname,
                                        weigt: true),
                                    SizedBox(
                                      height: mediaquery.size.height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: mediaquery.size.width * 0.04,
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable:
                                              profileFunctions.profilenotifier,
                                          builder: (context, value, child) {
                                            if (value.isNotEmpty) {
                                              return Container(
                                                height: mediaquery.size.height *
                                                    0.1,
                                                width:
                                                    mediaquery.size.width * 0.2,
                                                decoration: BoxDecoration(
                                                    border:
                                                        Border.all(width: 1.5),
                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: FileImage(File(
                                                            profileFunctions
                                                                .profilenotifier
                                                                .value[0]
                                                                .profilepic)))),
                                              );
                                            } else {
                                              return const Text('Loading...');
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          width: mediaquery.size.width * 0.02,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            textonid(
                                                context: context,
                                                text: list[widget.index].name,
                                                textalign: true),
                                            SizedBox(
                                              height: mediaquery.size.height *
                                                  0.004,
                                            ),
                                            textonid(
                                                context: context,
                                                text: list[widget.index]
                                                    .additionalinfoans1,
                                                textalign: true),
                                            SizedBox(
                                              height: mediaquery.size.height *
                                                  0.004,
                                            ),
                                            textonid(
                                                context: context,
                                                text: list[widget.index]
                                                    .additionalinfoans2,
                                                textalign: true),
                                            SizedBox(
                                              height: mediaquery.size.height *
                                                  0.006,
                                            ),
                                            textonid(
                                                context: context,
                                                text: list[widget.index]
                                                    .cardnumber,
                                                weigt: true,
                                                textalign: true)
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )),
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
                                    'ID Card Details',
                                    style: adddetails,
                                  ),
                                ),
                                SizedBox(
                                  height: mediaquery.size.height * 0.05,
                                ),
                                addpagelabel('ID Card Name'),
                                gapfromtitletotext(context),
                                Text(
                                  list[widget.index].cardname,
                                  style: formdetails,
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
                                        addpagelabel('Name As Per ID Card'),
                                        gapfromtitletotext(context),
                                        Text(list[widget.index].name,
                                            style: formdetails),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await Clipboard.setData(ClipboardData(
                                            text: list[widget.index].name));
                                        copytoclipboard('Name As Per ID Card');
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
                                        addpagelabel('Card Number / Unique ID'),
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
                                        copytoclipboard(
                                            'Card Number / Unique ID');
                                      },
                                      icon: const Icon(
                                          Icons.content_copy_rounded),
                                      iconSize: 33,
                                    )
                                  ],
                                ),
                                gapfromtextfieldtotitle(context),
                                list[widget.index]
                                        .additionalinfotitle1
                                        .isNotEmpty
                                    ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  addpagelabel(list[
                                                          widget.index]
                                                      .additionalinfotitle1),
                                                  gapfromtitletotext(context),
                                                  Text(
                                                      list[widget.index]
                                                          .additionalinfoans1,
                                                      style: formdetails),
                                                ],
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  await Clipboard.setData(
                                                      ClipboardData(
                                                          text: list[
                                                                  widget.index]
                                                              .additionalinfoans1));
                                                  copytoclipboard(list[
                                                          widget.index]
                                                      .additionalinfotitle1);
                                                },
                                                icon: const Icon(
                                                    Icons.content_copy_rounded),
                                                iconSize: 33,
                                              )
                                            ],
                                          ),
                                          gapfromtextfieldtotitle(context),
                                        ],
                                      )
                                    : const SizedBox(
                                        height: 0,
                                      ),
                                list[widget.index]
                                        .additionalinfotitle2
                                        .isNotEmpty
                                    ? Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  addpagelabel(list[
                                                          widget.index]
                                                      .additionalinfotitle2),
                                                  gapfromtitletotext(context),
                                                  Text(
                                                      list[widget.index]
                                                          .additionalinfoans2,
                                                      style: formdetails),
                                                ],
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  await Clipboard.setData(
                                                      ClipboardData(
                                                          text: list[
                                                                  widget.index]
                                                              .additionalinfoans2));
                                                  copytoclipboard(list[
                                                          widget.index]
                                                      .additionalinfotitle2);
                                                },
                                                icon: const Icon(
                                                    Icons.content_copy_rounded),
                                                iconSize: 33,
                                              )
                                            ],
                                          ),
                                          gapfromtextfieldtotitle(context),
                                        ],
                                      )
                                    : const SizedBox(
                                        height: 0,
                                      ),
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
                                          'Edit ID Card Details',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (ctx) {
                                        return AddEditIdCardScreen(
                                          index: widget.index,
                                          iseditting: true,
                                        );
                                      }));
                                    },
                                  ),
                                ),
                                gapfromtitletotext(context),
                                gapfromtitletotext(context),
                              ],
                            )))
                  ],
                ),
              ),
            ))
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
