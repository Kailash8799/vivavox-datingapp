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
  final Basics? basics;
  final Lifestyle? lifeStyle;
  final About? askMeAbout;
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
    this.askMeAbout,
    this.basics,
    this.lifeStyle,
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

  factory Profileinfo.fromJson(Map<String, dynamic> json) {
    return Profileinfo(
      id: json["_id"],
      userid: json['userid'],
      username: json['username'],
      email: json['email'],
      gender: json["gender"] == null ? null : json["gender"] as String,
      location: json["location"] == null ? null : json["location"] as String,
      birthdate:
          json["birthdate"] == null ? null : json["birthdate"] as DateTime,
      language: List<String>.from(json['language'].map((x) => x)),
      aboutme: json["aboutme"] == null ? null : json["aboutme"] as String,
      collageName:
          json["collageName"] == null ? null : json["collageName"] as String,
      companyName:
          json["companyName"] == null ? null : json["companyName"] as String,
      instagranId:
          json["instagranId"] == null ? null : json["instagranId"] as String,
      height: json["height"] == null ? null : json["height"] as String,
      interest: json["interest"] == null ? null : json["interest"] as String,
      jobTitle: json["jobTitle"] == null ? null : json["jobTitle"] as String,
      liviningIn:
          json["liviningIn"] == null ? null : json["liviningIn"] as String,
      mobileno: json["mobileno"] == null ? null : json["mobileno"] as String,
      relationshipGoal: json["relationshipGoal"] == null
          ? null
          : json["relationshipGoal"] as String,
      relationshipType: json["relationshipType"] == null
          ? null
          : json["relationshipType"] as String,
      sexualOrientation: json["sexualOrientation"] == null
          ? null
          : json["sexualOrientation"] as String,
      askMeAbout: About.fromJson(json["askMeAbout"]),
      basics: Basics.fromJson(json["basics"]),
      lifeStyle: Lifestyle.fromJson(json['lifeStyle']),
      premiumuser: json["premiumuser"] as bool,
      premiumtype: json["premiumtype"] as String,
      premiumenddate: json["premiumenddate"] == null
          ? null
          : json["premiumenddate"] as DateTime,
      premiumstartdate: json["premiumstartdate"] == null
          ? null
          : json["premiumstartdate"] as DateTime,
      images: List<String>.from(json['images'].map((x) => x)),
      profileimage:
          json["profileimage"] == null ? null : json["profileimage"] as String,
    );
  }
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
        "askMeAbout": askMeAbout == null ? {} : askMeAbout!.toJson(),
        "basics": basics == null ? {} : basics!.toJson(),
        "lifeStyle": lifeStyle == null ? {} : lifeStyle!.toJson(),
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

  factory Basics.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Basics(
        zodiac: null,
        eduction: null,
        familyPlan: null,
        communication: null,
        covidVaccine: null,
        personalityType: null,
        loveStyle: null,
      );
    }
    return Basics(
      zodiac: json["zodiac"] == null ? null : json["zodiac"] as String,
      eduction: json["eduction"] == null ? null : json["eduction"] as String,
      familyPlan:
          json["familyPlan"] == null ? null : json["familyPlan"] as String,
      communication: json["communication"] == null
          ? null
          : json["communication"] as String,
      covidVaccine:
          json["covidVaccine"] == null ? null : json["covidVaccine"] as String,
      personalityType: json["personalityType"] == null
          ? null
          : json["personalityType"] as String,
      loveStyle: json["loveStyle"] == null ? null : json["loveStyle"] as String,
    );
  }
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

  factory Lifestyle.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Lifestyle(
        pets: null,
        dietaryPreference: null,
        drinking: null,
        sleepingHabits: null,
        smoking: null,
        socialMedia: null,
        workout: null,
      );
    }
    return Lifestyle(
      pets: json["pets"] == null ? null : json["pets"] as String,
      dietaryPreference: json["dietaryPreference"] == null
          ? null
          : json["dietaryPreference"] as String,
      drinking: json["drinking"] == null ? null : json["drinking"] as String,
      sleepingHabits: json["sleepingHabits"] == null
          ? null
          : json["sleepingHabits"] as String,
      smoking: json["smoking"] == null ? null : json["smoking"] as String,
      socialMedia:
          json["socialMedia"] == null ? null : json["socialMedia"] as String,
      workout: json["workout"] == null ? null : json["workout"] as String,
    );
  }

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

  factory About.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return About(
        goingOut: null,
        myWeekends: null,
        meandmyphone: null,
      );
    }
    return About(
      goingOut: json["goingOut"] == null ? null : json["goingOut"] as String,
      myWeekends:
          json["myWeekends"] == null ? null : json["myWeekends"] as String,
      meandmyphone:
          json["meandmyphone"] == null ? null : json["meandmyphone"] as String,
    );
  }
  Map<String, dynamic> toJson() => {
        "goingOut": goingOut,
        "myWeekends": myWeekends,
        "meandmyphone": meandmyphone,
      };
}
