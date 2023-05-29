import 'dart:io';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/id_card_functions.dart';
import 'package:smartwalletx/database/functions/profile_functions.dart';
import 'package:smartwalletx/screens/id_proofs_section/screen_add_edit_id_card.dart';
import 'package:smartwalletx/screens/id_proofs_section/screen_idcard_details.dart';
import 'package:smartwalletx/screens/id_proofs_section/screen_idcards_search.dart';

class ViewIDProofsScreen extends StatefulWidget {
  const ViewIDProofsScreen({super.key});

  @override
  State<ViewIDProofsScreen> createState() => _ViewIDProofsScreenState();
}

class _ViewIDProofsScreenState extends State<ViewIDProofsScreen> {
  MyTextField idcardnumber = MyTextField();
  MyTextField name = MyTextField();
  IdCardFunctions idCardFunctions = IdCardFunctions();
  ProfileFunctions profileFunctions = ProfileFunctions();
  @override
  Widget build(BuildContext context) {
    idCardFunctions.getallallIdcards();
    profileFunctions.getprofile();
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      floatingActionButton: addcardfloating(
          mediaquery,
          context,
          'Add New ID',
          Icons.assignment_ind_outlined,
          const AddEditIdCardScreen(iseditting: false)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: mediaquery.size.height * 0.025,
            ),
            appbarwithouttrail(
                'assets/back_arrow.png', 'View ID Cards', context),
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
                    'My ID Cards',
                    style: TextStyle(fontSize: 21, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      showSearch(
                          context: context, delegate: IDCardsSearchScreen());
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
                valueListenable: IdCardFunctions.idcardlist,
                builder: (context, idcardlist, child) {
                  return idcardlist.isNotEmpty
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
                                    return IDCardDetailsScreen(index: index);
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
                                      width: mediaquery.size.width * 0.2,
                                      height: mediaquery.size.height * 0.072,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1.5,
                                            color: const Color.fromARGB(
                                                255, 138, 138, 138)),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/id_card_designs/${idcardlist[index].backgrounddesign}.jpg')),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height:
                                                mediaquery.size.height * 0.016,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: mediaquery.size.width *
                                                    0.02,
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
                                                          0.03,
                                                      width: mediaquery
                                                              .size.width *
                                                          0.06,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 0.5),
                                                          image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: FileImage(File(
                                                                  profileFunctions
                                                                      .profilenotifier
                                                                      .value[0]
                                                                      .profilepic)))),
                                                    );
                                                  } else {
                                                    return const Text(
                                                      'Loading...',
                                                      style: TextStyle(
                                                          fontSize: 3),
                                                    );
                                                  }
                                                },
                                              ),
                                              SizedBox(
                                                width: mediaquery.size.width *
                                                    0.01,
                                              ),
                                              SizedBox(
                                                width:
                                                    mediaquery.size.width * 0.1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      idcardlist[index]
                                                          .cardname,
                                                      style: const TextStyle(
                                                          fontSize: 8,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                    Text(
                                                      idcardlist[index].name,
                                                      style: const TextStyle(
                                                          fontSize: 8,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height:
                                                mediaquery.size.height * 0.0035,
                                          ),
                                          Text(
                                            idcardlist[index].cardnumber,
                                            style: const TextStyle(
                                                fontSize: 9,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ],
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
                                            idcardlist[index].cardname,
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
                                            idcardlist[index].cardnumber,
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
                          itemCount: idcardlist.length)
                      : Center(
                          child: Text(
                            'ID Cards Not Found !',
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
