import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivavox/presentation/providers/cardprovider.dart';
import 'package:vivavox/presentation/providers/profileprovider.dart';
import 'package:vivavox/services/auth/auth.dart';
import 'package:vivavox/services/model/profileinfo.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _aboutController;
  late TextEditingController _jobTitleController;
  late TextEditingController _companyController;
  late TextEditingController _collegeController;
  late TextEditingController _livinginController;
  late TextEditingController _instagramController;
  late TextEditingController _heightController;

  @override
  void initState() {
    super.initState();
    _aboutController = TextEditingController(text: "");
    _jobTitleController = TextEditingController(text: "");
    _companyController = TextEditingController(text: "");
    _collegeController = TextEditingController(text: "");
    _livinginController = TextEditingController(text: "");
    _instagramController = TextEditingController(text: "");
    _heightController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
    _aboutController.dispose();
    _jobTitleController.dispose();
    _companyController.dispose();
    _collegeController.dispose();
    _livinginController.dispose();
    _instagramController.dispose();
    _heightController.dispose();
  }

  void updateProfile() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<ProfileProvider>(context, listen: false);
      final provider2 = Provider.of<CardProvider>(context, listen: false);
      if (provider.profileupdating) return;
      provider.setUpdatingValue(true);
      try {
        if (provider.profile != null) {
          String? about = _aboutController.text.isNotEmpty
              ? _aboutController.text.trim()
              : null;
          String? jobTitle = _jobTitleController.text.isNotEmpty
              ? _jobTitleController.text.trim()
              : null;
          String? company = _companyController.text.isNotEmpty
              ? _companyController.text.trim()
              : null;
          String? college = _collegeController.text.isNotEmpty
              ? _collegeController.text.trim()
              : null;
          String? livingin = _livinginController.text.isNotEmpty
              ? _livinginController.text.trim()
              : null;
          String? instagram = _instagramController.text.isNotEmpty
              ? _instagramController.text.trim()
              : null;
          Map<String, dynamic> profile = provider.getUpdatedProfile(
            about: about,
            collegeName: college,
            companyName: company,
            instagramId: instagram,
            jobTitle: jobTitle,
            livingIn: livingin,
          );
          if (profile["success"]) {
            Map<String, dynamic> data = profile["profiledata"];
            Map<String, dynamic> res = await AuthUser()
                .updateProfile(email: provider2.email, profiledata: data);
            if (res["success"]) {
              provider.addProfile(
                  profileinfo: Profileinfo.fromJson(res["profile"]));
            } else {
              debugPrint('$res');
            }
          } else {}
        }
      } catch (e) {
        debugPrint(e.toString());
      }
      provider.setUpdatingValue(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProfileProvider>(context);
    if (provider.profile == null) {
      Navigator.of(context).pop();
      return const SizedBox();
    }
    return PopScope(
      onPopInvoked: (didPop) {
        provider.resetProfile();
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: RichText(
              text: const TextSpan(children: [
            TextSpan(
              text: "Edit Profile",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ])),
          titleSpacing: 10,
          leading: const SizedBox(),
          leadingWidth: 0,
          actions: [
            provider.profileupdating
                ? Container(
                    height: 35,
                    width: 35,
                    margin: const EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                          colors: [Colors.orange, Colors.pink, Colors.red],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0, 0.5, 0.7]),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                  )
                : IconButton(
                    onPressed: updateProfile,
                    icon: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                            colors: [Colors.orange, Colors.pink, Colors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0, 0.5, 0.7]),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: const Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                    ),
                  ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.pink, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0, 0.5, 0.7]),
                ),
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  CupertinoIcons.down_arrow,
                  color: Colors.white,
                ),
              ),
            ),
          ],
          // backgroundColor: const Color.fromARGB(113, 107, 102, 107),

          // backgroundColor: Color(0xFF23272A),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 7, right: 7, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  "Media",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (context, index) {
                  return provider.images!.isEmpty
                      ? buildWithOutImage()
                      : buildWithImage(image: provider.images![0]);
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, top: 10, bottom: 5),
                child: Text(
                  "About me",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextFormField(
                  controller: _aboutController
                    ..text = _aboutController.text.isEmpty
                        ? provider.profile!.aboutme ?? ""
                        : _aboutController.text,
                  maxLines: 4,
                  maxLength: 300,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: const Color(0xFFFE3C72),
                  decoration: const InputDecoration(
                    fillColor: Color.fromARGB(255, 19, 21, 23),
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    hintText: "About you?",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                  ),
                ),
              ),
              buildMainCategory(
                icon: CupertinoIcons.add,
                height: 610,
                subcategoryname: provider.interest ?? "Select interest",
                title: "Interests",
                modalContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15),
                        child: Consumer<ProfileProvider>(
                          builder: (context, value, child) {
                            return Text(
                              "I have interest in  ${value.interest ?? "..."}",
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            );
                          },
                        )),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 30, 32, 34),
                      ),
                      child: Consumer<ProfileProvider>(
                        builder: (context, value, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildInterestSelect(interest: "Movie"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildInterestSelect(interest: "Shopping"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildInterestSelect(interest: "Cricket"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildInterestSelect(interest: "Gym"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildInterestSelect(interest: "Dancing"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildInterestSelect(interest: "Vlogging"),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              buildMainCategory(
                icon: CupertinoIcons.eye,
                height: 400,
                subcategoryname: provider.relationshipGoal ?? "Looking for...",
                title: "Relationship Goals",
                modalContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Right now I'm looking for...",
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        "Increase compatibility by sharing yours!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      child: Consumer<ProfileProvider>(
                        builder: (context, value, child) {
                          return Wrap(
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.start,
                            verticalDirection: VerticalDirection.down,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            direction: Axis.horizontal,
                            runSpacing: 7,
                            spacing: 7,
                            children: [
                              buildRelationShipGoalSelect(
                                  icon: "💘",
                                  type: "💘 Long-term parter",
                                  text: "Long-term parter"),
                              buildRelationShipGoalSelect(
                                  icon: "😍",
                                  type: "😍 Long-term, open to short",
                                  text: "Long-term, open to short"),
                              buildRelationShipGoalSelect(
                                  icon: "🍷",
                                  type: "🍷 Short-term open to long",
                                  text: "Short-term open to long"),
                              buildRelationShipGoalSelect(
                                  icon: "🎉",
                                  type: "🎉 Short-term fun",
                                  text: "Short-term fun"),
                              buildRelationShipGoalSelect(
                                  icon: "👋",
                                  type: "👋 New friends",
                                  text: "New friends"),
                              buildRelationShipGoalSelect(
                                icon: "🤔",
                                type: "🤔 Still figuring it out",
                                text: "Still figuring it out",
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              buildMainCategory(
                icon: CupertinoIcons.tag,
                height: 420,
                subcategoryname: provider.height == null
                    ? "Add height"
                    : "${provider.height} cm",
                title: "Height",
                modalContent: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 2),
                        child: Text(
                          "Height",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10, top: 2),
                        child: Text(
                          "Here's a chance to add height to your profile",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            wordSpacing: 0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Consumer<ProfileProvider>(
                        builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, top: 10),
                            child: TextFormField(
                              initialValue: value.height ?? "",
                              maxLines: 1,
                              onChanged: (res) {
                                value.addHeight(
                                    height: res, isSelected: res.isEmpty);
                              },
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.white),
                              cursorColor: const Color(0xFFFE3C72),
                              decoration: const InputDecoration(
                                fillColor: Color.fromARGB(255, 30, 32, 34),
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                hintText: "Add height in cm",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(7),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              provider.addHeight(height: "", isSelected: true);
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              "Reset Height",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              buildMainCategory(
                icon: CupertinoIcons.eye,
                height: 340,
                subcategoryname: provider.relationshipType ?? "Open to...",
                title: "Relationship Type",
                modalContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15),
                        child: Consumer<ProfileProvider>(
                          builder: (context, value, child) {
                            return Text(
                              "I Am ${value.relationshipType ?? "..."}",
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            );
                          },
                        )),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 30, 32, 34),
                      ),
                      child: Consumer<ProfileProvider>(
                        builder: (context, value, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildRelationShipTypeSelect(type: "Monogamy"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildRelationShipTypeSelect(
                                  type: "Ethical non-monogamy"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildRelationShipTypeSelect(type: "Polyagamy"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildRelationShipTypeSelect(
                                  type: "Open to exploring"),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              buildMainCategory(
                icon: Icons.language,
                height: 300,
                subcategoryname: provider.language!.isNotEmpty
                    ? "${provider.language!.map((e) => e)}"
                    : "Add languages",
                title: "Languages I Know",
                modalContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15),
                        child: Consumer<ProfileProvider>(
                          builder: (context, value, child) {
                            return Text(
                              "Languages I Know ${value.language!.isNotEmpty ? value.language!.map((e) => e) : "..."}",
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            );
                          },
                        )),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 30, 32, 34),
                      ),
                      child: Consumer<ProfileProvider>(
                        builder: (context, value, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildLanguageSelect(language: "English"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildLanguageSelect(language: "Hindi"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildLanguageSelect(language: "Gujrati"),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              buildMainCategory(
                icon: Icons.boy,
                height: 230,
                subcategoryname: "I Am ${provider.gender ?? "..."}",
                title: "Gender",
                modalContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15),
                        child: Consumer<ProfileProvider>(
                          builder: (context, value, child) {
                            return Text(
                              "I Am ${value.gender ?? "..."}",
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            );
                          },
                        )),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 30, 32, 34),
                      ),
                      child: Consumer<ProfileProvider>(
                        builder: (context, value, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildGenderSelect(gender: "Men"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildGenderSelect(gender: "Women"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildGenderSelect(gender: "Other"),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              buildMainCategory(
                icon: Icons.language,
                height: 500,
                subcategoryname: provider.sexualOrientation == null
                    ? "Add sexual Orintation"
                    : "I am ${provider.sexualOrientation}",
                title: "Sexual Orientation",
                modalContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15),
                        child: Consumer<ProfileProvider>(
                          builder: (context, value, child) {
                            return Text(
                              "I Am ${value.sexualOrientation ?? "..."}",
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                              ),
                            );
                          },
                        )),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 30, 32, 34),
                      ),
                      child: Consumer<ProfileProvider>(
                        builder: (context, value, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildSexualOrientationSelect(sex: "Straight"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildSexualOrientationSelect(sex: "Lesbian"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildSexualOrientationSelect(sex: "Gay"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildSexualOrientationSelect(sex: "Bisexual"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildSexualOrientationSelect(sex: "Asexual"),
                              const SizedBox(height: 5),
                              const Divider(
                                  color: Color.fromARGB(255, 66, 70, 75)),
                              const SizedBox(height: 5),
                              buildSexualOrientationSelect(sex: "Demisexual"),
                              //   const SizedBox(height: 5),
                              //   const Divider(
                              //       color: Color.fromARGB(255, 66, 70, 75)),
                              //   const SizedBox(height: 5),
                              //   buildGenderSelect(gender: "Pansexual"),
                              //   const SizedBox(height: 5),
                              //   const Divider(
                              //       color: Color.fromARGB(255, 66, 70, 75)),
                              //   const SizedBox(height: 5),
                              //   buildGenderSelect(gender: "Queer"),
                              //   const SizedBox(height: 5),
                              //   const Divider(
                              //       color: Color.fromARGB(255, 66, 70, 75)),
                              //   const SizedBox(height: 5),
                              //   buildGenderSelect(gender: "Bicurios"),
                              //   const SizedBox(height: 5),
                              //   const Divider(
                              //       color: Color.fromARGB(255, 66, 70, 75)),
                              //   const SizedBox(height: 5),
                              //   buildGenderSelect(gender: "Aromantic"),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, top: 20, bottom: 5),
                child: Text(
                  "Basics",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Color.fromARGB(255, 19, 21, 23),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: Column(
                      children: [
                        buildInsideSubCategory(
                          icon: CupertinoIcons.moon_stars,
                          subcategoryname: "Zodiac",
                          subcategory: provider.basicsMap["zodiac"],
                        ),
                        const SizedBox(height: 25),
                        buildInsideSubCategory(
                          icon: Icons.menu_book_sharp,
                          subcategoryname: "Education",
                          subcategory: provider.basicsMap["eduction"],
                        ),
                        const SizedBox(height: 25),
                        buildInsideSubCategory(
                          icon: Icons.family_restroom,
                          subcategoryname: "Family Plans",
                          subcategory: provider.basicsMap["familyPlan"],
                        ),
                        const SizedBox(height: 25),
                        buildInsideSubCategory(
                          icon: Icons.medical_information,
                          subcategoryname: "Covid Vaccine",
                          subcategory: provider.basicsMap["covidVaccine"],
                        ),
                        const SizedBox(height: 25),
                        buildInsideSubCategory(
                          icon: Icons.tips_and_updates_rounded,
                          subcategoryname: "Personality Type",
                          subcategory: provider.basicsMap["personalityType"],
                        ),
                        const SizedBox(height: 25),
                        buildInsideSubCategory(
                          icon: Icons.add_call,
                          subcategoryname: "Communication style",
                          subcategory: provider.basicsMap["communication"],
                        ),
                        const SizedBox(height: 25),
                        buildInsideSubCategory(
                          icon: CupertinoIcons.heart,
                          subcategoryname: "Love style",
                          subcategory: provider.basicsMap["loveStyle"],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, top: 20, bottom: 5),
                child: Text(
                  "Lifestyle",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Color.fromARGB(255, 19, 21, 23),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: Column(
                      children: [
                        buildLifeStyleCategory(
                          icon: Icons.pets_outlined,
                          subcategoryname: "Pets",
                          subcategory: provider.lifestyleMap["pets"],
                        ),
                        const SizedBox(height: 25),
                        buildLifeStyleCategory(
                            icon: Icons.blender_outlined,
                            subcategoryname: "Drinking",
                            subcategory: provider.lifestyleMap["drinking"]),
                        const SizedBox(height: 25),
                        buildLifeStyleCategory(
                            icon: Icons.smoking_rooms,
                            subcategoryname: "Smoking",
                            subcategory: provider.lifestyleMap["smoking"]),
                        const SizedBox(height: 25),
                        buildLifeStyleCategory(
                            icon: Icons.sports_gymnastics,
                            subcategoryname: "Workout",
                            subcategory: provider.lifestyleMap["workout"]),
                        const SizedBox(height: 25),
                        buildLifeStyleCategory(
                            icon: Icons.local_pizza_outlined,
                            subcategoryname: "Dietary Preference",
                            subcategory:
                                provider.lifestyleMap["dietaryPreference"]),
                        const SizedBox(height: 25),
                        buildLifeStyleCategory(
                            icon: CupertinoIcons.at,
                            subcategoryname: "Social Media",
                            subcategory: provider.lifestyleMap["socialMedia"]),
                        const SizedBox(height: 25),
                        buildLifeStyleCategory(
                            icon: CupertinoIcons.bed_double,
                            subcategoryname: "Sleeping Habits",
                            subcategory:
                                provider.lifestyleMap["sleepingHabits"]),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, top: 20, bottom: 5),
                child: Text(
                  "Ask me about",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Color.fromARGB(255, 19, 21, 23),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: Column(
                      children: [
                        buildAskMeAboutCategory(
                            icon: Icons.travel_explore,
                            subcategoryname: "Going Out",
                            subcategory: provider.aboutMap["goingOut"]),
                        const SizedBox(height: 25),
                        buildAskMeAboutCategory(
                            icon: Icons.weekend_rounded,
                            subcategoryname: "My Weekends",
                            subcategory: provider.aboutMap["myWeekends"]),
                        const SizedBox(height: 25),
                        buildAskMeAboutCategory(
                            icon: Icons.contact_phone_rounded,
                            subcategoryname: "Me + My Phone",
                            subcategory: provider.aboutMap["meandmyphone"]),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              buildInfoInput(
                title: "Job Title",
                hintText: "Add job title",
                controller: _jobTitleController
                  ..text = _jobTitleController.text.isEmpty
                      ? provider.profile!.jobTitle ?? ""
                      : _jobTitleController.text,
              ),
              buildInfoInput(
                title: "Company",
                hintText: "Add company",
                controller: _companyController
                  ..text = _companyController.text.isEmpty
                      ? provider.profile!.companyName ?? ""
                      : _companyController.text,
              ),
              buildInfoInput(
                title: "College",
                hintText: "Add college",
                controller: _collegeController
                  ..text = _collegeController.text.isEmpty
                      ? provider.profile!.collageName ?? ""
                      : _collegeController.text,
              ),
              buildInfoInput(
                title: "Living in",
                hintText: "Add city",
                controller: _livinginController
                  ..text = _livinginController.text.isEmpty
                      ? provider.profile!.liviningIn ?? ""
                      : _livinginController.text,
              ),
              buildInfoInput(
                title: "Instagram",
                hintText: "Add instagram username",
                controller: _instagramController
                  ..text = _instagramController.text.isEmpty
                      ? provider.profile!.instagranId ?? ""
                      : _instagramController.text,
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget buildInfoInput(
      {required String title,
      required String hintText,
      required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, top: 0, bottom: 0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: TextFormField(
            controller: controller,
            maxLines: 1,
            maxLength: 50,
            style: const TextStyle(color: Colors.white),
            cursorColor: const Color(0xFFFE3C72),
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 19, 21, 23),
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(7),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildWithOutImage() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.all(6),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 119, 129, 139),
            borderRadius: BorderRadius.circular(7),
          ),
          child: const SizedBox(),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.pink, Colors.red, Color(0xFFFE3C72)]),
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                  child: Icon(
                Icons.add,
                color: Colors.white,
              )),
            ))
      ],
    );
  }

  Widget buildWithImage({required String image}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.all(6),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 119, 129, 139),
            borderRadius: BorderRadius.circular(7),
          ),
          child: SizedBox(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: CachedNetworkImage(imageUrl: image, fit: BoxFit.cover)),
          ),
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey, Colors.blueGrey]),
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                  child: Icon(
                CupertinoIcons.multiply,
                color: Colors.white,
              )),
            ))
      ],
    );
  }

  Widget buildInsideSubCategory({
    required IconData icon,
    required String subcategoryname,
    String? subcategory,
  }) {
    return InkWell(
      onTap: basicBottomSheetBasics,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Text(
                    subcategoryname,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    textAlign: TextAlign.end,
                    subcategory ?? "Empty",
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                const Icon(
                  CupertinoIcons.forward,
                  color: Colors.grey,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildAskMeAboutCategory({
    required IconData icon,
    required String subcategoryname,
    String? subcategory,
  }) {
    return InkWell(
      onTap: basicBottomSheetAskMeAbout,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Text(
                    subcategoryname,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    subcategory ?? "Empty",
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                const Icon(
                  CupertinoIcons.forward,
                  color: Colors.grey,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildLifeStyleCategory({
    required IconData icon,
    required String subcategoryname,
    String? subcategory,
  }) {
    return InkWell(
      onTap: basicBottomSheetLifeStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: Colors.grey,
                ),
                const SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: Text(
                    subcategoryname,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    subcategory ?? "Empty",
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                const Icon(
                  CupertinoIcons.forward,
                  color: Colors.grey,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildMainCategory({
    required IconData icon,
    required String subcategoryname,
    required String title,
    required Widget modalContent,
    required double height,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, top: 20, bottom: 5),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: InkWell(
            onTap: () {
              bottomSheet(content: modalContent, height: height);
            },
            child: Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10, right: 5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Color.fromARGB(255, 19, 21, 23),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          icon,
                          size: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Text(
                            subcategoryname,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 14,
                        ),
                        Icon(
                          CupertinoIcons.forward,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void basicBottomSheetBasics() {
    showModalBottomSheet(
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      elevation: 0,
      context: context,
      builder: (context) {
        return buildSheetBasics();
      },
    );
  }

  void basicBottomSheetAskMeAbout() {
    showModalBottomSheet(
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      elevation: 0,
      context: context,
      builder: (context) {
        return buildSheetAboutme();
      },
    );
  }

  void basicBottomSheetLifeStyle() {
    showModalBottomSheet(
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      elevation: 0,
      context: context,
      builder: (context) {
        return buildSheetLifeStyle();
      },
    );
  }

  void bottomSheet({required Widget content, required double height}) {
    showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: const Color.fromARGB(255, 30, 32, 34),
      elevation: 0,
      context: context,
      builder: (context) {
        return Container(
          color: const Color.fromARGB(255, 19, 21, 23),
          width: double.infinity,
          height: height,
          child: content,
        );
      },
    );
  }

  Widget makeDismissable({required Widget child}) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(onTap: () {}, child: child),
      );

  Widget buildSheetBasics() {
    return makeDismissable(
      child: DraggableScrollableSheet(
        minChildSize: 0.3,
        maxChildSize: 0.95,
        initialChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 19, 21, 23),
              border: const Border(
                  top: BorderSide(
                      color: Color.fromARGB(255, 30, 32, 34), width: 35)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              controller: scrollController,
              children: [
                const SizedBox(height: 10),
                const SizedBox(
                  child: Text(
                    "Basics",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  child: Text(
                    "Bring your best self forward by adding more about you",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(
                      CupertinoIcons.moon_stars,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        "What is your zodiac sign?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    buildChip(title: "Capricorn", type: "zodiac"),
                    buildChip(title: "Aquarius", type: "zodiac"),
                    buildChip(title: "Pisces", type: "zodiac"),
                    buildChip(title: "Aries", type: "zodiac"),
                    buildChip(title: "Taurus", type: "zodiac"),
                    buildChip(title: "Gemini", type: "zodiac"),
                    buildChip(title: "Cancer", type: "zodiac"),
                    buildChip(title: "Leo", type: "zodiac"),
                    buildChip(title: "Virgo", type: "zodiac"),
                    buildChip(title: "Libra", type: "zodiac"),
                    buildChip(title: "Scorpio", type: "zodiac"),
                    buildChip(title: "Sagittarius", type: "zodiac"),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(
                      Icons.menu_book_sharp,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        "What is your education level?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    buildChip(title: "Bachelors", type: "eduction"),
                    buildChip(title: "In college", type: "eduction"),
                    buildChip(title: "High School", type: "eduction"),
                    buildChip(title: "PhD", type: "eduction"),
                    buildChip(title: "In Grad School", type: "eduction"),
                    buildChip(title: "Masters", type: "eduction"),
                    buildChip(title: "Trade School", type: "eduction"),
                    buildChip(title: "12th pass", type: "eduction"),
                    buildChip(title: "Below 12th", type: "eduction"),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(
                      Icons.family_restroom,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        "Do you want children?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    buildChip(title: "I want children", type: "familyPlan"),
                    buildChip(
                        title: "I don't want children", type: "familyPlan"),
                    buildChip(
                        title: "I have chidren and want more",
                        type: "familyPlan"),
                    buildChip(
                        title: "I have chidren and don't want more",
                        type: "familyPlan"),
                    buildChip(title: "Not sure yet", type: "familyPlan"),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(
                      Icons.medical_information,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        "Are you vaccinated?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    buildChip(title: "Vaccinated", type: "covidVaccine"),
                    buildChip(title: "Unvaccinated", type: "covidVaccine"),
                    buildChip(title: "Prefer not to say", type: "covidVaccine"),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(
                      Icons.tips_and_updates_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        "What's your Personality Type?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    buildChip(title: "INTJ", type: "personalityType"),
                    buildChip(title: "INTP", type: "personalityType"),
                    buildChip(title: "ENTJ", type: "personalityType"),
                    buildChip(title: "ENTP", type: "personalityType"),
                    buildChip(title: "INFJ", type: "personalityType"),
                    buildChip(title: "INFP", type: "personalityType"),
                    buildChip(title: "ENFJ", type: "personalityType"),
                    buildChip(title: "ENFP", type: "personalityType"),
                    buildChip(title: "ISTJ", type: "personalityType"),
                    buildChip(title: "ISFJ", type: "personalityType"),
                    buildChip(title: "ESTJ", type: "personalityType"),
                    buildChip(title: "ESFJ", type: "personalityType"),
                    buildChip(title: "ISTP", type: "personalityType"),
                    buildChip(title: "ISFP", type: "personalityType"),
                    buildChip(title: "ESTP", type: "personalityType"),
                    buildChip(title: "ESFP", type: "personalityType"),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(
                      Icons.add_call,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        "What is your communication style?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    buildChip(
                        title: "I stay on WhatsApp all day",
                        type: "communication"),
                    buildChip(title: "Big time texter", type: "communication"),
                    buildChip(title: "Phone caller", type: "communication"),
                    buildChip(title: "Video chatter", type: "communication"),
                    buildChip(
                        title: "I'm slow to answer on WhatsApp",
                        type: "communication"),
                    buildChip(title: "Bad texter", type: "communication"),
                    buildChip(title: "Better in person", type: "communication"),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(
                      CupertinoIcons.heart,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        "How do you receive love?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    buildChip(title: "Thoughtful gestures", type: "loveStyle"),
                    buildChip(title: "Presents", type: "loveStyle"),
                    buildChip(title: "Touch", type: "loveStyle"),
                    buildChip(title: "Compliments", type: "loveStyle"),
                    buildChip(title: "Time together", type: "loveStyle"),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildChip({required String title, required String type}) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            value.setBasics(
              item: title,
              isSelected: value.basicsMap[type] == title,
              key: type,
            );
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: value.basicsMap[type] == title
                        ? const Color(0xFFFE3C72)
                        : Colors.grey,
                  ),
                ),
                label: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
              )),
        );
      },
    );
  }

  Widget buildLifeStyleChip({required String title, required String type}) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            value.setLifeStyle(
              item: title,
              isSelected: value.lifestyleMap[type] == title,
              key: type,
            );
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: value.lifestyleMap[type] == title
                        ? const Color(0xFFFE3C72)
                        : Colors.grey,
                  ),
                ),
                label: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
              )),
        );
      },
    );
  }

  Widget buildAboutChip({required String title, required String type}) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            value.setAskMeAbout(
              item: title,
              isSelected: value.aboutMap[type] == title,
              key: type,
            );
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Chip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: value.aboutMap[type] == title
                        ? const Color(0xFFFE3C72)
                        : Colors.grey,
                  ),
                ),
                label: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
              )),
        );
      },
    );
  }

  Widget buildSheetAboutme() {
    return makeDismissable(
      child: DraggableScrollableSheet(
        minChildSize: 0.3,
        maxChildSize: 0.95,
        initialChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 19, 21, 23),
              border: const Border(
                  top: BorderSide(
                      color: Color.fromARGB(255, 30, 32, 34), width: 35)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              controller: scrollController,
              children: [
                const SizedBox(height: 10),
                const SizedBox(
                  child: Text(
                    "Ask me about",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  child: Text(
                    "Bring your best self forward by adding more about you",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(
                      Icons.travel_explore,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        "Going out?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    buildAboutChip(title: "dancing", type: "goingOut"),
                    buildAboutChip(title: "dress up", type: "goingOut"),
                    buildAboutChip(title: "early", type: "goingOut"),
                    buildAboutChip(title: "fashionably late", type: "goingOut"),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(
                      Icons.weekend_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        "My weekends",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    buildAboutChip(title: "recharging", type: "myWeekends"),
                    buildAboutChip(title: "socializing", type: "myWeekends"),
                    buildAboutChip(title: "cozy nights in", type: "myWeekends"),
                    buildAboutChip(title: "fun nights out", type: "myWeekends"),
                    buildAboutChip(title: "sunday funday", type: "myWeekends"),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(
                      Icons.contact_phone_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        "Me + My Phone",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    buildAboutChip(
                        title: "replies quickly", type: "meandmyphone"),
                    buildAboutChip(
                        title: "forgets to reply", type: "meandmyphone"),
                    buildAboutChip(
                        title: "text messages", type: "meandmyphone"),
                    buildAboutChip(
                      title: "phone calls",
                      type: "meandmyphone",
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildSheetLifeStyle() {
    return makeDismissable(
      child: DraggableScrollableSheet(
        minChildSize: 0.3,
        maxChildSize: 0.95,
        initialChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 19, 21, 23),
              border: const Border(
                  top: BorderSide(
                      color: Color.fromARGB(255, 30, 32, 34), width: 35)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                controller: scrollController,
                children: [
                  const SizedBox(height: 10),
                  const SizedBox(
                    child: Text(
                      "Life Style",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    child: Text(
                      "Bring your best self forward by adding your lifestyle",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(
                        Icons.pets_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Text(
                          "Do you have any pets?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      buildLifeStyleChip(title: "Dog", type: "pets"),
                      buildLifeStyleChip(title: "Cat", type: "pets"),
                      buildLifeStyleChip(title: "Reptile", type: "pets"),
                      buildLifeStyleChip(title: "Amphibian", type: "pets"),
                      buildLifeStyleChip(title: "Bird", type: "pets"),
                      buildLifeStyleChip(title: "Fish", type: "pets"),
                      buildLifeStyleChip(
                          title: "Don't have but love", type: "pets"),
                      buildLifeStyleChip(title: "Other", type: "pets"),
                      buildLifeStyleChip(title: "Turtle", type: "pets"),
                      buildLifeStyleChip(title: "Hamster", type: "pets"),
                      buildLifeStyleChip(title: "Rabbit", type: "pets"),
                      buildLifeStyleChip(title: "Pet-free", type: "pets"),
                      buildLifeStyleChip(title: "All the pets", type: "pets"),
                      buildLifeStyleChip(title: "Want a pet", type: "pets"),
                      buildLifeStyleChip(
                          title: "Allergic to pets", type: "pets"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Icon(
                        Icons.blender_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Text(
                          "How often you drink?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      buildLifeStyleChip(title: "Not for me", type: "drinking"),
                      buildLifeStyleChip(title: "Sober", type: "drinking"),
                      buildLifeStyleChip(
                          title: "Sober curious", type: "drinking"),
                      buildLifeStyleChip(
                          title: "On special occasions", type: "drinking"),
                      buildLifeStyleChip(
                          title: "Socially on weekends", type: "drinking"),
                      buildLifeStyleChip(
                          title: "Most Nights", type: "drinking"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Icon(
                        Icons.smoking_rooms,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Text(
                          "How often you smoke?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      buildLifeStyleChip(
                          title: "Social smoker", type: "smoking"),
                      buildLifeStyleChip(
                          title: "Smoker when drinking", type: "smoking"),
                      buildLifeStyleChip(title: "Non-smoker", type: "smoking"),
                      buildLifeStyleChip(title: "Smoker", type: "smoking"),
                      buildLifeStyleChip(
                          title: "Trying to quit", type: "smoking"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Icon(
                        Icons.sports_gymnastics,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Text(
                          "Do you workout?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      buildLifeStyleChip(title: "Everyday", type: "workout"),
                      buildLifeStyleChip(title: "Often", type: "workout"),
                      buildLifeStyleChip(title: "Sometimes", type: "workout"),
                      buildLifeStyleChip(title: "Never", type: "workout"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Icon(
                        Icons.local_pizza_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Text(
                          "What are your dietary preference?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      buildLifeStyleChip(
                          title: "Vegan", type: "dietaryPreference"),
                      buildLifeStyleChip(
                          title: "Vegetarian", type: "dietaryPreference"),
                      buildLifeStyleChip(
                          title: "Pescatarian", type: "dietaryPreference"),
                      buildLifeStyleChip(
                          title: "Kosher", type: "dietaryPreference"),
                      buildLifeStyleChip(
                          title: "Carnivore", type: "dietaryPreference"),
                      buildLifeStyleChip(
                          title: "Omnivare", type: "dietaryPreference"),
                      buildLifeStyleChip(
                          title: "Other", type: "dietaryPreference"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Icon(
                        CupertinoIcons.at,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Text(
                          "How active are you on social media?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      buildLifeStyleChip(
                          title: "Influencer status", type: "socialMedia"),
                      buildLifeStyleChip(
                          title: "Socially active", type: "socialMedia"),
                      buildLifeStyleChip(
                          title: "Off the grid", type: "socialMedia"),
                      buildLifeStyleChip(
                          title: "Passive scroller", type: "socialMedia"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Icon(
                        CupertinoIcons.bed_double,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Text(
                          "What are your sleeping habits?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      buildLifeStyleChip(
                          title: "Early bid", type: "sleepingHabits"),
                      buildLifeStyleChip(
                          title: "Night owl", type: "sleepingHabits"),
                      buildLifeStyleChip(
                          title: "In a spectrum", type: "sleepingHabits"),
                    ],
                  ),
                ]),
          );
        },
      ),
    );
  }

  Widget buildGenderSelect({required String gender}) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            value.addGender(value: gender, isSelected: value.gender == gender);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 1, left: 4),
                child: Text(
                  gender,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              value.gender == gender
                  ? Container(
                      margin: const EdgeInsets.only(top: 1, right: 10),
                      child: const Icon(
                        Icons.check,
                        size: 20,
                        color: Color(0xFFFE3C72),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }

  Widget buildRelationShipTypeSelect({required String type}) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            value.addRelationshipType(
                relationshipType: type,
                isSelected: value.relationshipType == type);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 1, left: 4),
                child: Text(
                  type,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              value.relationshipType == type
                  ? Container(
                      margin: const EdgeInsets.only(top: 1, right: 10),
                      child: const Icon(
                        Icons.check,
                        size: 20,
                        color: Color(0xFFFE3C72),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }

  Widget buildRelationShipGoalSelect(
      {required String type, required String icon, required String text}) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 30, 32, 34),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: value.relationshipGoal == type ? Colors.pink : Colors.grey,
              width: value.relationshipGoal == type ? 1 : 0,
            ),
          ),
          width: MediaQuery.of(context).size.width / 3.5,
          height: 100,
          child: InkWell(
            onTap: () {
              value.addRelationshipGoal(
                  relationshipGoal: type,
                  isSelected: value.relationshipGoal == type);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        icon,
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildLanguageSelect({required String language}) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            value.addLanguage(
                language: language,
                isSelected: value.language!.contains(language));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 1, left: 4),
                child: Text(
                  language,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              value.language!.contains(language)
                  ? Container(
                      margin: const EdgeInsets.only(top: 1, right: 10),
                      child: const Icon(
                        Icons.check,
                        size: 20,
                        color: Color(0xFFFE3C72),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }

  Widget buildInterestSelect({required String interest}) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            value.addInterest(
                interest: interest, isSelected: value.interest == interest);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 1, left: 4),
                child: Text(
                  interest,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              value.interest == interest
                  ? Container(
                      margin: const EdgeInsets.only(top: 1, right: 10),
                      child: const Icon(
                        Icons.check,
                        size: 20,
                        color: Color(0xFFFE3C72),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }

  Widget buildSexualOrientationSelect({required String sex}) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            value.addSexualOrientation(
                sexualOrientation: sex,
                isSelected: value.sexualOrientation == sex);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 1, left: 4),
                child: Text(
                  sex,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              value.sexualOrientation == sex
                  ? Container(
                      margin: const EdgeInsets.only(top: 1, right: 10),
                      child: const Icon(
                        Icons.check,
                        size: 20,
                        color: Color(0xFFFE3C72),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
