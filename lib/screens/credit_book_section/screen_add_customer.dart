import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/constants/widgets.dart';
import 'package:smartwalletx/database/functions/credit_book_functions.dart';
import 'package:smartwalletx/models/customers_model.dart';

File? _image;

class AddEditCustomerScreen extends StatefulWidget {
  final bool isEditting;
  const AddEditCustomerScreen({super.key, required this.isEditting});

  @override
  State<AddEditCustomerScreen> createState() => _AddEditCustomerScreenState();
}

class _AddEditCustomerScreenState extends State<AddEditCustomerScreen> {
  MyTextField customername = MyTextField();
  MyTextField customerphone = MyTextField();
  MyTextField customerwhatsapp = MyTextField();
  CreditBookFunctions creditBookFunctions = CreditBookFunctions();

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: mediaquery.size.height * 0.025,
          ),
          appbarwithouttrail(
              'assets/back_arrow.png',
              widget.isEditting ? 'Edit Customer' : 'Add New Customer',
              context),
          SizedBox(
            height: mediaquery.size.height * 0.025,
          ),
          Expanded(
              child: SingleChildScrollView(
                  padding:
                      EdgeInsets.only(bottom: mediaquery.size.height * 0.02),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mediaquery.size.width * 0.03,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: mediaquery.size.height * 0.035,
                          ),
                          Neumorphic(
                              style: NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  depth: 2,
                                  intensity: 1,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(12)),
                                  color: mycardcolor),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mediaquery.size.width * 0.04,
                                    vertical: mediaquery.size.height * 0.01),
                                child: Column(children: [
                                  SizedBox(
                                    height: mediaquery.size.height * 0.02,
                                  ),
                                  info(context, "customer's"),
                                  SizedBox(
                                    height: mediaquery.size.height * 0.02,
                                  ),
                                  const Text(
                                    'Customer Details',
                                    style: adddetails,
                                  ),
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
                                            boxShape: const NeumorphicBoxShape
                                                .circle(),
                                            color: mycardcolor),
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: _image?.path == null
                                                  ? CircleAvatar(
                                                      radius: mediaquery
                                                              .size.width *
                                                          1,
                                                      backgroundImage:
                                                          const AssetImage(
                                                              'assets/profile_pic.png'),
                                                    )
                                                  : CircleAvatar(
                                                      radius: mediaquery
                                                              .size.width *
                                                          1,
                                                      backgroundImage:
                                                          FileImage(_image!),
                                                    )),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: mediaquery.size.width * 0.02,
                                            bottom:
                                                mediaquery.size.height * 0.005),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: SizedBox(
                                            height:
                                                mediaquery.size.height * 0.055,
                                            child: NeumorphicButton(
                                              onPressed: () {
                                                chooseprofile();
                                              },
                                              style: const NeumorphicStyle(
                                                depth: 1,
                                                shape: NeumorphicShape.convex,
                                                boxShape:
                                                    NeumorphicBoxShape.circle(),
                                                color: Color.fromARGB(
                                                    255, 73, 172, 77),
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
                                  gapfromtextfieldtotitle(context),
                                  addpagelabel('Customer Name'),
                                  gapfromtitletotextfield(context),
                                  customername.mytextfield(
                                      context: context,
                                      hint: 'Enter Customer Name'),
                                  gapfromtextfieldtotitle(context),
                                  addpagelabel('Customer Mobile Number'),
                                  gapfromtitletotextfield(context),
                                  customerphone.mytextfield(
                                      context: context,
                                      hint: 'Enter Customer Mobile Number',
                                      isdigitsonly: true,
                                      limit: 10),
                                  gapfromtextfieldtotitle(context),
                                  addpagelabel('Customer WhatsApp Number'),
                                  gapfromtitletotextfield(context),
                                  customerwhatsapp.mytextfield(
                                      context: context,
                                      hint: 'Enter Customer WhatsApp Number',
                                      isdigitsonly: true,
                                      limit: 10),
                                  gapfromtextfieldtotitle(context),
                                  widget.isEditting == false
                                      ? NeumorphicButton(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  mediaquery.size.width * 0.055,
                                              vertical: mediaquery.size.height *
                                                  0.0135),
                                          style: NeumorphicStyle(
                                              boxShape:
                                                  NeumorphicBoxShape.roundRect(
                                                BorderRadius.circular(10),
                                              ),
                                              depth: 3,
                                              intensity: 1,
                                              color: Colors.green),
                                          child: const Text(
                                            'Add Customer',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
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
                                                      mediaquery.size.width *
                                                          0.055,
                                                  vertical:
                                                      mediaquery.size.height *
                                                          0.0135),
                                              style: NeumorphicStyle(
                                                  boxShape: NeumorphicBoxShape
                                                      .roundRect(
                                                    BorderRadius.circular(10),
                                                  ),
                                                  depth: 3,
                                                  intensity: 1,
                                                  color: Colors.red),
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                cancelShowAlert(context);
                                              },
                                            ),
                                            NeumorphicButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      mediaquery.size.width *
                                                          0.055,
                                                  vertical:
                                                      mediaquery.size.height *
                                                          0.0135),
                                              style: NeumorphicStyle(
                                                  boxShape: NeumorphicBoxShape
                                                      .roundRect(
                                                    BorderRadius.circular(10),
                                                  ),
                                                  depth: 3,
                                                  intensity: 1,
                                                  color: Colors.green),
                                              child: const Text(
                                                'Update Details',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {},
                                            )
                                          ],
                                        ),
                                  gapfromtitletotext(context),
                                  gapfromtitletotext(context),
                                  gapfromtitletotext(context),
                                ]),
                              )),
                        ],
                      ))))
        ],
      )),
    );
  }

  void validate() {
    if (_image == null) {
      wrong('Please Select a Profile Pic');
    } else if (customername.controller.text.isEmpty) {
      wrong('Customer Name Field is Empty');
    } else if (customerphone.controller.text.isEmpty) {
      wrong('Customer Mobile Number Field is Empty');
    } else if (customerphone.controller.text.length < 10) {
      wrong('Please Enter Valid Mobile Number');
    } else if (customerwhatsapp.controller.text.isEmpty) {
      wrong('Customer WhatsApp Number Field is Empty');
    } else if (customerwhatsapp.controller.text.length < 10) {
      wrong('Please Enter Valid WhatsApp Number');
    } else {
      addCustomer();
    }
  }

  void addCustomer() async {
    CustomersModel customersModel = CustomersModel(
        customername: customername.controller.text,
        customerphone: customerphone.controller.text,
        customerwhatsapp: customerwhatsapp.controller.text,
        profilepic: _image!.path);
    await creditBookFunctions.addCustomer(customersModel);
    succcess();
    Navigator.of(context).pop();
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

  void succcess() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('New Customer Added To Credit Book Successfully'),
      backgroundColor: Color.fromARGB(255, 85, 230, 85),
      margin: EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      duration: Duration(seconds: 2),
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
}
