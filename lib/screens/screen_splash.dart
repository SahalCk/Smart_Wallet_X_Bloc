import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:random_selection_text_animation/random_selection_text_animation.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/screens/profile_section/screen_create_edit_account.dart';
import 'package:smartwalletx/screens/screen_login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkIsAccountCreated();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      body: Center(
          child: Padding(
        padding: EdgeInsets.only(left: mediaquery.size.width * 0.063),
        child: SizedBox(
          width: mediaquery.size.width * 1,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: LetterSelectionAnimatedText(
                  textWidget: Text(
                    'Smart Wallet',
                    style: TextStyle(fontSize: 41, color: mytextcolor),
                  ),
                  charSets: const {CharSet.all},
                  framesPerSymbolChange: 4,
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: FutureBuilder<Widget>(
                    future: xicon(),
                    builder: (context, AsyncSnapshot<Widget> snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!;
                      } else if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      } else {
                        return const Text('');
                      }
                    },
                  ))
            ],
          ),
        ),
      )),
    );
  }

  Future<void> checkIsAccountCreated() async {
    await Future.delayed(const Duration(seconds: 3));
    const storage = FlutterSecureStorage();
    if (await storage.read(key: 'isAccountCreated') == 'true') {
      await changingAtSplash();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
        return const CreateAccountScren(
          iseditting: false,
        );
      }));
    }
  }

  Future<Widget> xicon() async {
    var mediaquery = MediaQuery.of(context);
    await Future.delayed(const Duration(milliseconds: 2000));
    return LottieBuilder.asset(
      'animations/splashscreenX.json',
      width: mediaquery.size.width * 0.375,
      height: mediaquery.size.height * 0.375,
    );
  }
}
