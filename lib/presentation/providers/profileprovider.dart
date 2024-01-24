import 'package:flutter/material.dart';
import 'package:vivavox/services/model/profileinfo.dart';

class ProfileProvider extends ChangeNotifier {
  Profileinfo? _profileinfo;
  String? _gender;
  String? _location;
  String? _interest;
  String? _relationshipGoal;
  String? _height;
  String? _relationshipType;
  List<String> _language = [];
  List<String> _images = [];
  Basics? _basics;
  Lifestyle? _lifeStyle;
  About? _askMeAbout;
  String? _sexualOrientation;

  String? get gender => _gender;
  String? get location => _location;
  String? get interest => _interest;
  String? get relationshipGoal => _relationshipGoal;
  String? get height => _height;
  String? get relationshipType => _relationshipType;
  List<String>? get language => _language;
  List<String>? get images => _images;
  Basics? get basics => _basics;
  Lifestyle? get lifeStyle => _lifeStyle;
  About? get askMeAbout => _askMeAbout;
  String? get sexualOrientation => _sexualOrientation;

  Profileinfo? get profile => _profileinfo;

  void addGender({required Profileinfo profileinfo}) {
    _profileinfo = profileinfo;
    // _profileinfo?.aboutme = profileinfo.aboutme;
    _gender = profileinfo.gender;
    _location = profileinfo.location;
    _interest = profileinfo.interest;
    _askMeAbout = profileinfo.askMeAbout;
    _basics = profileinfo.basics;
    _relationshipGoal = profileinfo.relationshipGoal;
    _relationshipType = profileinfo.relationshipType;
    _height = profileinfo.height;
    _language = profileinfo.language ?? [];
    _images = profileinfo.images ?? [];
    _sexualOrientation = profileinfo.sexualOrientation;
    _lifeStyle = profileinfo.lifeStyle;
    notifyListeners();
  }

  void addProfile({required Profileinfo profileinfo}) {
    _profileinfo = profileinfo;
    notifyListeners();
  }

  void addInterest({required String? interest}) {
    _interest = interest;
    notifyListeners();
  }

  void addRelationshipGoal({required String? relationshipGoal}) {
    _relationshipGoal = relationshipGoal;
    notifyListeners();
  }

  void addHeight({required String? height}) {
    _height = height;
    notifyListeners();
  }

  void addRelationshipType({required String? relationshipType}) {
    _relationshipType = relationshipType;
    notifyListeners();
  }

  void addLanguage({required List<String>? language}) {
    _language = language ?? [];
    notifyListeners();
  }

  void addImages({required List<String>? images}) {
    _images = images ?? [];
    notifyListeners();
  }

  void addBasics({required Basics? basics}) {
    _basics = basics;
    notifyListeners();
  }

  void addLifeStyle({required Lifestyle? lifeStyle}) {
    _lifeStyle = lifeStyle;
    notifyListeners();
  }

  void addAskMeAbout({required About? askMeAbout}) {
    _askMeAbout = askMeAbout;
    notifyListeners();
  }

  void addSexualOrientation({required String? sexualOrientation}) {
    _sexualOrientation = sexualOrientation;
    notifyListeners();
  }

  Map<String, dynamic> getUpdatedProfile({
    String? about,
    String? jobTitle,
    String? companyName,
    String? collegeName,
    String? livingIn,
    String? instagramId,
  }) {
    if (_profileinfo == null) {
      // print(_profileinfo);
      return {"success": false};
    }
    Profileinfo updateProfile = Profileinfo(
      id: _profileinfo!.id,
      userid: _profileinfo!.userid,
      username: _profileinfo!.username,
      email: _profileinfo!.email,
      aboutme: about,
      askMeAbout: _askMeAbout,
      basics: _basics,
      birthdate: _profileinfo!.birthdate,
      collageName: collegeName,
      companyName: companyName,
      gender: gender,
      height: _height,
      images: _images,
      instagranId: instagramId,
      interest: _interest,
      jobTitle: jobTitle,
      language: _language,
      lifeStyle: _lifeStyle,
      liviningIn: livingIn,
      location: _profileinfo!.location,
      mobileno: _profileinfo!.mobileno,
      premiumenddate: _profileinfo!.premiumenddate,
      premiumstartdate: _profileinfo!.premiumstartdate,
      premiumtype: _profileinfo!.premiumtype,
      premiumuser: _profileinfo!.premiumuser,
      profileimage: _profileinfo!.profileimage,
      relationshipGoal: _relationshipGoal,
      relationshipType: _relationshipType,
      sexualOrientation: _sexualOrientation,
    );
    Map<String, dynamic> res = updateProfile.toJson();
    return {"success": true, "profiledata": res};
  }
}
