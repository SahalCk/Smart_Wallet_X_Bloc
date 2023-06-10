import 'dart:io';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartwalletx/database/data_encrption.dart';
import 'package:smartwalletx/models/profile_model.dart';
import 'package:sqflite/sqflite.dart' as sql;

class ProfileFunctions {
  ValueNotifier<List<ProfileModel>> profilenotifier = ValueNotifier([]);
  XEncryption xEncryptionx = XEncryption();
  String username = '';

  Future<void> createProfileTable(sql.Database db) async {
    await db.execute(
        """CREATE TABLE profile_table (id INTEGER PRIMARY KEY,fullname TEXT,username TEXT,email TEXT,alternativemail TEXT,phonenumer TEXT,alternativephone TEXT,profilepic TEXT)""");
  }

  Future<sql.Database> openProfileDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return sql.openDatabase(
      '${directory.path}/profileDB',
      version: 1,
      onCreate: (db, version) async {
        await createProfileTable(db);
      },
    );
  }

  Future<void> createProfile(ProfileModel profileModel) async {
    final db = await openProfileDB();
    final data = {
      'fullname': xEncryptionx.encryptAES(profileModel.fullname),
      'username': xEncryptionx.encryptAES(profileModel.username),
      'email': xEncryptionx.encryptAES(profileModel.email),
      'alternativemail': xEncryptionx.encryptAES(profileModel.alternativeemail),
      'phonenumer': xEncryptionx.encryptAES(profileModel.phonenumber),
      'alternativephone':
          xEncryptionx.encryptAES(profileModel.alternativephone),
      'profilepic': xEncryptionx.encryptAES(profileModel.profilepic)
    };
    await db.insert('profile_table', data);
    profilenotifier.value.add(profileModel);
  }

  Future<void> deleteDatabase() async {
    final database = await openProfileDB();
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/profileDB';
    await database.close();
    await sql.deleteDatabase(path);
  }

  Future<void> getprofile() async {
    final db = await openProfileDB();
    final values = await db.query('profile_table');
    final profile = ProfileModel(
        fullname: xEncryptionx.decryptAES(values[0]['fullname']),
        username: xEncryptionx.decryptAES(values[0]['username']),
        email: xEncryptionx.decryptAES(values[0]['email']),
        alternativeemail: xEncryptionx.decryptAES(values[0]['alternativemail']),
        phonenumber: xEncryptionx.decryptAES(values[0]['phonenumer']),
        alternativephone:
            xEncryptionx.decryptAES(values[0]['alternativephone']),
        profilepic: xEncryptionx.decryptAES(values[0]['profilepic']));
    profilenotifier.value.clear();
    profilenotifier.value.add(profile);
    username = xEncryptionx.decryptAES(values[0]['username']);
    profilenotifier.notifyListeners();
  }

  Future<void> updateprofile(ProfileModel profileModel) async {
    final db = await openProfileDB();
    db.rawUpdate(
        'UPDATE profile_table SET '
        'fullname = ?, '
        'username = ?, '
        'email = ?, '
        'alternativemail = ?, '
        'phonenumer = ?, '
        'alternativephone = ? ,'
        'profilepic = ? '
        'WHERE id = ? ',
        [
          xEncryptionx.encryptAES(profileModel.fullname),
          xEncryptionx.encryptAES(profileModel.username),
          xEncryptionx.encryptAES(profileModel.email),
          xEncryptionx.encryptAES(profileModel.alternativeemail),
          xEncryptionx.encryptAES(profileModel.phonenumber),
          xEncryptionx.encryptAES(profileModel.alternativephone),
          xEncryptionx.encryptAES(profileModel.profilepic),
          1
        ]);
    profilenotifier.value.clear();
    profilenotifier.value.add(profileModel);
    profilenotifier.notifyListeners();
    await getprofile();
  }
}
