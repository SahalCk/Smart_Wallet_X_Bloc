import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/bank_functions.dart';
import 'package:smartwalletx/database/functions/card_functions.dart';
import 'package:smartwalletx/database/functions/credit_book_functions.dart';
import 'package:smartwalletx/database/functions/id_card_functions.dart';
import 'package:smartwalletx/database/functions/profile_functions.dart';
import 'package:smartwalletx/screens/screen_splash.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final storage = const FlutterSecureStorage();
  bool isDarkModeEnabled = false;
  String _appVersion = '';
  String _appName = '';
  MyTextField currentpinbox1 = MyTextField();
  MyTextField currentpinbox2 = MyTextField();
  MyTextField currentpinbox3 = MyTextField();
  MyTextField currentpinbox4 = MyTextField();
  MyTextField newtpinbox1 = MyTextField();
  MyTextField newtpinbox2 = MyTextField();
  MyTextField newtpinbox3 = MyTextField();
  MyTextField newtpinbox4 = MyTextField();
  MyTextField confirmtpinbox1 = MyTextField();
  MyTextField confirmtpinbox2 = MyTextField();
  MyTextField confirmtpinbox3 = MyTextField();
  MyTextField confirmtpinbox4 = MyTextField();
  ValueNotifier<String> loginmethod = ValueNotifier('smart');
  late final LocalAuthentication auth;

  bool _supportState = false;
  @override
  void initState() {
    super.initState();
    _getVersion();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then((bool isSupported) {
      return setState(() {
        _supportState = isSupported;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getisdarkmodeandlocktype();

    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: mediaquery.size.height * 0.025,
            ),
            appbarwithouttrail('assets/back_arrow.png', 'Settings', context),
            SizedBox(
              height: mediaquery.size.height * 0.06,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: mediaquery.size.width * 0.042),
                  child: Column(
                    children: [
                      SizedBox(
                        width: mediaquery.size.width,
                        height: mediaquery.size.height * 0.09,
                        child: Neumorphic(
                          padding: EdgeInsets.symmetric(
                              horizontal: mediaquery.size.width * 0.02),
                          style: NeumorphicStyle(
                              shadowLightColor: shadowcolor,
                              color: background,
                              depth: 2,
                              intensity: 1,
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(10))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: mediaquery.size.height * 0.065,
                                child: Image.asset(
                                  'assets/settings_icons/dark_mode.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                'Dark Mode',
                                style:
                                    TextStyle(color: mytextcolor, fontSize: 21),
                              ),
                              SizedBox(
                                width: mediaquery.size.width * 0.16,
                                height: mediaquery.size.height * 0.042,
                                child: NeumorphicSwitch(
                                  style: const NeumorphicSwitchStyle(
                                      inactiveThumbColor:
                                          Color.fromARGB(255, 253, 216, 53),
                                      inactiveTrackColor:
                                          Color.fromARGB(255, 255, 237, 159),
                                      activeTrackColor:
                                          Color.fromARGB(255, 70, 70, 70),
                                      activeThumbColor:
                                          Color.fromARGB(255, 229, 229, 229)),
                                  value: isDarkModeEnabled,
                                  onChanged: (value) async {
                                    laoding();
                                    if (value == true) {
                                      await storage.write(
                                          key: 'darkmode', value: 'true');
                                      isDarkModeEnabled = true;
                                      await normalordarkmode();
                                      restartapp();
                                      Navigator.of(context).pop();
                                    } else {
                                      await storage.write(
                                          key: 'darkmode', value: 'false');

                                      isDarkModeEnabled = false;
                                      await normalordarkmode();
                                      restartapp();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      gapfromtitletotextfield(context),
                      gapfromtitletotextfield(context),
                      SizedBox(
                        width: mediaquery.size.width,
                        height: mediaquery.size.height * 0.09,
                        child: NeumorphicButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: mediaquery.size.width * 0.02),
                          style: NeumorphicStyle(
                              shadowLightColor: shadowcolor,
                              color: background,
                              depth: 2,
                              intensity: 1,
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(10))),
                          onPressed: () {
                            changePin();
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                height: mediaquery.size.height * 0.065,
                                child: Image.asset(
                                  'assets/settings_icons/reset_pin.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                width: mediaquery.size.width * 0.1,
                              ),
                              Text(
                                'Change Login PIN',
                                style:
                                    TextStyle(color: mytextcolor, fontSize: 21),
                              ),
                            ],
                          ),
                        ),
                      ),
                      gapfromtitletotextfield(context),
                      gapfromtitletotextfield(context),
                      SizedBox(
                        width: mediaquery.size.width,
                        height: mediaquery.size.height * 0.09,
                        child: NeumorphicButton(
                          onPressed: () {
                            changeloginmethod();
                          },
                          padding: EdgeInsets.symmetric(
                              horizontal: mediaquery.size.width * 0.02),
                          style: NeumorphicStyle(
                              shadowLightColor: shadowcolor,
                              color: background,
                              intensity: 1,
                              depth: 2,
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(10))),
                          child: Row(
                            children: [
                              SizedBox(
                                height: mediaquery.size.height * 0.065,
                                child: Image.asset(
                                  'assets/settings_icons/fingerprint.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                width: mediaquery.size.width * 0.08,
                              ),
                              Text(
                                'Change Login Method',
                                style: TextStyle(
                                    color: mytextcolor,
                                    fontSize: 21,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                        ),
                      ),
                      gapfromtitletotextfield(context),
                      gapfromtitletotextfield(context),
                      SizedBox(
                        width: mediaquery.size.width,
                        height: mediaquery.size.height * 0.09,
                        child: NeumorphicButton(
                          onPressed: () {
                            resetpopup();
                          },
                          padding: EdgeInsets.symmetric(
                              horizontal: mediaquery.size.width * 0.02),
                          style: NeumorphicStyle(
                              shadowLightColor: shadowcolor,
                              color: background,
                              intensity: 1,
                              depth: 2,
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(10))),
                          child: Row(
                            children: [
                              SizedBox(
                                height: mediaquery.size.height * 0.065,
                                child: Image.asset(
                                  'assets/settings_icons/reset_app.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                width: mediaquery.size.width * 0.21,
                              ),
                              Text(
                                'Reset App',
                                style:
                                    TextStyle(color: mytextcolor, fontSize: 21),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mediaquery.size.height * 0.3,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            Text(_appName,
                                style: TextStyle(
                                    color: mytextcolor, fontSize: 16)),
                            Text(_appVersion,
                                style: TextStyle(color: mytextcolor))
                          ],
                        ),
                      )
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

  void getisdarkmodeandlocktype() async {
    String? value = await storage.read(key: 'darkmode');
    if (value != null && value.toLowerCase() == 'true') {
      setState(() {
        isDarkModeEnabled = true;
      });
    } else {
      setState(() {
        isDarkModeEnabled = false;
      });
    }
    String? type = await storage.read(key: 'loginmethod');
    if (type == 'smart') {
      setState(() {
        loginmethod.value = 'smart';
      });
    } else if (value != null && type == 'phone') {
      setState(() {
        loginmethod.value = 'phone';
      });
    } else {
      setState(() {
        loginmethod.value = 'both';
      });
    }
  }

  void restartapp() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content:
          Text("Please Restart The App To Reflect The Changes In Your App"),
      backgroundColor: Color.fromARGB(255, 37, 116, 219),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
    ));
  }

  Future<dynamic> laoding() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return AlertDialog(
            contentPadding:
                EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            backgroundColor: mycardcolor,
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: LottieBuilder.asset(
                      'animations/splashscreenX.json',
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                  ),
                  const Text('Loading...')
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> changePin() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
            backgroundColor: mycardcolor,
            title: const Text('Change Login PIN',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04),
                child: Column(
                  children: [
                    gapfromtextfieldtotitle(context),
                    const Text('Enter Current Login PIN',
                        style: TextStyle(fontSize: 16)),
                    gapfromtitletotextfield(context),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          currentpinbox1.pintextfield(
                              context: context, obscure: false, isfirst: true),
                          currentpinbox2.pintextfield(
                              context: context, obscure: false),
                          currentpinbox3.pintextfield(
                              context: context, obscure: false),
                          currentpinbox4.pintextfield(
                              context: context, obscure: false, islast: true)
                        ],
                      ),
                    ),
                    gapfromtextfieldtotitle(context),
                    const Text('Enter New Login PIN',
                        style: TextStyle(fontSize: 16)),
                    gapfromtitletotextfield(context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        newtpinbox1.pintextfield(
                            context: context, obscure: true, isfirst: true),
                        newtpinbox2.pintextfield(
                            context: context, obscure: true),
                        newtpinbox3.pintextfield(
                            context: context, obscure: true),
                        newtpinbox4.pintextfield(
                            context: context, obscure: true, islast: true)
                      ],
                    ),
                    gapfromtextfieldtotitle(context),
                    const Text('Confirm Login PIN',
                        style: TextStyle(fontSize: 16)),
                    gapfromtitletotextfield(context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        confirmtpinbox1.pintextfield(
                            context: context, obscure: false, isfirst: true),
                        confirmtpinbox2.pintextfield(
                            context: context, obscure: false),
                        confirmtpinbox3.pintextfield(
                            context: context, obscure: false),
                        confirmtpinbox4.pintextfield(
                            context: context, obscure: false, islast: true)
                      ],
                    ),
                    gapfromtextfieldtotitle(context),
                    Align(
                      alignment: Alignment.center,
                      child: NeumorphicButton(
                        style: const NeumorphicStyle(
                          color: Colors.green,
                          intensity: 1,
                          depth: 2,
                        ),
                        onPressed: () {
                          validate(context);
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ),
                    gapfromtitletotextfield(context)
                  ],
                ),
              )
            ]);
      },
    );
  }

  void validate(BuildContext context1) async {
    if (currentpinbox1.controller.text.isNotEmpty &&
        currentpinbox2.controller.text.isNotEmpty &&
        currentpinbox3.controller.text.isNotEmpty &&
        currentpinbox4.controller.text.isNotEmpty) {
      if (newtpinbox1.controller.text.isNotEmpty &&
          newtpinbox2.controller.text.isNotEmpty &&
          newtpinbox3.controller.text.isNotEmpty &&
          newtpinbox4.controller.text.isNotEmpty) {
        if (confirmtpinbox1.controller.text.isNotEmpty &&
            confirmtpinbox2.controller.text.isNotEmpty &&
            confirmtpinbox3.controller.text.isNotEmpty &&
            confirmtpinbox4.controller.text.isNotEmpty) {
          final pin = currentpinbox1.controller.text +
              currentpinbox2.controller.text +
              currentpinbox3.controller.text +
              currentpinbox4.controller.text;
          const storage = FlutterSecureStorage();
          if (await storage.read(key: 'loginpin') == pin) {
            if (newtpinbox1.controller.text ==
                    confirmtpinbox1.controller.text &&
                newtpinbox2.controller.text ==
                    confirmtpinbox2.controller.text &&
                newtpinbox3.controller.text ==
                    confirmtpinbox3.controller.text &&
                newtpinbox4.controller.text ==
                    confirmtpinbox4.controller.text) {
              final newpin = newtpinbox1.controller.text +
                  newtpinbox2.controller.text +
                  newtpinbox3.controller.text +
                  newtpinbox4.controller.text;
              await storage.write(key: 'loginpin', value: newpin);
              succcess('PIN Changed Successfully');
              Navigator.of(context).pop();
            } else {
              wrongpin(context1, 'New PIN and Confirm PIN does not match');
            }
          } else {
            wrongpin(context1, 'Incorrect Current PIN ! Please Try Again');
          }
        } else {
          pinisempty(context1, 'Confirm');
        }
      } else {
        pinisempty(context1, 'New');
      }
    } else {
      pinisempty(context1, 'Current');
    }
  }

  void pinisempty(BuildContext context1, String text) {
    ScaffoldMessenger.of(context1).showSnackBar(SnackBar(
      content: Text("$text PIN Field Is Empty"),
      backgroundColor: const Color.fromARGB(255, 248, 85, 74),
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 2),
    ));
  }

  void wrongpin(BuildContext context1, String text) {
    ScaffoldMessenger.of(context1).showSnackBar(SnackBar(
      content: Text(text),
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

  Future<dynamic> changeloginmethod() async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03,
              vertical: MediaQuery.of(context).size.height * 0.02),
          backgroundColor: mycardcolor,
          title:
              const Text('Choose Login Method', style: TextStyle(fontSize: 20)),
          children: [
            ValueListenableBuilder(
                valueListenable: loginmethod,
                builder: (context, value, _) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'smart',
                            groupValue: loginmethod.value,
                            onChanged: (value) async {
                              setState(() {
                                loginmethod.value = value!;
                              });
                              await storage.write(
                                  key: 'loginmethod', value: value);
                            },
                          ),
                          const Text('Smart Wallet X Login PIN',
                              style: TextStyle(fontSize: 16))
                        ],
                      ),
                      _supportState
                          ? Row(
                              children: [
                                Radio(
                                  value: 'phone',
                                  groupValue: loginmethod.value,
                                  onChanged: (value) async {
                                    setState(() {
                                      loginmethod.value = value!;
                                    });
                                    await storage.write(
                                        key: 'loginmethod', value: value);
                                  },
                                ),
                                const Text("Phone's Default Lock",
                                    style: TextStyle(fontSize: 16))
                              ],
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                      _supportState
                          ? Row(
                              children: [
                                Radio(
                                  value: 'both',
                                  groupValue: loginmethod.value,
                                  onChanged: (value) async {
                                    setState(() {
                                      loginmethod.value = value!;
                                    });
                                    await storage.write(
                                        key: 'loginmethod', value: value);
                                  },
                                ),
                                const Text("Both (Prefered)",
                                    style: TextStyle(fontSize: 16))
                              ],
                            )
                          : const SizedBox(
                              height: 0,
                            )
                    ],
                  );
                }),
          ],
        );
      },
    );
  }

  Future<dynamic> resetpopup() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Reset App'),
          content: const Text('Are You Sure You Want To Reset The App?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  laoding();
                  resetApp();
                },
                child: const Text('Confirm'))
          ],
        );
      },
    );
  }

  Future<void> resetApp() async {
    BankFunctions bankFunctions = BankFunctions();
    await bankFunctions.deleteBanksDB();
    await CardFunctions.deleteDatabase();
    IdCardFunctions idCardFunctions = IdCardFunctions();
    await idCardFunctions.deleteDatabase();
    ProfileFunctions profileFunctions = ProfileFunctions();
    await profileFunctions.deleteDatabase();
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
    CreditBookFunctions creditBookFunctions = CreditBookFunctions();
    await creditBookFunctions.deleteDatabase();
    succcess('App Resetted Successfully');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
        (route) => false);
  }

  Future<void> _getVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = info.version;
      _appName = info.appName;
    });
  }
}
