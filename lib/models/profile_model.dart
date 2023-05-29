class ProfileModel {
  String fullname;
  String username;
  String email;
  String? alternativeemail;
  String phonenumber;
  String? alternativephone;
  String profilepic;

  ProfileModel(
      {required this.fullname,
      required this.username,
      required this.email,
      required this.phonenumber,
      required this.profilepic,
      this.alternativeemail,
      this.alternativephone});
}
