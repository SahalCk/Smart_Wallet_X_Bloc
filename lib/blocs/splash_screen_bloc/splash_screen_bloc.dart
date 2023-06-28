import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:smartwalletx/constants/widgets.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenInitial()) {
    on<InitialEvent>(initialEvent);
  }

  FutureOr<void> initialEvent(
      InitialEvent event, Emitter<SplashScreenState> emit) async {
    await Future.delayed(const Duration(seconds: 3));
    const storage = FlutterSecureStorage();
    if (await storage.read(key: 'isAccountCreated') == 'true') {
      await changingAtSplash();
      emit(NavigateToLoinState());
    } else {
      emit(NavigateToCreateAccountState());
    }
  }
}
