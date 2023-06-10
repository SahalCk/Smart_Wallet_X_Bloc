import 'dart:io';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/bank_functions.dart';
import 'package:smartwalletx/database/functions/card_functions.dart';
import 'package:smartwalletx/database/functions/credit_book_functions.dart';
import 'package:smartwalletx/database/functions/id_card_functions.dart';
import 'package:smartwalletx/database/functions/profile_functions.dart';
import 'package:smartwalletx/screens/profile_section/screen_create_edit_account.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileFunctions profileFunctions = ProfileFunctions();
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
            appbarwithtrailing(
                'assets/back_arrow.png',
                'Profile',
                'assets/edit.png',
                const CreateAccountScren(
                  iseditting: true,
                ),
                context),
            SizedBox(
              height: mediaquery.size.height * 0.012,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: mediaquery.size.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: mediaquery.size.height * 0.02),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: mediaquery.size.width * 0.03,
                        ),
                        child: SizedBox(
                          width: mediaquery.size.width,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: mediaquery.size.height * 0.115,
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width,
                                      child: Neumorphic(
                                        style: NeumorphicStyle(
                                          shape: NeumorphicShape.flat,
                                          intensity: 1,
                                          depth: 2,
                                          color: mycardcolor,
                                        ),
                                        child: ValueListenableBuilder(
                                          valueListenable:
                                              profileFunctions.profilenotifier,
                                          builder: (context, value, child) {
                                            if (value.isNotEmpty) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        mediaquery.size.width *
                                                            0.05),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: mediaquery
                                                              .size.height *
                                                          0.1,
                                                    ),
                                                    Text(
                                                      '@${profileFunctions.profilenotifier.value[0].username}',
                                                      style: adddetails,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        gapfromtextfieldtotitle(
                                                            context),
                                                        gapfromtitletotextfield(
                                                            context),
                                                        addpagelabel(
                                                            'Full Name'),
                                                        gapfromtitletotext(
                                                            context),
                                                        Text(
                                                          profileFunctions
                                                              .profilenotifier
                                                              .value[0]
                                                              .fullname,
                                                          style: formdetails,
                                                        ),
                                                        gapfromtextfieldtotitle(
                                                            context),
                                                        addpagelabel('Email'),
                                                        gapfromtitletotext(
                                                            context),
                                                        Text(
                                                          profileFunctions
                                                              .profilenotifier
                                                              .value[0]
                                                              .email,
                                                          style: formdetails,
                                                        ),
                                                        profileFunctions
                                                                    .profilenotifier
                                                                    .value[0]
                                                                    .alternativeemail !=
                                                                ''
                                                            ? Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  gapfromtextfieldtotitle(
                                                                      context),
                                                                  addpagelabel(
                                                                      'Alternative Email'),
                                                                  gapfromtitletotext(
                                                                      context),
                                                                  Text(
                                                                    profileFunctions
                                                                        .profilenotifier
                                                                        .value[
                                                                            0]
                                                                        .alternativeemail!,
                                                                    style:
                                                                        formdetails,
                                                                  )
                                                                ],
                                                              )
                                                            : const SizedBox(
                                                                height: 0,
                                                              ),
                                                        gapfromtextfieldtotitle(
                                                            context),
                                                        addpagelabel(
                                                            'Mobile Number'),
                                                        gapfromtitletotext(
                                                            context),
                                                        Text(
                                                          '+91 ${profileFunctions.profilenotifier.value[0].phonenumber}',
                                                          style: formdetails,
                                                        ),
                                                        gapfromtextfieldtotitle(
                                                            context),
                                                        profileFunctions
                                                                    .profilenotifier
                                                                    .value[0]
                                                                    .alternativephone !=
                                                                ''
                                                            ? Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  addpagelabel(
                                                                      'Alternative Mobile Number'),
                                                                  gapfromtitletotext(
                                                                      context),
                                                                  Text(
                                                                    '+91 ${profileFunctions.profilenotifier.value[0].alternativephone!}',
                                                                    style:
                                                                        formdetails,
                                                                  ),
                                                                  gapfromtextfieldtotitle(
                                                                      context),
                                                                ],
                                                              )
                                                            : const SizedBox(
                                                                height: 0,
                                                              ),
                                                        gapfromtitletotext(
                                                            context),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            ValueListenableBuilder(
                                                                valueListenable:
                                                                    CardFunctions
                                                                        .cardNotifier,
                                                                builder:
                                                                    (context,
                                                                        value,
                                                                        child) {
                                                                  return profilecountof(
                                                                      context:
                                                                          context,
                                                                      title:
                                                                          'Cards Added',
                                                                      count: CardFunctions
                                                                          .cardNotifier
                                                                          .value
                                                                          .length
                                                                          .toString(),
                                                                      color: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          164,
                                                                          204,
                                                                          254),
                                                                      textcolor: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          0,
                                                                          25,
                                                                          255));
                                                                }),
                                                            ValueListenableBuilder(
                                                                valueListenable:
                                                                    IdCardFunctions
                                                                        .idcardlist,
                                                                builder:
                                                                    (context,
                                                                        value,
                                                                        child) {
                                                                  return profilecountof(
                                                                      context:
                                                                          context,
                                                                      title:
                                                                          'ID Proofs Added',
                                                                      count: IdCardFunctions
                                                                          .idcardlist
                                                                          .value
                                                                          .length
                                                                          .toString(),
                                                                      color: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          254,
                                                                          164,
                                                                          164),
                                                                      textcolor: const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          255,
                                                                          0,
                                                                          0));
                                                                })
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: mediaquery
                                                                  .size.height *
                                                              0.02,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            profilecountof(
                                                                context:
                                                                    context,
                                                                title:
                                                                    'Banks Added',
                                                                count: BankFunctions
                                                                    .banknotifier
                                                                    .value
                                                                    .length
                                                                    .toString(),
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    166,
                                                                    254,
                                                                    164),
                                                                textcolor:
                                                                    const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        0,
                                                                        255,
                                                                        34)),
                                                            profilecountof(
                                                                context:
                                                                    context,
                                                                title:
                                                                    'People in Credit Book',
                                                                count: CreditBookFunctions
                                                                    .customerNotifier
                                                                    .value
                                                                    .length
                                                                    .toString(),
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    254,
                                                                    218,
                                                                    164),
                                                                textcolor:
                                                                    const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        255,
                                                                        107,
                                                                        0))
                                                          ],
                                                        ),
                                                        gapfromtextfieldtotitle(
                                                            context)
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } else {
                                              return const Text('Loading...');
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  height: mediaquery.size.height * 0.2,
                                  width: mediaquery.size.width * 0.45,
                                  child: NeumorphicButton(
                                    onPressed: () {},
                                    style: NeumorphicStyle(
                                        shadowLightColor: shadowcolor,
                                        shape: NeumorphicShape.convex,
                                        intensity: 1,
                                        depth: 3,
                                        boxShape:
                                            const NeumorphicBoxShape.circle(),
                                        color: mycardcolor),
                                    child: ValueListenableBuilder(
                                      valueListenable:
                                          profileFunctions.profilenotifier,
                                      builder: (context, value, child) {
                                        if (value.isNotEmpty) {
                                          return CircleAvatar(
                                            backgroundImage: FileImage(File(
                                                profileFunctions.profilenotifier
                                                    .value[0].profilepic)),
                                          );
                                        } else {
                                          return const Text('Loading...');
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
