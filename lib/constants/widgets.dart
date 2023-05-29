import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/database/functions/bank_functions.dart';
import 'package:smartwalletx/database/functions/card_functions.dart';
import 'package:smartwalletx/database/functions/id_card_functions.dart';
import 'package:smartwalletx/screens/banks_section/screen_add_edit_bank.dart';
import 'package:smartwalletx/screens/screen_entry_point.dart';

Widget menuoption(
    BuildContext context, String imagepath, String title, Widget screen) {
  var mediaquery = MediaQuery.of(context);
  return SizedBox(
    height: mediaquery.size.height * 0.094,
    width: mediaquery.size.width,
    child: NeumorphicButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return screen;
        }));
      },
      style: NeumorphicStyle(
        shadowLightColor: shadowcolor,
        color: background,
        depth: 3,
        intensity: 1,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(
          const BorderRadius.all(Radius.circular(12)),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            imagepath,
            width: mediaquery.size.width * 0.135,
            height: mediaquery.size.width * 0.135,
          ),
          SizedBox(
            width: mediaquery.size.width * 0.04,
          ),
          Text(title, style: homescreenoptions)
        ],
      ),
    ),
  );
}

Widget menuoption2(
    BuildContext context, String imagepath, String title, Widget screen) {
  var mediaquery = MediaQuery.of(context);
  return SizedBox(
    height: mediaquery.size.height * 0.094,
    width: mediaquery.size.width,
    child: NeumorphicButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) {
          return screen;
        }));
      },
      style: NeumorphicStyle(
        shadowLightColor: shadowcolor,
        color: background,
        depth: 3,
        intensity: 1,
        shape: NeumorphicShape.flat,
        boxShape: NeumorphicBoxShape.roundRect(
          const BorderRadius.all(Radius.circular(12)),
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            imagepath,
            width: mediaquery.size.width * 0.135,
            height: mediaquery.size.width * 0.115,
          ),
          SizedBox(
            width: mediaquery.size.width * 0.04,
          ),
          Text(title, style: homescreenoptions)
        ],
      ),
    ),
  );
}

Widget addcardfloating(var mediaquery, BuildContext context, String textonicon,
    IconData icon, Widget gotoscreen) {
  return NeumorphicButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return gotoscreen;
        }));
      },
      style: NeumorphicStyle(
          shadowLightColor: shadowcolor,
          color: background,
          depth: 4,
          intensity: 1,
          shape: NeumorphicShape.flat,
          boxShape: const NeumorphicBoxShape.stadium()),
      child: SizedBox(
        width: mediaquery.size.width * 0.55,
        height: mediaquery.size.width * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              icon,
              color: mytextcolor,
              size: 35,
            ),
            Text(textonicon, style: floatingbuttontext)
          ],
        ),
      ));
}

Widget appbarwithouttrail(
    String leadingimagepath, String title, BuildContext context) {
  var mediaquery = MediaQuery.of(context);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: mediaquery.size.width * 0.042),
    child: Row(
      children: [
        SizedBox(
          height: mediaquery.size.height * 0.088,
          width: mediaquery.size.width * 0.178,
          child: NeumorphicButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: NeumorphicStyle(
                shadowLightColor: shadowcolor,
                color: background,
                depth: 3,
                intensity: 1,
                shape: NeumorphicShape.convex,
                boxShape: const NeumorphicBoxShape.circle()),
            child: Image.asset(leadingimagepath),
          ),
        ),
        Expanded(
          child: Text(
            title,
            style: appbarheading,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget appbarwithtrailing(String leadingimagepath, String title,
    String trailingimagepath, Widget trailnavigateto, BuildContext context) {
  var mediaquery = MediaQuery.of(context);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: mediaquery.size.width * 0.042),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: mediaquery.size.height * 0.088,
          width: mediaquery.size.width * 0.178,
          child: NeumorphicButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: NeumorphicStyle(
                shadowLightColor: shadowcolor,
                color: background,
                depth: 3,
                intensity: 1,
                shape: NeumorphicShape.convex,
                boxShape: const NeumorphicBoxShape.circle()),
            child: Image.asset(leadingimagepath),
          ),
        ),
        Text(
          title,
          style: appbarheading,
        ),
        SizedBox(
          height: mediaquery.size.height * 0.088,
          width: mediaquery.size.width * 0.178,
          child: NeumorphicButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: ((context) {
                return trailnavigateto;
              })));
            },
            style: NeumorphicStyle(
                shadowLightColor: shadowcolor,
                color: background,
                depth: 3,
                intensity: 1,
                shape: NeumorphicShape.convex,
                boxShape: const NeumorphicBoxShape.circle()),
            child: Image.asset(trailingimagepath),
          ),
        ),
      ],
    ),
  );
}

