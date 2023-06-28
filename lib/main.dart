import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/blocs/splash_screen_bloc/splash_screen_bloc.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/bank_functions.dart';
import 'package:smartwalletx/database/functions/card_functions.dart';
import 'package:smartwalletx/database/functions/credit_book_functions.dart';
import 'package:smartwalletx/database/functions/id_card_functions.dart';
import 'package:smartwalletx/database/functions/profile_functions.dart';
import 'package:smartwalletx/screens/screen_splash.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  ProfileFunctions profileFunctions = ProfileFunctions();
  IdCardFunctions idCardFunctions = IdCardFunctions();
  BankFunctions bankFunctions = BankFunctions();
  CreditBookFunctions creditBookFunctions = CreditBookFunctions();
  WidgetsFlutterBinding.ensureInitialized();
  await profileFunctions.openProfileDB();
  await CardFunctions.openCardDB();
  await idCardFunctions.openIDcardDataBase();
  await bankFunctions.openBankDB();
  await creditBookFunctions.openCreditBookDB();
  await normalordarkmode();
  runApp(const SmartWalletX());
}

class SmartWalletX extends StatelessWidget {
  const SmartWalletX({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => SplashScreenBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'BalsamiqSans',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
