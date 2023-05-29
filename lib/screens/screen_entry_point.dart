import 'dart:math';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/screens/screen_home.dart';
import 'package:smartwalletx/screens/screen_side_menu.dart';

class EntryPointScreen extends StatefulWidget {
  const EntryPointScreen({super.key});

  @override
  State<EntryPointScreen> createState() => _EntryPointScreenState();
}

class _EntryPointScreenState extends State<EntryPointScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleanimation;
  bool isNavBarOpen = false;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scaleanimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: navbarbackground,
      body: Stack(children: [
        AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastLinearToSlowEaseIn,
            width: mediaquery.size.width * 0.7,
            height: mediaquery.size.height,
            child: const SideMenuScreen()),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value - 30 * animation.value * pi / 180),
          child: Transform.translate(
              offset: Offset(animation.value * mediaquery.size.width * 0.73, 0),
              child: Transform.scale(
                  scale: scaleanimation.value,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(
                          isNavBarOpen == true
                              ? mediaquery.size.width * 0.06
                              : 0)),
                      child: const HomeScreen()))),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  left: isNavBarOpen == true
                      ? mediaquery.size.width * 0.6
                      : mediaquery.size.width * 0.042,
                  top: mediaquery.size.height * 0.025),
              child: SizedBox(
                height: mediaquery.size.height * 0.088,
                width: mediaquery.size.width * 0.178,
                child: NeumorphicButton(
                  onPressed: () {
                    if (isNavBarOpen == false) {
                      _animationController.forward();
                      setState(() {
                        isNavBarOpen = true;
                      });
                    } else {
                      setState(() {
                        _animationController.reverse();
                        isNavBarOpen = false;
                      });
                    }
                  },
                  style: NeumorphicStyle(
                      shadowLightColor: shadowcolor,
                      color:
                          isNavBarOpen == false ? background : navbarbackground,
                      depth: isNavBarOpen ? -3 : 3,
                      intensity: 1,
                      shape: NeumorphicShape.convex,
                      boxShape: const NeumorphicBoxShape.circle()),
                  child: isNavBarOpen
                      ? Image.asset('assets/close.png')
                      : Image.asset('assets/hamberger_menu_icon.png'),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
