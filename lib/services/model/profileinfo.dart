import 'dart:ffi';

class Profileinfo {
  final String id;
  final String userid;
  final String username;
  final String email;
  final String? gender;
  final String? profileimage;
  final String? location;
  final String? mobileno;
  final String? aboutme;
  final String? interest;
  final String? relationshipGoal;
  final String? height;
  final String? relationshipType;
  final List<String>? language;
  final List<String>? images;
  // final Basics? basics;
  // final Lifestyle? lifeStyle;
  // final About? askMeAbout;
  final String? jobTitle;
  final String? companyName;
  final String? collageName;
  final String? liviningIn;
  final String? instagranId;
  final String? sexualOrientation;
  final DateTime? birthdate;
  final bool? premiumuser;
  final String? premiumtype;
  final DateTime? premiumstartdate;
  final DateTime? premiumenddate;

  Profileinfo({
    required this.id,
    required this.userid,
    required this.username,
    required this.email,
    this.gender,
    this.language,
    this.location,
    this.aboutme,
    // this.askMeAbout,
    // this.basics,
    // this.lifeStyle,
    this.collageName,
    this.companyName,
    this.height,
    this.instagranId,
    this.interest,
    this.jobTitle,
    this.liviningIn,
    this.mobileno,
    this.relationshipGoal,
    this.relationshipType,
    this.sexualOrientation,
    this.birthdate,
    this.premiumenddate,
    this.premiumstartdate,
    this.premiumtype = "NONE",
    this.premiumuser = false,
    this.images,
    this.profileimage,
  });

  factory Profileinfo.fromJson(Map<String, dynamic> json) => Profileinfo(
        id: json["_id"] as String,
        userid: json['userId'] as String,
        username: json['username'],
        email: json['email'],
        // gender: json["gender"] == null ? null : json["gender"] as String,
        // location: json["location"] == null ? null : json["location"] as String,
        // birthdate:
        //     json["birthdate"] == null ? null : json["birthdate"] as DateTime,
        // language: List<String>.from(json['language'].map((x) => x)),
        // aboutme: json["aboutme"] == null ? null : json["aboutme"] as String,
        // collageName:
        //     json["collageName"] == null ? null : json["collageName"] as String,
        // companyName:
        //     json["companyName"] == null ? null : json["companyName"] as String,
        // instagranId:
        //     json["instagranId"] == null ? null : json["instagranId"] as String,
        // height: json["height"] == null ? null : json["height"] as String,
        // interest: json["interest"] == null ? null : json["interest"] as String,
        // jobTitle: json["jobTitle"] == null ? null : json["jobTitle"] as String,
        // liviningIn:
        //     json["liviningIn"] == null ? null : json["liviningIn"] as String,
        // mobileno: json["mobileno"] == null ? null : json["mobileno"] as String,
        // relationshipGoal: json["relationshipGoal"] == null
        //     ? null
        //     : json["relationshipGoal"] as String,
        // relationshipType: json["relationshipType"] == null
        //     ? null
        //     : json["relationshipType"] as String,
        // sexualOrientation: json["sexualOrientation"] == null
        //     ? null
        //     : json["sexualOrientation"] as String,
        // askMeAbout: About.fromJson(json["location"]),
        // basics: Basics.fromJson(json["basics"]),
        // lifeStyle: Lifestyle.fromJson(json['lifeStyle']),
        // premiumuser: json["premiumuser"] as bool,
        // premiumtype: json["premiumtype"] as String,
        // premiumenddate: json["premiumenddate"] == null
        //     ? null
        //     : json["premiumenddate"] as DateTime,
        // premiumstartdate: json["premiumstartdate"] == null
        //     ? null
        //     : json["premiumstartdate"] as DateTime,
        // images: List<String>.from(json['images'].map((x) => x)),
        // profileimage: json["profileimage"] == null
        //     ? null
        //     : json["profileimage"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "username": username,
        "email": email,
        "gender": gender,
        "location": location,
        "language": List<dynamic>.from(language!.map((x) => x)),
        "aboutme": aboutme,
        "collageName": collageName,
        "companyName": companyName,
        "instagranId": instagranId,
        "height": height,
        "interest": interest,
        "jobTitle": jobTitle,
        "liviningIn": liviningIn,
        "mobileno": mobileno,
        "relationshipGoal": relationshipGoal,
        "relationshipType": relationshipType,
        "sexualOrientation": sexualOrientation,
        // "askMeAbout": askMeAbout,
        // "basics": basics,
        // "lifeStyle": lifeStyle,
        "birthdate": birthdate,
        "premiumuser": premiumuser,
        "premiumtype": premiumtype,
        "premiumenddate": premiumenddate,
        "premiumstartdate": premiumstartdate,
        "images": List<dynamic>.from(images!.map((x) => x)),
        "profileimage": profileimage,
      };
}

class Basics {
  final String? zodiac;
  final String? eduction;
  final String? familyPlan;
  final String? covidVaccine;
  final String? personalityType;
  final String? communication;
  final String? loveStyle;

  Basics({
    this.zodiac,
    this.eduction,
    this.familyPlan,
    this.covidVaccine,
    this.personalityType,
    this.communication,
    this.loveStyle,
  });

  factory Basics.fromJson(Map<String, dynamic> json) => Basics(
        zodiac: json['zodiac'],
        eduction: json["eduction"],
        familyPlan: json["familyPlan"],
        communication: json["communication"],
        covidVaccine: json["covidVaccine"],
        personalityType: json["personalityType"],
        loveStyle: json["loveStyle"],
      );

  Map<String, dynamic> toJson() => {
        "zodiac": zodiac,
        "eduction": eduction,
        "familyPlan": familyPlan,
        "communication": communication,
        "covidVaccine": covidVaccine,
        "personalityType": personalityType,
        "loveStyle": loveStyle,
      };
}

class Lifestyle {
  final String? pets;
  final String? drinking;
  final String? smoking;
  final String? workout;
  final String? dietaryPreference;
  final String? socialMedia;
  final String? sleepingHabits;

  Lifestyle({
    this.pets,
    this.drinking,
    this.smoking,
    this.workout,
    this.dietaryPreference,
    this.socialMedia,
    this.sleepingHabits,
  });

  factory Lifestyle.fromJson(Map<String, dynamic> json) => Lifestyle(
        pets: json['pets'],
        dietaryPreference: json["dietaryPreference"],
        drinking: json["drinking"],
        sleepingHabits: json["sleepingHabits"],
        smoking: json["smoking"],
        socialMedia: json["socialMedia"],
        workout: json["workout"],
      );

  Map<String, dynamic> toJson() => {
        "pets": pets,
        "dietaryPreference": dietaryPreference,
        "drinking": drinking,
        "sleepingHabits": sleepingHabits,
        "smoking": smoking,
        "socialMedia": socialMedia,
        "workout": workout,
      };
}

class About {
  final String? goingOut;
  final String? myWeekends;
  final String? meandmyphone;

  About({
    this.goingOut,
    this.meandmyphone,
    this.myWeekends,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
        goingOut: json['goingOut'],
        myWeekends: json['myWeekends'],
        meandmyphone: json['meandmyphone'],
      );

  Map<String, dynamic> toJson() => {
        "goingOut": goingOut,
        "myWeekends": myWeekends,
        "meandmyphone": meandmyphone,
      };
}