Widget appbarwithdelete(
    String leadingimagepath,
    String title,
    String trailingimagepath,
    BuildContext context,
    int index,
    String tablename) {
  var mediaquery = MediaQuery.of(context);
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: mediaquery.size.width * 0.042),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: mediaquery.size.height * 0.088,
          width: mediaquery.size.width * 0.178,
          child: NeumorphicButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: NeumorphicStyle(
                shadowLightColor: shadowcolor,
                color: background,
                depth: 3,
                intensity: 1,
                shape: NeumorphicShape.convex,
                boxShape: const NeumorphicBoxShape.circle()),
            child: Image.asset(leadingimagepath),
          ),
        ),
        Text(
          title,
          style: appbarheading,
        ),
        SizedBox(
          height: mediaquery.size.height * 0.088,
          width: mediaquery.size.width * 0.178,
          child: NeumorphicButton(
            onPressed: () {
              showAlert(context, index, tablename);
            },
            style: NeumorphicStyle(
                shadowLightColor: shadowcolor,
                color: background,
                depth: 3,
                intensity: 1,
                shape: NeumorphicShape.convex,
                boxShape: const NeumorphicBoxShape.circle()),
            child: Image.asset(trailingimagepath),
          ),
        ),
      ],
    ),
  );
}

void showAlert(BuildContext context, int index, String tablename) {
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: mycardcolor,
          title: const Text('Do you want to delete '),
          content: const Text(
            'All the related datas will be cleared from the database',
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("No")),
            TextButton(
                onPressed: () async {
                  if (tablename == 'Card') {
                    await CardFunctions.deletecard(index);
                  } else if (tablename == 'ID Card') {
                    IdCardFunctions idCardFunctions = IdCardFunctions();
                    await idCardFunctions.deleteIdCard(
                        IdCardFunctions.idcardlist.value[index].cardnumber);
                  } else if (tablename == 'Bank') {
                    BankFunctions bankFunctions = BankFunctions();
                    await bankFunctions.deleteBank(index);
                  }
                  deletionsucccess(context, tablename);
                  Navigator.of(ctx).pop();
                  Navigator.of(ctx).pop();
                },
                child: const Text("Yes"))
          ],
        );
      });
}

void deletionsucccess(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('$text Deleted Successfully'),
    backgroundColor: const Color.fromARGB(255, 85, 230, 85),
    margin: const EdgeInsets.all(10),
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    closeIconColor: Colors.white,
    duration: const Duration(seconds: 2),
  ));
}

Widget info(BuildContext context, String type) {
  var mediaquery = MediaQuery.of(context);
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: mediaquery.size.height * 0.04,
        width: mediaquery.size.width * 0.065,
        child: Image.asset('assets/info_icon.png'),
      ),
      SizedBox(
        width: mediaquery.size.width * 0.015,
      ),
      SizedBox(
        width: mediaquery.size.width * 0.78,
        height: mediaquery.size.height * 0.05,
        child: Text(
          "Your $type details will be encrypted and stored in your device, we don’t have any access in to that.",
          textAlign: TextAlign.left,
          style: const TextStyle(
              fontSize: 13.2,
              color: Color.fromARGB(255, 33, 150, 243),
              height: 1.1),
        ),
      )
    ],
  );
}

Widget addpagelabel(String label) {
  return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(fontSize: 16),
      ));
}

Widget gapfromtitletotext(BuildContext context) {
  final mediaquery = MediaQuery.of(context);
  return SizedBox(
    height: mediaquery.size.height * 0.005,
  );
}

Widget gapfromtitletotextfield(BuildContext context) {
  var mediaquery = MediaQuery.of(context);
  return SizedBox(
    height: mediaquery.size.height * 0.01,
  );
}

