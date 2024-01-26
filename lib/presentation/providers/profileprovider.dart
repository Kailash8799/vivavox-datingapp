import 'dart:ffi';

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
  Basics? _basics = Basics.fromJson(null);
  Lifestyle? _lifeStyle = Lifestyle.fromJson(null);
  About? _askMeAbout = About.fromJson(null);
  String? _sexualOrientation;
  bool _profileUpdating = false;
  Map<String, dynamic> _basicsMap = {};
  Map<String, dynamic> _lifestyleMap = {};
  Map<String, dynamic> _aboutMap = {};

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
  bool get profileupdating => _profileUpdating;
  Map<String, dynamic> get basicsMap => _basicsMap;
  Map<String, dynamic> get lifestyleMap => _lifestyleMap;
  Map<String, dynamic> get aboutMap => _aboutMap;

  Profileinfo? get profile => _profileinfo;

  void addProfile({required Profileinfo profileinfo}) {
    _profileinfo = profileinfo;
    _gender = profileinfo.gender;
    _location = profileinfo.location;
    _interest = profileinfo.interest;
    _askMeAbout = profileinfo.askMeAbout;
    _basicsMap = profileinfo.basics!.toJson();
    _aboutMap = profileinfo.askMeAbout!.toJson();
    _lifestyleMap = profileinfo.lifeStyle!.toJson();
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

  void addGender({required String? value, required bool isSelected}) {
    if (isSelected) {
      _gender = null;
    } else {
      _gender = value;
    }
    notifyListeners();
  }

  void setBasics(
      {required String? item, required bool isSelected, required String key}) {
    if (isSelected) {
      _basicsMap[key] = null;
    } else {
      _basicsMap[key] = item;
    }
    notifyListeners();
  }

  void setLifeStyle(
      {required String? item, required bool isSelected, required String key}) {
    if (isSelected) {
      _lifestyleMap[key] = null;
    } else {
      _lifestyleMap[key] = item;
    }
    notifyListeners();
  }

  void setAskMeAbout(
      {required String? item, required bool isSelected, required String key}) {
    if (isSelected) {
      _aboutMap[key] = null;
    } else {
      _aboutMap[key] = item;
    }
    notifyListeners();
  }

  void addInterest({required String? interest, required bool isSelected}) {
    if (isSelected) {
      _interest = null;
    } else {
      _interest = interest;
    }
    notifyListeners();
  }

  void addRelationshipGoal(
      {required String? relationshipGoal, required bool isSelected}) {
    if (isSelected) {
      _relationshipGoal = null;
    } else {
      _relationshipGoal = relationshipGoal;
    }
    notifyListeners();
  }

  void addHeight({required String? height, required bool isSelected}) {
    if (isSelected) {
      _height = null;
    } else {
      _height = height;
    }
    notifyListeners();
  }

  void addRelationshipType(
      {required String? relationshipType, required bool isSelected}) {
    if (isSelected) {
      _relationshipType = null;
    } else {
      _relationshipType = relationshipType;
    }
    notifyListeners();
  }

  void addLanguage({required String language, required bool isSelected}) {
    if (isSelected) {
      _language.remove(language);
    } else {
      _language.add(language);
    }
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

  void addSexualOrientation(
      {required String? sexualOrientation, required bool isSelected}) {
    if (isSelected) {
      _sexualOrientation = null;
    } else {
      _sexualOrientation = sexualOrientation;
    }
    notifyListeners();
  }

  void setUpdatingValue(bool val) {
    _profileUpdating = val;
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
      return {"success": false};
    }
    Profileinfo updateProfile = Profileinfo(
      id: _profileinfo!.id,
      userid: _profileinfo!.userid,
      username: _profileinfo!.username,
      email: _profileinfo!.email,
      aboutme: about,
      askMeAbout: About.fromJson(_aboutMap),
      basics: Basics.fromJson(_basicsMap),
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
      lifeStyle: Lifestyle.fromJson(_lifestyleMap),
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
