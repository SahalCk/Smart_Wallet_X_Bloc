import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:random_selection_text_animation/random_selection_text_animation.dart';
import 'package:smartwalletx/blocs/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/screens/profile_section/screen_create_edit_account.dart';
import 'package:smartwalletx/screens/screen_login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashScreenBloc splashScreenBloc = SplashScreenBloc();
    splashScreenBloc.add(InitialEvent());
    var mediaquery = MediaQuery.of(context);
    return BlocConsumer<SplashScreenBloc, SplashScreenState>(
      listenWhen: (previous, current) => current is SplashScreenActionState,
      buildWhen: (previous, current) => current is! SplashScreenActionState,
      listener: (context, state) {
        if (state is NavigateToCreateAccountState) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  const CreateAccountScren(iseditting: false)));
        } else if (state is NavigateToLoinState) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      },
      builder: (context, state) {
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
                        future: xicon(context),
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
      },
    );
  }

  Future<Widget> xicon(BuildContext context) async {
    var mediaquery = MediaQuery.of(context);
    await Future.delayed(const Duration(milliseconds: 2000));
    return LottieBuilder.asset(
      'animations/splashscreenX.json',
      width: mediaquery.size.width * 0.375,
      height: mediaquery.size.height * 0.375,
    );
  }
}