Widget gapfromtextfieldtotitle(BuildContext context) {
  var mediaquery = MediaQuery.of(context);
  return SizedBox(
    height: mediaquery.size.height * 0.04,
  );
}

class MyTextField {
  String? controllertext = '';
  TextEditingController controller = TextEditingController();

  Widget mytextfield(
      {required BuildContext context,
      required String hint,
      bool? isdigitsonly,
      int? limit}) {
    final mediaquery = MediaQuery.of(context);
    return Neumorphic(
      style: NeumorphicStyle(
        color: mycardcolor,
        depth: -2,
        intensity: 1,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
      ),
      padding: EdgeInsets.symmetric(
          vertical: mediaquery.size.height * 0.026,
          horizontal: mediaquery.size.width * 0.046),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration.collapsed(hintText: hint),
        keyboardType:
            isdigitsonly == true ? TextInputType.number : TextInputType.text,
        inputFormatters: [
          limit != null
              ? LengthLimitingTextInputFormatter(limit)
              : LengthLimitingTextInputFormatter(null)
        ],
        style: const TextStyle(color: Color.fromARGB(255, 58, 58, 58)),
      ),
    );
  }

  Widget pintextfield(
      {required BuildContext context,
      bool? islast,
      bool? isfirst,
      required bool obscure}) {
    final mediaquery = MediaQuery.of(context);
    return Neumorphic(
      style: NeumorphicStyle(
          shadowDarkColor: shadowcolor,
          shape: NeumorphicShape.convex,
          depth: -2,
          intensity: 3,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
          color: pintextfieldcolor),
      padding: EdgeInsets.only(
        top: mediaquery.size.width * 0.055,
        bottom: mediaquery.size.width * 0.055,
        left: mediaquery.size.width * 0.056,
        right: mediaquery.size.width * 0.044,
      ),
      child: SizedBox(
        width: mediaquery.size.width * 0.07,
        height: mediaquery.size.height * 0.03,
        child: TextField(
          controller: controller,
          obscureText: obscure,
          obscuringCharacter: 'X',
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          onChanged: (value) {
            if (value.length == 1 && islast == null) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && isfirst == null) {
              FocusScope.of(context).previousFocus();
            }
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: const InputDecoration.collapsed(hintText: ''),
          style: const TextStyle(fontSize: 26, fontFamily: 'BalsamiqSans'),
        ),
      ),
    );
  }
}

Widget profilecountof(
    {required BuildContext context,
    required String title,
    required String count,
    required Color color,
    required Color textcolor}) {
  final mediaquery = MediaQuery.of(context);
  return SizedBox(
    width: mediaquery.size.width * 0.38,
    height: mediaquery.size.height * 0.07,
    child: Neumorphic(
      style: NeumorphicStyle(
          depth: 4,
          intensity: 1,
          color: color,
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
          ),
          Text(
            count,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w900, color: textcolor),
          )
        ],
      ),
    ),
  );
}

Widget textonid(
    {required BuildContext context,
    required String text,
    bool? weigt,
    bool? textalign}) {
  final mediaquery = MediaQuery.of(context);
  return SizedBox(
    width: textalign == false
        ? mediaquery.size.width * 0.95
        : mediaquery.size.width * 0.38,
    child: Text(
      text,
      style: TextStyle(
          color: Colors.black87,
          fontSize: weigt != null ? 17 : 15,
          fontWeight: weigt != null ? FontWeight.w900 : null),
      textAlign: textalign == null ? TextAlign.center : TextAlign.left,
      overflow: TextOverflow.ellipsis,
    ),
  );
}

Widget sidenavoption(
    BuildContext context, String text, IconData icon, Widget? navigatto) {
  final mediaquery = MediaQuery.of(context);
  return SizedBox(
    width: mediaquery.size.width * 0.7,
    height: mediaquery.size.height * 0.08,
    child: NeumorphicButton(
      padding: const EdgeInsets.all(0),
      style: const NeumorphicStyle(
          shape: NeumorphicShape.flat, depth: 0, color: navbarbackground),
      onPressed: () {
        if (navigatto != null) {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return navigatto;
          }));
        } else {
          if (text == 'Exit') {
            onbackbuttonpressed(context);
          } else if (text == 'Home') {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const EntryPointScreen();
              },
            ));
          }
        }
      },
      child: Align(
        alignment: Alignment.center,
        child: Row(
          children: [
            SizedBox(
              width: mediaquery.size.width * 0.035,
            ),
            Icon(
              icon,
              size: mediaquery.size.width * 0.09,
              color: const Color.fromARGB(255, 211, 211, 211),
            ),
            SizedBox(
              width: mediaquery.size.width * 0.03,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: mediaquery.size.width * 0.055,
                  color: const Color.fromARGB(255, 211, 211, 211)),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<bool> onbackbuttonpressed(BuildContext context) async {
  bool? exitapp = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Exit from the App ?'),
      content: const Text('Are you sure you want to close the App?'),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No')),
        TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Yes'))
      ],
    ),
  );
  return exitapp ?? false;
}

