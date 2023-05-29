import 'dart:io';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/profile_functions.dart';
import 'package:smartwalletx/screens/banks_section/screen_view_banks.dart';
import 'package:smartwalletx/screens/cards_section/screen_view_cards.dart';
import 'package:smartwalletx/screens/credit_book_section/screen_view_creditbook.dart';
import 'package:smartwalletx/screens/id_proofs_section/scree_view_proofs.dart';
import 'package:smartwalletx/screens/profile_section/screen_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ProfileFunctions profileFunctions = ProfileFunctions();
    profileFunctions.getprofile();
    var mediaquery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () => onbackbuttonpressed(context),
      child: Scaffold(
        backgroundColor: background,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: mediaquery.size.height * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: mediaquery.size.width * 0.042),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: mediaquery.size.width * 0.165,
                      ),
                      Text(
                        'Home',
                        style: appbarheading,
                      ),
                      SizedBox(
                        height: mediaquery.size.height * 0.088,
                        width: mediaquery.size.width * 0.178,
                        child: NeumorphicButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: ((context) {
                              return const ProfileScreen();
                            })));
                          },
                          style: NeumorphicStyle(
                              shadowLightColor: shadowcolor,
                              color: background,
                              depth: 3,
                              intensity: 1,
                              shape: NeumorphicShape.convex,
                              boxShape: const NeumorphicBoxShape.circle()),
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: ValueListenableBuilder(
                                valueListenable:
                                    profileFunctions.profilenotifier,
                                builder: (context, value, child) {
                                  if (value.isNotEmpty) {
                                    return Image.file(
                                        File(value[0].profilepic));
                                  } else {
                                    return const Text('Loading');
                                  }
                                },
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: mediaquery.size.height * 0.06,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: mediaquery.size.width * 0.057),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: profileFunctions.profilenotifier,
                        builder: (context, value, child) {
                          if (value.isNotEmpty) {
                            return SizedBox(
                              width: mediaquery.size.width,
                              child: Text(
                                'Hi, ${value[0].username}',
                                style: hiuser,
                              ),
                            );
                          } else {
                            return SizedBox(
                              width: mediaquery.size.width,
                              child: Text(
                                'Loading...',
                                style: hiuser,
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: mediaquery.size.height * 0.09,
                      ),
                      menuoption(context, 'assets/credit_card.png',
                          'View Card Details', const ViewCardsScreen()),
                      SizedBox(
                        height: mediaquery.size.height * 0.031,
                      ),
                      menuoption(context, 'assets/id_card.png',
                          'View ID Card Details', const ViewIDProofsScreen()),
                      SizedBox(
                        height: mediaquery.size.height * 0.031,
                      ),
                      menuoption2(context, 'assets/bank.png',
                          'View Bank Details', const ViewBanksScreen()),
                      SizedBox(
                        height: mediaquery.size.height * 0.031,
                      ),
                      menuoption2(context, 'assets/credit_book.png',
                          'View Credit Book', ViewCreditBookScreen()),
                      SizedBox(
                        height: mediaquery.size.height * 0.115,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/secure.png',
                            width: 32,
                            height: 32,
                          ),
                          SizedBox(
                            width: mediaquery.size.width * 0.02,
                          ),
                          SizedBox(
                            height: mediaquery.size.height * 0.06,
                            width: mediaquery.size.width * 0.76,
                            child: const Text(
                              'All your datas are Encrypted and Stored in your in your device offline, We dont have any access in to that',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 143, 143, 143)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
