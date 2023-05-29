import 'dart:io';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/profile_functions.dart';
import 'package:smartwalletx/screens/navigation_bar_section/screen_privacy_policy.dart';
import 'package:smartwalletx/screens/navigation_bar_section/screen_settings.dart';
import 'package:smartwalletx/screens/navigation_bar_section/screen_terms_and_conditions.dart';

class SideMenuScreen extends StatefulWidget {
  const SideMenuScreen({super.key});

  @override
  State<SideMenuScreen> createState() => _SideMenuScreenState();
}

class _SideMenuScreenState extends State<SideMenuScreen> {
  ProfileFunctions profileFunctions = ProfileFunctions();
  @override
  Widget build(BuildContext context) {
    profileFunctions.getprofile();
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: mediaquery.size.height,
        width: mediaquery.size.width * 0.73,
        color: navbarbackground,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: mediaquery.size.height * 0.12,
                ),
                ValueListenableBuilder(
                  valueListenable: profileFunctions.profilenotifier,
                  builder: (context, value, child) {
                    return value.isNotEmpty
                        ? Row(
                            children: [
                              SizedBox(
                                width: mediaquery.size.width * 0.035,
                              ),
                              CircleAvatar(
                                radius: mediaquery.size.width * 0.08,
                                backgroundColor:
                                    const Color.fromARGB(255, 211, 211, 211),
                                child: CircleAvatar(
                                  radius: mediaquery.size.width * 0.074,
                                  backgroundImage: FileImage(File(
                                      profileFunctions.profilenotifier.value[0]
                                          .profilepic)),
                                ),
                              ),
                              SizedBox(
                                width: mediaquery.size.width * 0.04,
                              ),
                              SizedBox(
                                width: mediaquery.size.width * 0.45,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profileFunctions
                                          .profilenotifier.value[0].username,
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 211, 211, 211),
                                          fontSize: 24,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    Text(
                                        profileFunctions
                                            .profilenotifier.value[0].email,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 211, 211, 211),
                                            overflow: TextOverflow.ellipsis))
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const Text('Loading...');
                  },
                ),
                SizedBox(
                  height: mediaquery.size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.only(left: mediaquery.size.width * 0.04),
                  child: const Divider(
                    color: Color.fromARGB(255, 211, 211, 211),
                  ),
                ),
                SizedBox(
                  height: mediaquery.size.height * 0.01,
                ),
                sidenavoption(context, 'Home', Icons.home, null),
                SizedBox(
                  height: mediaquery.size.height * 0.01,
                ),
                sidenavoption(context, 'Terms and Conditions',
                    Icons.rule_rounded, const TermsAndConditionsScreen()),
                SizedBox(
                  height: mediaquery.size.height * 0.01,
                ),
                sidenavoption(
                    context,
                    'Privacy Policy',
                    Icons.format_list_bulleted_rounded,
                    const PrivacyPolicyScreen()),
                SizedBox(
                  height: mediaquery.size.height * 0.01,
                ),
                sidenavoption(context, 'Settings', Icons.settings,
                    const SettingsScreen()),
                SizedBox(
                  height: mediaquery.size.height * 0.01,
                ),
                sidenavoption(context, 'Exit', Icons.exit_to_app_rounded, null),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
