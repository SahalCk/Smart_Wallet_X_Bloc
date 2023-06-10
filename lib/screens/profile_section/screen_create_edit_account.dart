import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/profile_functions.dart';
import 'package:smartwalletx/models/profile_model.dart';
import 'package:smartwalletx/screens/profile_section/screen_profile.dart';
import 'package:smartwalletx/screens/screen_entry_point.dart';

File? _image;

class CreateAccountScren extends StatefulWidget {
  final bool iseditting;
  const CreateAccountScren({super.key, required this.iseditting});

  @override
  State<CreateAccountScren> createState() => _CreateAccountScrenState();
}

class _CreateAccountScrenState extends State<CreateAccountScren> {
  ProfileFunctions profileFunctions = ProfileFunctions();
  MyTextField fullname = MyTextField();
  MyTextField username = MyTextField();
  MyTextField phonenumber = MyTextField();
  MyTextField alternumber = MyTextField();
  MyTextField email = MyTextField();
  MyTextField altermail = MyTextField();
  final MyTextField _firstpin = MyTextField();
  final MyTextField _confirmfirstpin = MyTextField();
  final MyTextField _secondpin = MyTextField();
  final MyTextField _confirmsecondpin = MyTextField();
  final MyTextField _thirdpin = MyTextField();
  final MyTextField _confirmthirdpin = MyTextField();
  final MyTextField _fourth = MyTextField();
  final MyTextField _confirmfourth = MyTextField();

