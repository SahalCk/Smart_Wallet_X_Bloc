import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lottie/lottie.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/profile_functions.dart';
import 'package:smartwalletx/screens/screen_entry_point.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final MyTextField _pincontroller1 = MyTextField();
  final MyTextField _pincontroller2 = MyTextField();
  final MyTextField _pincontroller3 = MyTextField();
  final MyTextField _pincontroller4 = MyTextField();

  bool visiblityofpinbox = true;

  final storage = const FlutterSecureStorage();

  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    checklogintype();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProfileFunctions profileFunctions = ProfileFunctions();
    profileFunctions.getprofile();
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LottieBuilder.asset(
                'animations/loginpagelottie.json',
                width: mediaquery.size.width,
                height: mediaquery.size.height * 0.5,
                repeat: true,
              ),
              SizedBox(
                height: mediaquery.size.height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mediaquery.size.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: profileFunctions.profilenotifier,
                      builder: (context, value, child) {
                        return SizedBox(
                          width: mediaquery.size.width,
                          child: Text(
                            'Hi, ${profileFunctions.username}',
                            style: hiuser,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: mediaquery.size.height * 0.02,
                    ),
                    const Text(
                      'Enter the 4 digits PIN to login',
                      style: enterpin,
                    ),
                    SizedBox(
                      height: mediaquery.size.height * 0.06,
                    ),
                    Visibility(
                      visible: visiblityofpinbox,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _pincontroller1.pintextfield(
                              context: context, isfirst: true, obscure: true),
                          _pincontroller2.pintextfield(
                              context: context, obscure: true),
                          _pincontroller3.pintextfield(
                              context: context, obscure: true),
                          _pincontroller4.pintextfield(
                              context: context, islast: true, obscure: true),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mediaquery.size.height * 0.065,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: NeumorphicButton(
                        style: NeumorphicStyle(
                            shadowLightColor: shadowcolor,
                            color: background,
                            depth: 3,
                            intensity: 3,
                            shape: NeumorphicShape.convex,
                            boxShape: NeumorphicBoxShape.roundRect(
                                const BorderRadius.all(Radius.circular(10)))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: mediaquery.size.width * 0.1,
                              vertical: mediaquery.size.height * 0.005),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'BalsamiqSans',
                                color: mytextcolor),
                          ),
                        ),
                        onPressed: () {
                          validate(context);
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void validate(BuildContext context1) async {
    if (_pincontroller1.controller.text.isEmpty ||
        _pincontroller2.controller.text.isEmpty ||
        _pincontroller3.controller.text.isEmpty ||
        _pincontroller4.controller.text.isEmpty) {
      pinisempty(context1);
    } else {
      String pin = _pincontroller1.controller.text +
          _pincontroller2.controller.text +
          _pincontroller3.controller.text +
          _pincontroller4.controller.text;

      if (pin == await storage.read(key: 'loginpin')) {
        changingAtLogin();
        await Navigator.of(context1)
            .pushReplacement(MaterialPageRoute(builder: (ctx) {
          return const EntryPointScreen();
        }));
      } else {
        wrongpin(context1);
      }
    }
  }

  void pinisempty(BuildContext context1) {
    ScaffoldMessenger.of(context1).showSnackBar(const SnackBar(
      content: Text("Login PIN Field Is Empty"),
      backgroundColor: Color.fromARGB(255, 248, 85, 74),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
    ));
  }

  void wrongpin(BuildContext context1) {
    ScaffoldMessenger.of(context1).showSnackBar(const SnackBar(
      content: Text("Incorrect Pin. Please Try Again"),
      backgroundColor: Color.fromARGB(255, 248, 85, 74),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
    ));
  }

  Future<void> phoneonly() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: 'Authenticate to Login',
          options: const AuthenticationOptions(
              stickyAuth: true,
              biometricOnly: false,
              sensitiveTransaction: true));
      if (authenticated) {
        setState(() {
          visiblityofpinbox = true;
        });
        changingAtLogin();
        await Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) {
          return const EntryPointScreen();
        }));
      }
    } on PlatformException catch (e) {
      exception(context, e.toString());
    }
  }

  Future<void> both() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: 'Authenticate to Login',
          options: const AuthenticationOptions(
              stickyAuth: true,
              biometricOnly: false,
              sensitiveTransaction: true));
      if (authenticated) {
        setState(() {
          visiblityofpinbox = true;
        });
      }
    } on PlatformException catch (e) {
      exception(context, e.toString());
    }
  }

  void checklogintype() async {
    String? type = await storage.read(key: 'loginmethod');
    if (type == 'smart') {
    } else if (type == 'phone') {
      setState(() {
        visiblityofpinbox = false;
      });
      await phoneonly();
    } else if (type == 'both') {
      setState(() {
        visiblityofpinbox = false;
      });
      await both();
    }
  }

  void exception(BuildContext context1, String exception) {
    ScaffoldMessenger.of(context1).showSnackBar(SnackBar(
      content: Text(exception),
      backgroundColor: const Color.fromARGB(255, 248, 85, 74),
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 2),
    ));
  }
}