Future<void> normalordarkmode() async {
  const storage = FlutterSecureStorage();
  if (!await storage.containsKey(key: 'darkmode')) {
    await storage.write(key: 'darkmode', value: 'false');
  }
  String? darkmodemain = await storage.read(key: 'darkmode');
  if (darkmodemain == 'true') {
    background = const Color.fromARGB(255, 107, 114, 142);
    mytextcolor = const Color.fromARGB(255, 212, 219, 243);
  } else {
    background = const Color.fromARGB(255, 229, 229, 229);
    mytextcolor = const Color.fromARGB(255, 58, 58, 58);
  }
}

Future<void> changingAtSplash() async {
  const storage = FlutterSecureStorage();
  String? darkmodemain = await storage.read(key: 'darkmode');
  if (darkmodemain == 'true') {
    pintextfieldcolor = const Color.fromARGB(255, 209, 217, 243);
    shadowcolor = const Color.fromARGB(255, 142, 146, 182);
  } else {
    pintextfieldcolor = const Color.fromARGB(255, 247, 247, 247);
    shadowcolor = const Color.fromARGB(255, 255, 252, 252);
  }
}

Future<void> changingAtLogin() async {
  const storage = FlutterSecureStorage();
  String? darkmodemain = await storage.read(key: 'darkmode');
  if (darkmodemain == 'true') {
    mycardcolor = const Color.fromARGB(255, 186, 199, 211);
    subtitlecolor = const Color.fromARGB(255, 144, 154, 163);
    notfoundcolor = const Color.fromARGB(255, 77, 77, 77);
  } else {
    mycardcolor = const Color.fromARGB(255, 231, 235, 240);
    subtitlecolor = const Color.fromARGB(255, 114, 114, 114);
    notfoundcolor = const Color.fromARGB(255, 122, 122, 122);
  }
}

Widget bankradio(BuildContext context, String bankname, String logo) {
  final mediaquery = MediaQuery.of(context);
  return Column(
    children: [
      NeumorphicRadio(
        value: bankname,
        groupValue: AddEditBank.bankname.value,
        onChanged: (value) {
          if (value != 'Other Bank') {
            AddEditBank.bankname.value = bankname;
            AddEditBank.bankname.notifyListeners();
          } else {
            MyTextField myTextField = MyTextField();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: mycardcolor,
                  title: const Text('Enter Your Bank Name'),
                  content: myTextField.mytextfield(
                      context: context, hint: 'Enter Bank Name'),
                  actions: [
                    Align(
                      alignment: Alignment.center,
                      child: NeumorphicButton(
                        style: const NeumorphicStyle(
                          color: Colors.green,
                          intensity: 1,
                          depth: 2,
                        ),
                        onPressed: () {
                          AddEditBank.bankname.value =
                              myTextField.controller.text;
                          AddEditBank.bankname.notifyListeners();
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }
        },
        style: NeumorphicRadioStyle(
            selectedColor: mycardcolor,
            unselectedColor: mycardcolor,
            selectedDepth: -2,
            unselectedDepth: 0,
            intensity: 1),
        child: SizedBox(
          width: mediaquery.size.width * 0.65,
          height: mediaquery.size.height * 0.053,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: mediaquery.size.width * 0.03),
            child: Row(
              children: [
                SizedBox(
                  height: mediaquery.size.width * 0.73,
                  width: mediaquery.size.width * 0.085,
                  child: Image.asset(logo),
                ),
                SizedBox(
                  width: mediaquery.size.width * 0.04,
                ),
                Text(bankname)
              ],
            ),
          ),
        ),
      ),
      const Divider()
    ],
  );
}
