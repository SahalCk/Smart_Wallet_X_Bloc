part of 'splash_screen_bloc.dart';

@immutable
abstract class SplashScreenState {}

class SplashScreenInitial extends SplashScreenState {}

class SplashScreenActionState extends SplashScreenState {}

class NavigateToLoinState extends SplashScreenActionState {}

class NavigateToCreateAccountState extends SplashScreenActionState {}