  @override
  void initState() {
    if (widget.iseditting == true) {
      settingvalues();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: mediaquery.size.height * 0.03,
            ),
            widget.iseditting == false
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mediaquery.size.width * 0.042,
                        vertical: mediaquery.size.height * 0.02),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Create Account',
                        style: hiuser,
                      ),
                    ))
                : Column(
                    children: [
                      appbarwithouttrail(
                          'assets/back_arrow.png', 'Edit profile', context),
                      SizedBox(
                        height: mediaquery.size.height * 0.012,
                      )
                    ],
                  ),
            SizedBox(
              height: mediaquery.size.height * 0.012,
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: mediaquery.size.height * 0.02),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: mediaquery.size.width * 0.03,
                ),
                child: Neumorphic(
                    style: NeumorphicStyle(
                        depth: 2,
                        intensity: 1,
                        shape: NeumorphicShape.flat,
                        color: mycardcolor,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(10))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: mediaquery.size.width * 0.04,
                          vertical: mediaquery.size.height * 0.01),
                      child: Column(
                        children: [
                          SizedBox(
                            height: mediaquery.size.height * 0.05,
                          ),
                          SizedBox(
                            height: mediaquery.size.height * 0.2,
                            width: mediaquery.size.width * 0.44,
                            child: Stack(children: [
                              NeumorphicButton(
                                onPressed: () {
                                  chooseprofile();
                                },
                                style: NeumorphicStyle(
                                    depth: 4,
                                    boxShape: const NeumorphicBoxShape.circle(),
                                    color: mycardcolor),
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: _image?.path == null
                                          ? CircleAvatar(
                                              radius: mediaquery.size.width * 1,
                                              backgroundImage: const AssetImage(
                                                  'assets/profile_pic.png'),
                                            )
                                          : CircleAvatar(
                                              radius: mediaquery.size.width * 1,
                                              backgroundImage:
                                                  FileImage(_image!),
                                            )),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: mediaquery.size.width * 0.02,
                                    bottom: mediaquery.size.height * 0.005),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    height: mediaquery.size.height * 0.055,
                                    child: NeumorphicButton(
                                      onPressed: () {
                                        chooseprofile();
                                      },
                                      style: const NeumorphicStyle(
                                        depth: 1,
                                        shape: NeumorphicShape.convex,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        color: Color.fromARGB(255, 73, 172, 77),
                                      ),
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        color: background,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ),
                          SizedBox(
                            height: mediaquery.size.height * 0.05,
                          ),
                          addpagelabel('Full Name'),
                          gapfromtitletotextfield(context),
                          fullname.mytextfield(
                              context: context, hint: 'Enter Your Full Name'),
                          gapfromtextfieldtotitle(context),
                          addpagelabel('User Name'),
                          gapfromtitletotextfield(context),
                          username.mytextfield(
                              context: context, hint: 'Enter Your User Name'),
                          gapfromtextfieldtotitle(context),
                          addpagelabel('Email'),
                          gapfromtitletotextfield(context),
                          email.mytextfield(
                              context: context, hint: 'Enter Your Email'),
                          gapfromtextfieldtotitle(context),
                          addpagelabel('Alternative Email'),
                          gapfromtitletotextfield(context),
                          altermail.mytextfield(
                              context: context,
                              hint: 'Enter Your Alternative Email (Optional)'),
                          gapfromtextfieldtotitle(context),
                          addpagelabel('Mobile Number'),
                          phonenumber.mytextfield(
                              context: context,
                              hint: 'Enter Your Mobile Number',
                              isdigitsonly: true,
                              limit: 10),
                          gapfromtextfieldtotitle(context),
                          addpagelabel('Alternative Mobile Number'),
                          gapfromtitletotextfield(context),
                          alternumber.mytextfield(
                              context: context,
                              hint: 'Enter Your Alternative Number (Optional)',
                              isdigitsonly: true,
                              limit: 10),
                          gapfromtextfieldtotitle(context),
                          widget.iseditting == false
                              ? Column(
                                  children: [
                                    addpagelabel('Set 4 Digits login PIN'),
                                    gapfromtitletotextfield(context),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _firstpin.pintextfield(
                                            context: context,
                                            isfirst: true,
                                            obscure: true),
                                        _secondpin.pintextfield(
                                            context: context, obscure: true),
                                        _thirdpin.pintextfield(
                                            context: context, obscure: true),
                                        _fourth.pintextfield(
                                            context: context,
                                            islast: true,
                                            obscure: true),
                                      ],
                                    ),
                                    gapfromtextfieldtotitle(context),
                                    addpagelabel('Confirm login PIN'),
                                    gapfromtitletotextfield(context),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _confirmfirstpin.pintextfield(
                                            context: context,
                                            isfirst: true,
                                            obscure: false),
                                        _confirmsecondpin.pintextfield(
                                            context: context, obscure: false),
                                        _confirmthirdpin.pintextfield(
                                            context: context, obscure: false),
                                        _confirmfourth.pintextfield(
                                            context: context,
                                            islast: true,
                                            obscure: false),
                                      ],
                                    ),
                                    gapfromtitletotextfield(context),
                                    gapfromtextfieldtotitle(context),
                                  ],
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                          widget.iseditting == false
                              ? NeumorphicButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: mediaquery.size.width * 0.055,
                                      vertical:
                                          mediaquery.size.height * 0.0135),
                                  style: NeumorphicStyle(
                                      boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(10),
                                      ),
                                      depth: 3,
                                      intensity: 1,
                                      color: Colors.green),
                                  child: const Text(
                                    'Create An Account',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  onPressed: () {
                                    validate();
                                  },
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    NeumorphicButton(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              mediaquery.size.width * 0.055,
                                          vertical:
                                              mediaquery.size.height * 0.0135),
                                      style: NeumorphicStyle(
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(10),
                                          ),
                                          depth: 3,
                                          intensity: 1,
                                          color: Colors.red),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      onPressed: () {
                                        cancelShowAlert(context);
                                      },
                                    ),
                                    NeumorphicButton(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              mediaquery.size.width * 0.055,
                                          vertical:
                                              mediaquery.size.height * 0.0135),
                                      style: NeumorphicStyle(
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(10),
                                          ),
                                          depth: 3,
                                          intensity: 1,
                                          color: Colors.green),
                                      child: const Text(
                                        'Update',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      onPressed: () {
                                        update();
                                      },
                                    )
                                  ],
                                ),
                          gapfromtitletotext(context),
                          gapfromtitletotext(context),
                          gapfromtitletotext(context),
                        ],
                      ),
                    )),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> validate() async {
    if (fullname.controller.text.isEmpty) {
      emptyfield('Full Name');
    } else if (username.controller.text.isEmpty) {
      emptyfield('User Name');
    } else if (email.controller.text.isEmpty) {
      emptyfield('Email');
    } else if (mailvalidation(email.controller.text)) {
      wrong('Please Enter Valid Email');
    } else if (altermail.controller.text.isNotEmpty &&
        (mailvalidation(altermail.controller.text))) {
      wrong('Please Enter Valid Alternative Email');
    } else if (phonenumber.controller.text.isEmpty) {
      emptyfield('Mobile Number');
    } else if (phonenumber.controller.text.length < 10) {
      wrong('Please Enter Valid Mobile Number');
    } else if (alternumber.controller.text.isNotEmpty &&
        alternumber.controller.text.length < 10) {
      wrong('Please Enter Valid Alternative Mobile Number');
    } else if (_image?.path == null) {
      wrong('Please Select a Profile Picture');
    } else if (_firstpin.controller.text.isNotEmpty &&
        _secondpin.controller.text.isNotEmpty &&
        _thirdpin.controller.text.isNotEmpty &&
        _fourth.controller.text.isNotEmpty) {
      if (_firstpin.controller.text == _confirmfirstpin.controller.text &&
          _secondpin.controller.text == _confirmsecondpin.controller.text &&
          _thirdpin.controller.text == _confirmthirdpin.controller.text &&
          _fourth.controller.text == _confirmfourth.controller.text) {
        final loginpin = _firstpin.controller.text +
            _secondpin.controller.text +
            _thirdpin.controller.text +
            _fourth.controller.text;
        const storage = FlutterSecureStorage();
        await storage.write(key: 'loginpin', value: loginpin);
        await storage.write(key: 'isAccountCreated', value: 'true');
        await storage.write(key: 'loginmethod', value: 'smart');
        ProfileFunctions profileFunctions = ProfileFunctions();
        ProfileModel profileModel = ProfileModel(
            fullname: fullname.controller.text,
            username: username.controller.text,
            email: email.controller.text,
            alternativeemail: altermail.controller.text,
            phonenumber: phonenumber.controller.text,
            alternativephone: alternumber.controller.text,
            profilepic: _image!.path);
        await profileFunctions.createProfile(profileModel);
        await profileFunctions.getprofile();
        await successpopup();
        changingAtLogin();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
          return const EntryPointScreen();
        }));
      } else {
        wrong('Pin Mismatches with Confirm PIN');
      }
    }
  }

  bool mailvalidation(String email) {
    if (!email.contains('@') || !email.contains('.')) {
      return true;
    } else {
      final splitted = email.split('@');
      if (splitted[0].isEmpty) {
        return true;
      } else if (splitted[1].isEmpty) {
        return true;
      }
    }
    return false;
  }

  void emptyfield(String field) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$field field is Empty"),
      backgroundColor: const Color.fromARGB(255, 248, 85, 74),
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 2),
    ));
  }

  void wrong(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: const Color.fromARGB(255, 248, 85, 74),
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: const Duration(seconds: 2),
    ));
  }

  Future<dynamic> chooseprofile() async {
    final mediaquery = MediaQuery.of(context);
    return showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(mediaquery.size.height * 0.025),
            backgroundColor: background,
            title: Text(
              'Choose Profile Photo From',
              style: TextStyle(color: mytextcolor),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            children: [
              SizedBox(
                height: mediaquery.size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NeumorphicButton(
                    style: NeumorphicStyle(
                        shadowLightColor: shadowcolor,
                        depth: 5,
                        color: background,
                        shape: NeumorphicShape.convex,
                        boxShape: const NeumorphicBoxShape.circle()),
                    child: Column(
                      children: [
                        Icon(
                          Icons.photo,
                          color: mytextcolor,
                          size: 35,
                        ),
                        const Text('Gallery')
                      ],
                    ),
                    onPressed: () {
                      capturephotofromgallery();
                    },
                  ),
                  NeumorphicButton(
                    style: NeumorphicStyle(
                        shadowLightColor: shadowcolor,
                        depth: 5,
                        color: background,
                        shape: NeumorphicShape.convex,
                        boxShape: const NeumorphicBoxShape.circle()),
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt_rounded,
                          color: mytextcolor,
                          size: 35,
                        ),
                        const Text('Camera')
                      ],
                    ),
                    onPressed: () {
                      capturephotofromcamera();
                    },
                  ),
                  NeumorphicButton(
                    style: NeumorphicStyle(
                        shadowLightColor: shadowcolor,
                        depth: 5,
                        color: background,
                        shape: NeumorphicShape.convex,
                        boxShape: const NeumorphicBoxShape.circle()),
                    child: Column(
                      children: [
                        Icon(
                          Icons.person_2_rounded,
                          color: mytextcolor,
                          size: 35,
                        ),
                        const Text('Avatar')
                      ],
                    ),
                    onPressed: () {
                      selectavatar();
                    },
                  ),
                ],
              ),
              SizedBox(
                height: mediaquery.size.height * 0.03,
              )
            ],
          );
        });
  }

  Future<void> capturephotofromgallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    final imagetemporary = File(image.path);

    setState(() {
      _image = imagetemporary;
    });
    Navigator.of(context).pop();
  }

  Future<void> capturephotofromcamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }

    final imagetemporary = File(image.path);

    setState(() {
      _image = imagetemporary;
    });
    Navigator.of(context).pop();
  }

  Future<dynamic> selectavatar() async {
    final mediaquery = MediaQuery.of(context);
    ValueNotifier<String> avatar = ValueNotifier('boy1');
    return showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(mediaquery.size.height * 0.025),
            backgroundColor: background,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const Text('Choose An Avatar'),
            children: [
              ValueListenableBuilder(
                valueListenable: avatar,
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NeumorphicRadio(
                        value: 'boy1',
                        groupValue: avatar,
                        onChanged: (value) {
                          avatar.value = 'boy1';
                          avatar.notifyListeners();
                        },
                        style: const NeumorphicRadioStyle(
                            boxShape: NeumorphicBoxShape.circle(),
                            intensity: 0.5,
                            selectedDepth: -2),
                        child: CircleAvatar(
                          radius: mediaquery.size.width * 0.085,
                          backgroundColor: avatar.value == 'boy1'
                              ? const Color.fromARGB(255, 57, 131, 59)
                              : Colors.black,
                          child: CircleAvatar(
                            radius: mediaquery.size.width * 0.080,
                            backgroundImage: const AssetImage(
                                'assets/avatars/boy1_avatar.png'),
                          ),
                        ),
                      ),
                      NeumorphicRadio(
                        value: 'boy2',
                        groupValue: avatar,
                        onChanged: (value) {
                          avatar.value = 'boy2';
                          avatar.notifyListeners();
                        },
                        style: const NeumorphicRadioStyle(
                            boxShape: NeumorphicBoxShape.circle(),
                            intensity: 0.5,
                            selectedDepth: -2),
                        child: CircleAvatar(
                          radius: mediaquery.size.width * 0.085,
                          backgroundColor: avatar.value == 'boy2'
                              ? const Color.fromARGB(255, 57, 131, 59)
                              : Colors.black,
                          child: CircleAvatar(
                            radius: mediaquery.size.width * 0.080,
                            backgroundImage: const AssetImage(
                                'assets/avatars/boy2_avatar.png'),
                          ),
                        ),
                      ),
                      NeumorphicRadio(
                        value: 'girl1',
                        groupValue: avatar,
                        onChanged: (value) {
                          avatar.value = 'girl1';
                          avatar.notifyListeners();
                        },
                        style: const NeumorphicRadioStyle(
                            boxShape: NeumorphicBoxShape.circle(),
                            intensity: 0.5,
                            selectedDepth: -2),
                        child: CircleAvatar(
                          radius: mediaquery.size.width * 0.085,
                          backgroundColor: avatar.value == 'girl1'
                              ? const Color.fromARGB(255, 57, 131, 59)
                              : Colors.black,
                          child: CircleAvatar(
                            radius: mediaquery.size.width * 0.080,
                            backgroundImage: const AssetImage(
                                'assets/avatars/girl1_avatar.png'),
                          ),
                        ),
                      ),
                      NeumorphicRadio(
                        value: 'girl2',
                        groupValue: avatar,
                        onChanged: (value) {
                          avatar.value = 'girl2';
                          avatar.notifyListeners();
                        },
                        style: const NeumorphicRadioStyle(
                            boxShape: NeumorphicBoxShape.circle(),
                            intensity: 0.5,
                            selectedDepth: -2),
                        child: CircleAvatar(
                          radius: mediaquery.size.width * 0.085,
                          backgroundColor: avatar.value == 'girl2'
                              ? const Color.fromARGB(255, 57, 131, 59)
                              : Colors.black,
                          child: CircleAvatar(
                            radius: mediaquery.size.width * 0.080,
                            backgroundImage: const AssetImage(
                                'assets/avatars/girl2_avatar.png'),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              SizedBox(
                height: mediaquery.size.height * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child:
                          const Text('Cancel', style: TextStyle(fontSize: 18))),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        final myimage = await getAssetImagePath(
                            'assets/avatars/${avatar.value}_avatar.png');
                        setState(() {
                          _image = File(myimage);
                        });
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child:
                          const Text('Confirm', style: TextStyle(fontSize: 18)))
                ],
              )
            ],
          );
        });
  }

  Future<String> getAssetImagePath(String assetPath) async {
    final ByteData assetData = await rootBundle.load(assetPath);
    final List<int> bytes = assetData.buffer.asUint8List();
    final Directory tempDir = Directory.systemTemp;
    final File tempFile = File('${tempDir.path}/${assetPath.split('/').last}');
    await tempFile.writeAsBytes(bytes, flush: true);
    return tempFile.path;
  }

  Future<dynamic> successpopup() async {
    return showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: background,
            children: [
              LottieBuilder.asset(
                'animations/success.json',
                repeat: false,
              ),
              const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Account Created Successfully',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          );
        });
  }

  void settingvalues() async {
    await profileFunctions.getprofile();
    final value = profileFunctions.profilenotifier.value[0];
    fullname.controller.text = value.fullname;
    username.controller.text = value.username;
    email.controller.text = value.email;
    altermail.controller.text = value.alternativeemail!;
    phonenumber.controller.text = value.phonenumber;
    alternumber.controller.text = value.phonenumber;
    _image = File(value.profilepic);
  }

  void cancelShowAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Do you want to cancel?'),
            content: const Text(
              'All the modified datas will be cleared and not stored anywhere',
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }

  void update() async {
    ProfileModel profileModel = ProfileModel(
        fullname: fullname.controller.text,
        username: username.controller.text,
        email: email.controller.text,
        alternativeemail: altermail.controller.text,
        phonenumber: phonenumber.controller.text,
        alternativephone: alternumber.controller.text,
        profilepic: _image!.path);
    await profileFunctions.updateprofile(profileModel);
    succcess();
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      return const ProfileScreen();
    }));
  }

  void succcess() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Profile Updated Successfully'),
      backgroundColor: Color.fromARGB(255, 85, 230, 85),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
    ));
  }
}
