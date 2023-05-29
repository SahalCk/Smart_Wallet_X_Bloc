import 'dart:io';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:smartwalletx/constants/colors.dart';
import 'package:smartwalletx/constants/textstyles.dart';
import 'package:smartwalletx/database/functions/id_card_functions.dart';
import 'package:smartwalletx/database/functions/profile_functions.dart';
import 'package:smartwalletx/screens/id_proofs_section/screen_idcard_details.dart';

class IDCardsSearchScreen extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(backgroundColor: background),
      scaffoldBackgroundColor: background,
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(
            Icons.clear,
            color: mytextcolor,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: mytextcolor,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    ProfileFunctions profileFunctions = ProfileFunctions();
    profileFunctions.getprofile();
    final mediaquery = MediaQuery.of(context);
    return ValueListenableBuilder(
      valueListenable: IdCardFunctions.idcardlist,
      builder: (context, value, child) {
        final list = [];
        for (int i = 0; i < value.length; i++) {
          if (value[i]
              .cardname
              .toLowerCase()
              .trim()
              .contains(query.toLowerCase().trim())) {
            list.add(value[i]);
          }
        }
        return list.isNotEmpty
            ? ListView.separated(
                padding: EdgeInsets.symmetric(
                    horizontal: mediaquery.size.width * 0.055,
                    vertical: mediaquery.size.width * 0.035),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: mediaquery.size.height * 0.11,
                    width: mediaquery.size.width,
                    child: NeumorphicButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return IDCardDetailsScreen(index: index);
                        }));
                      },
                      style: NeumorphicStyle(
                          shadowLightColor: shadowcolor,
                          color: background,
                          shape: NeumorphicShape.flat,
                          intensity: 1,
                          depth: 4,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(15))),
                      child: Row(
                        children: [
                          SizedBox(
                            width: mediaquery.size.width * 0.05,
                          ),
                          Container(
                            width: mediaquery.size.width * 0.2,
                            height: mediaquery.size.height * 0.072,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.5,
                                  color:
                                      const Color.fromARGB(255, 138, 138, 138)),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      'assets/id_card_designs/${list[index].backgrounddesign}.jpg')),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: mediaquery.size.height * 0.016,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: mediaquery.size.width * 0.02,
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable:
                                          profileFunctions.profilenotifier,
                                      builder: (context, value, child) {
                                        if (value.isNotEmpty) {
                                          return Container(
                                            height:
                                                mediaquery.size.height * 0.03,
                                            width: mediaquery.size.width * 0.06,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 0.5),
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: FileImage(File(
                                                        profileFunctions
                                                            .profilenotifier
                                                            .value[0]
                                                            .profilepic)))),
                                          );
                                        } else {
                                          return const Text(
                                            '',
                                            style: TextStyle(fontSize: 4),
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.01,
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            list[index].cardname,
                                            style: const TextStyle(
                                                fontSize: 8,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          Text(
                                            list[index].name,
                                            style: const TextStyle(
                                                fontSize: 8,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: mediaquery.size.height * 0.0035,
                                ),
                                Text(
                                  list[index].cardnumber,
                                  style: const TextStyle(
                                      fontSize: 9,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: mediaquery.size.width * 0.03,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  list[index].cardname,
                                  style: TextStyle(
                                      color: mytextcolor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                SizedBox(
                                  height: mediaquery.size.height * 0.002,
                                ),
                                Text(
                                  list[index].cardnumber,
                                  style: TextStyle(
                                      color: subtitlecolor, fontSize: 20),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: mediaquery.size.height * 0.03,
                  );
                },
                itemCount: list.length)
            : Center(
                child: Text(
                'No Items Found !',
                style: notfound,
              ));
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ProfileFunctions profileFunctions = ProfileFunctions();
    profileFunctions.getprofile();
    final mediaquery = MediaQuery.of(context);
    return ValueListenableBuilder(
      valueListenable: IdCardFunctions.idcardlist,
      builder: (context, value, child) {
        final list = [];
        for (int i = 0; i < value.length; i++) {
          if (value[i]
              .cardname
              .toLowerCase()
              .trim()
              .contains(query.toLowerCase().trim())) {
            list.add(value[i]);
          }
        }
        return list.isNotEmpty
            ? ListView.separated(
                padding: EdgeInsets.symmetric(
                    horizontal: mediaquery.size.width * 0.055,
                    vertical: mediaquery.size.width * 0.035),
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: mediaquery.size.height * 0.11,
                    width: mediaquery.size.width,
                    child: NeumorphicButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) {
                          return IDCardDetailsScreen(
                              index: IdCardFunctions.idcardlist.value
                                  .indexOf(list[index]));
                        }));
                      },
                      style: NeumorphicStyle(
                          shadowLightColor: shadowcolor,
                          color: background,
                          shape: NeumorphicShape.flat,
                          intensity: 1,
                          depth: 4,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(15))),
                      child: Row(
                        children: [
                          SizedBox(
                            width: mediaquery.size.width * 0.05,
                          ),
                          Container(
                            width: mediaquery.size.width * 0.2,
                            height: mediaquery.size.height * 0.072,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.5,
                                  color:
                                      const Color.fromARGB(255, 138, 138, 138)),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      'assets/id_card_designs/${list[index].backgrounddesign}.jpg')),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: mediaquery.size.height * 0.016,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: mediaquery.size.width * 0.02,
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable:
                                          profileFunctions.profilenotifier,
                                      builder: (context, value, child) {
                                        if (value.isNotEmpty) {
                                          return Container(
                                            height:
                                                mediaquery.size.height * 0.03,
                                            width: mediaquery.size.width * 0.06,
                                            decoration: BoxDecoration(
                                                border: Border.all(width: 0.5),
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: FileImage(File(
                                                        profileFunctions
                                                            .profilenotifier
                                                            .value[0]
                                                            .profilepic)))),
                                          );
                                        } else {
                                          return const Text(
                                            '',
                                            style: TextStyle(fontSize: 4),
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.01,
                                    ),
                                    SizedBox(
                                      width: mediaquery.size.width * 0.1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            list[index].cardname,
                                            style: const TextStyle(
                                                fontSize: 8,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          Text(
                                            list[index].name,
                                            style: const TextStyle(
                                                fontSize: 8,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: mediaquery.size.height * 0.0035,
                                ),
                                Text(
                                  list[index].cardnumber,
                                  style: const TextStyle(
                                      fontSize: 9,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: mediaquery.size.width * 0.03,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  list[index].cardname,
                                  style: TextStyle(
                                      color: mytextcolor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                      overflow: TextOverflow.ellipsis),
                                ),
                                SizedBox(
                                  height: mediaquery.size.height * 0.002,
                                ),
                                Text(
                                  list[index].cardnumber,
                                  style: TextStyle(
                                      color: subtitlecolor, fontSize: 20),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: mediaquery.size.height * 0.03,
                  );
                },
                itemCount: list.length)
            : Center(
                child: Text(
                'No Items Found !',
                style: notfound,
              ));
      },
    );
  }
}
