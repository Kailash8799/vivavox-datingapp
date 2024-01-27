import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vivavox/presentation/pages/notfound.dart';
import 'package:vivavox/services/model/profileinfo.dart';

class UserProfileDetailScreen extends StatefulWidget {
  const UserProfileDetailScreen({super.key});

  @override
  State<UserProfileDetailScreen> createState() => _UserProfileDetailScreen();
}

class _UserProfileDetailScreen extends State<UserProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final routeinfo = ModalRoute.of(context)!.settings.arguments;
    if (routeinfo == null) {
      return const NotFound();
    }
    final data = routeinfo as Map;
    if (data["profile"] == null) {
      return const NotFound();
    }
    final profiledetail = data["profile"] as Profileinfo;
    final keytag = data["keytag"];
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            surfaceTintColor: Colors.transparent,
            title: RichText(
                text: TextSpan(children: [
              TextSpan(
                text: profiledetail.username,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: profiledetail.birthdate == null
                    ? ""
                    : profiledetail.birthdate.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )
            ])),
            titleSpacing: 10,
            leading: const SizedBox(),
            leadingWidth: 0,
            actions: [
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
                  ))
            ],
            // backgroundColor: const Color.fromARGB(113, 107, 102, 107),
            // backgroundColor: Color(0xFF23272A),
            backgroundColor: Colors.black,
          ),
          SliverToBoxAdapter(
            child: Hero(
              tag: keytag,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: CachedNetworkImage(
                  imageUrl: profiledetail.profileimage ?? "",
                  placeholder: (context, url) {
                    return const Center(
                      child: Icon(Icons.local_dining),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 30,
                      ),
                    );
                  },
                  height: size.height - 400,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: profiledetail.relationshipGoal == null &&
                    profiledetail.relationshipType == null
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color.fromARGB(255, 19, 21, 23),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(
                                CupertinoIcons.search,
                                color: Color.fromARGB(255, 133, 138, 142),
                                size: 17,
                              )),
                              TextSpan(text: "  "),
                              TextSpan(
                                text: "Looking for",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 133, 138, 142),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        profiledetail.relationshipGoal == null
                            ? const SizedBox(height: 0)
                            : Text(
                                profiledetail.relationshipGoal ?? "",
                                style: const TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                        profiledetail.relationshipType != null &&
                                profiledetail.relationshipType != null
                            ? const Divider(
                                color: Color.fromARGB(255, 36, 40, 44),
                              )
                            : const SizedBox(height: 0),
                        profiledetail.relationshipType == null
                            ? const SizedBox(height: 0)
                            : Chip(
                                label: Text(
                                  profiledetail.relationshipType ?? "",
                                  style: const TextStyle(color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    side: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 30, 33, 36))),
                                backgroundColor:
                                    const Color.fromARGB(255, 30, 33, 36),
                              ),
                      ],
                    ),
                  ),
          ),
          SliverToBoxAdapter(
            child: profiledetail.aboutme == null ||
                    profiledetail.aboutme!.isEmpty
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color.fromARGB(255, 19, 21, 23),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(
                                Icons.format_quote,
                                color: Color.fromARGB(255, 133, 138, 142),
                                size: 17,
                              )),
                              TextSpan(text: "  "),
                              TextSpan(
                                text: "About me",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 133, 138, 142),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        profiledetail.aboutme == null
                            ? const SizedBox(height: 0)
                            : Text(
                                profiledetail.aboutme ?? "",
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ],
                    ),
                  ),
          ),
          SliverToBoxAdapter(
            child: profiledetail.liviningIn == null &&
                    profiledetail.height == null &&
                    profiledetail.jobTitle == null &&
                    profiledetail.collageName == null &&
                    profiledetail.sexualOrientation == null &&
                    (profiledetail.language == null ||
                        profiledetail.language!.isEmpty)
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color.fromARGB(255, 19, 21, 23),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(
                                CupertinoIcons.person_crop_square_fill,
                                color: Color.fromARGB(255, 133, 138, 142),
                                size: 17,
                              )),
                              TextSpan(text: "  "),
                              TextSpan(
                                text: "Essentials",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 133, 138, 142),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        profiledetail.liviningIn == null
                            ? const SizedBox(height: 0)
                            : builsEssentials(
                                icon: Icons.location_on_outlined,
                                item: profiledetail.liviningIn ?? ""),
                        profiledetail.height != null
                            ? const Divider(
                                color: Color.fromARGB(255, 36, 40, 44),
                              )
                            : const SizedBox(height: 0),
                        profiledetail.height == null
                            ? const SizedBox(height: 0)
                            : builsEssentials(
                                icon: Icons.height,
                                item: "${profiledetail.height} cm",
                              ),
                        profiledetail.jobTitle != null
                            ? const Divider(
                                color: Color.fromARGB(255, 36, 40, 44),
                              )
                            : const SizedBox(height: 0),
                        profiledetail.jobTitle == null
                            ? const SizedBox(height: 0)
                            : builsEssentials(
                                icon: Icons.work,
                                item:
                                    "${profiledetail.jobTitle} ${profiledetail.companyName == null ? "" : "at ${profiledetail.companyName}"}",
                              ),
                        profiledetail.collageName != null
                            ? const Divider(
                                color: Color.fromARGB(255, 36, 40, 44),
                              )
                            : const SizedBox(height: 0),
                        profiledetail.collageName == null
                            ? const SizedBox(height: 0)
                            : builsEssentials(
                                icon: Icons.school,
                                item: profiledetail.collageName ?? "",
                              ),
                        profiledetail.sexualOrientation != null
                            ? const Divider(
                                color: Color.fromARGB(255, 36, 40, 44),
                              )
                            : const SizedBox(height: 0),
                        profiledetail.sexualOrientation == null
                            ? const SizedBox(height: 0)
                            : builsEssentials(
                                icon: Icons.merge_type,
                                item: "${profiledetail.sexualOrientation}",
                              ),
                        profiledetail.language != null &&
                                profiledetail.language!.isNotEmpty
                            ? const Divider(
                                color: Color.fromARGB(255, 36, 40, 44),
                              )
                            : const SizedBox(height: 0),
                        profiledetail.language != null &&
                                profiledetail.language!.isNotEmpty
                            ? builsEssentials(
                                icon: Icons.language,
                                item: "${profiledetail.language}",
                              )
                            : const SizedBox(height: 0),
                      ],
                    ),
                  ),
          ),
          SliverToBoxAdapter(
            child: profiledetail.basics == null ||
                    (profiledetail.basics!.communication == null &&
                        profiledetail.basics!.covidVaccine == null &&
                        profiledetail.basics!.eduction == null &&
                        profiledetail.basics!.familyPlan == null &&
                        profiledetail.basics!.loveStyle == null &&
                        profiledetail.basics!.personalityType == null &&
                        profiledetail.basics!.zodiac == null)
                ? const SizedBox(height: 0)
                : Container(
                    margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color.fromARGB(255, 19, 21, 23),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              children: [
                                WidgetSpan(
                                    child: Icon(
                                  CupertinoIcons.tray_full,
                                  color: Color.fromARGB(255, 133, 138, 142),
                                  size: 17,
                                )),
                                TextSpan(text: "  "),
                                TextSpan(
                                  text: "Basics",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 133, 138, 142),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          // listitem["askMeAbout"].values.forEach((v) => {buildListInside()})
                          profiledetail.basics!.zodiac == null
                              ? const SizedBox()
                              : buildListInside(
                                  title: "Zodiac",
                                  ans: profiledetail.basics!.zodiac!,
                                  icon: CupertinoIcons.moon_stars,
                                ),

                          profiledetail.basics!.eduction != null
                              ? const Divider(
                                  color: Color.fromARGB(255, 36, 40, 44),
                                )
                              : const SizedBox(height: 0),
                          profiledetail.basics!.eduction == null
                              ? const SizedBox()
                              : buildListInside(
                                  title: "Education",
                                  ans: profiledetail.basics!.eduction!,
                                  icon: Icons.menu_book_sharp,
                                ),
                          profiledetail.basics!.familyPlan != null
                              ? const Divider(
                                  color: Color.fromARGB(255, 36, 40, 44),
                                )
                              : const SizedBox(height: 0),
                          profiledetail.basics!.familyPlan == null
                              ? const SizedBox()
                              : buildListInside(
                                  title: "Family Plans",
                                  ans: profiledetail.basics!.familyPlan!,
                                  icon: Icons.family_restroom,
                                ),
                          profiledetail.basics!.covidVaccine != null
                              ? const Divider(
                                  color: Color.fromARGB(255, 36, 40, 44),
                                )
                              : const SizedBox(height: 0),
                          profiledetail.basics!.covidVaccine == null
                              ? const SizedBox()
                              : buildListInside(
                                  title: "COVID Vaccine",
                                  ans: profiledetail.basics!.covidVaccine!,
                                  icon: Icons.medical_information,
                                ),
                          profiledetail.basics!.personalityType != null
                              ? const Divider(
                                  color: Color.fromARGB(255, 36, 40, 44),
                                )
                              : const SizedBox(height: 0),
                          profiledetail.basics!.personalityType == null
                              ? const SizedBox()
                              : buildListInside(
                                  title: "Personality Type",
                                  ans: profiledetail.basics!.personalityType!,
                                  icon: Icons.tips_and_updates_rounded,
                                ),
                          profiledetail.basics!.communication != null
                              ? const Divider(
                                  color: Color.fromARGB(255, 36, 40, 44),
                                )
                              : const SizedBox(height: 0),
                          profiledetail.basics!.communication == null
                              ? const SizedBox()
                              : buildListInside(
                                  title: "Communication Style",
                                  ans: profiledetail.basics!.communication!,
                                  icon: Icons.add_call,
                                ),
                          profiledetail.basics!.loveStyle != null
                              ? const Divider(
                                  color: Color.fromARGB(255, 36, 40, 44),
                                )
                              : const SizedBox(height: 0),
                          profiledetail.basics!.loveStyle == null
                              ? const SizedBox()
                              : buildListInside(
                                  title: "Love Style",
                                  ans: profiledetail.basics!.loveStyle!,
                                  icon: CupertinoIcons.heart,
                                ),
                        ]),
                  ),
          ),
          SliverToBoxAdapter(
            child: profiledetail.lifeStyle == null ||
                    (profiledetail.lifeStyle!.dietaryPreference == null &&
                        profiledetail.lifeStyle!.drinking == null &&
                        profiledetail.lifeStyle!.pets == null &&
                        profiledetail.lifeStyle!.sleepingHabits == null &&
                        profiledetail.lifeStyle!.smoking == null &&
                        profiledetail.lifeStyle!.socialMedia == null &&
                        profiledetail.lifeStyle!.workout == null)
                ? const SizedBox(height: 0)
                : Container(
                    margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color.fromARGB(255, 19, 21, 23),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              children: [
                                WidgetSpan(
                                    child: Icon(
                                  CupertinoIcons.tray_full,
                                  color: Color.fromARGB(255, 133, 138, 142),
                                  size: 17,
                                )),
                                TextSpan(text: "  "),
                                TextSpan(
                                  text: "Lifestyle",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 133, 138, 142),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          // listitem["askMeAbout"].values.forEach((v) => {buildListInside()})
                          profiledetail.lifeStyle!.pets == null
                              ? const SizedBox()
                              : buildListInside(
                                  title: "Pets",
                                  ans: profiledetail.lifeStyle!.pets!,
                                  icon: Icons.pets_outlined,
                                ),

                          profiledetail.lifeStyle!.drinking != null
                              ? const Divider(
                                  color: Color.fromARGB(255, 36, 40, 44),
                                )
                              : const SizedBox(height: 0),
                          profiledetail.lifeStyle!.drinking == null
                              ? const SizedBox()
                              : buildListInside(
                                  title: "Drinking",
                                  ans: profiledetail.lifeStyle!.drinking!,
                                  icon: Icons.blender_outlined,
                                ),
                          profiledetail.lifeStyle!.smoking != null
                              ? const Divider(
                                  color: Color.fromARGB(255, 36, 40, 44),
                                )
                              : const SizedBox(height: 0),
                          profiledetail.lifeStyle!.smoking == null
                              ? const SizedBox()
                              : buildListInside(
                                  title: "Smoking",
                                  ans: profiledetail.lifeStyle!.smoking!,
                                  icon: Icons.smoking_rooms,
                                ),
                          profiledetail.lifeStyle!.workout != null
                              ? const Divider(
                                  color: Color.fromARGB(255, 36, 40, 44),
                                )
                              : const SizedBox(height: 0),
                          profiledetail.lifeStyle!.workout == null
                              ? const SizedBox()
                              : buildListInside(
                                  title: "Workout",
                                  ans: profiledetail.lifeStyle!.workout!,
                                  icon: Icons.sports_gymnastics,
                                ),
                          profiledetail.lifeStyle!.dietaryPreference != null
                              ? const Divider(
                                  color: Color.fromARGB(255, 36, 40, 44),
                                )
                              : const SizedBox(height: 0),
                          profiledetail.lifeStyle!.dietaryPreference == null
                              ? const SizedBox()
                              : buildListInside(
                                  title: "Dietary Preference",
                                  ans: profiledetail
                                      .lifeStyle!.dietaryPreference!,
                                  icon: Icons.local_pizza_outlined,
                                ),
                          profiledetail.lifeStyle!.socialMedia != null
                              ? const Divider(
                                  color: Color.fromARGB(255, 36, 40, 44),
                                )
                              : const SizedBox(height: 0),
                          profiledetail.lifeStyle!.socialMedia == null
                              ? const SizedBox()
                              : buildListInside(
                                  title: "Social Media",
                                  ans: profiledetail.lifeStyle!.socialMedia!,
                                  icon: CupertinoIcons.at,
                                ),
                          profiledetail.lifeStyle!.sleepingHabits != null
                              ? const Divider(
                                  color: Color.fromARGB(255, 36, 40, 44),
                                )
                              : const SizedBox(height: 0),
                          profiledetail.lifeStyle!.sleepingHabits == null
                              ? const SizedBox()
                              : buildListInside(
                                  title: "Sleeping Habits",
                                  ans: profiledetail.lifeStyle!.sleepingHabits!,
                                  icon: CupertinoIcons.bed_double,
                                ),
                        ]),
                  ),
          ),
          SliverToBoxAdapter(
            child: profiledetail.interest == null ||
                    profiledetail.interest!.isEmpty
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color.fromARGB(255, 19, 21, 23),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(
                                Icons.format_quote,
                                color: Color.fromARGB(255, 133, 138, 142),
                                size: 17,
                              )),
                              TextSpan(text: "  "),
                              TextSpan(
                                text: "Interest",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 133, 138, 142),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        profiledetail.interest == null
                            ? const SizedBox(height: 0)
                            : Text(
                                profiledetail.interest ?? "",
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ],
                    ),
                  ),
          ),
          SliverToBoxAdapter(
            child: profiledetail.instagranId == null ||
                    profiledetail.instagranId!.isEmpty
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color.fromARGB(255, 19, 21, 23),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(
                                FontAwesomeIcons.instagram,
                                color: Color.fromARGB(255, 133, 138, 142),
                                size: 17,
                              )),
                              TextSpan(text: "  "),
                              TextSpan(
                                text: "Instagram",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 133, 138, 142),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        profiledetail.instagranId == null
                            ? const SizedBox(height: 0)
                            : Text(
                                profiledetail.instagranId ?? "",
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ],
                    ),
                  ),
          ),
          SliverToBoxAdapter(
            child: profiledetail.gender == null || profiledetail.gender!.isEmpty
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color.fromARGB(255, 19, 21, 23),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(
                                profiledetail.gender == "Men"
                                    ? Icons.male
                                    : profiledetail.gender == "Women"
                                        ? Icons.female
                                        : Icons.boy,
                                color: const Color.fromARGB(255, 133, 138, 142),
                                size: 17,
                              )),
                              const TextSpan(text: "  "),
                              const TextSpan(
                                text: "Gender",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 133, 138, 142),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        profiledetail.gender == null
                            ? const SizedBox(height: 0)
                            : Text(
                                profiledetail.gender ?? "",
                                style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ],
                    ),
                  ),
          ),
          SliverToBoxAdapter(
            child: profiledetail.askMeAbout == null ||
                    (profiledetail.askMeAbout!.goingOut == null &&
                        profiledetail.askMeAbout!.meandmyphone == null &&
                        profiledetail.askMeAbout!.myWeekends == null)
                ? const SizedBox(height: 0)
                : Container(
                    margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
                    padding: const EdgeInsets.all(15),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color.fromARGB(255, 19, 21, 23),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Icon(
                                CupertinoIcons.tray_full,
                                color: Color.fromARGB(255, 133, 138, 142),
                                size: 17,
                              )),
                              TextSpan(text: "  "),
                              TextSpan(
                                text: "More About me",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 133, 138, 142),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        // listitem["askMeAbout"].values.forEach((v) => {buildListInside()})
                        profiledetail.askMeAbout!.goingOut == null
                            ? const SizedBox()
                            : buildListInside(
                                title: "Going out",
                                ans: profiledetail.askMeAbout!.goingOut!,
                                icon: Icons.travel_explore,
                              ),

                        profiledetail.askMeAbout!.myWeekends != null
                            ? const Divider(
                                color: Color.fromARGB(255, 36, 40, 44),
                              )
                            : const SizedBox(height: 0),
                        profiledetail.askMeAbout!.myWeekends == null
                            ? const SizedBox()
                            : buildListInside(
                                title: "My weekends",
                                ans: profiledetail.askMeAbout!.myWeekends!,
                                icon: Icons.weekend_rounded,
                              ),
                        profiledetail.askMeAbout!.meandmyphone != null
                            ? const Divider(
                                color: Color.fromARGB(255, 36, 40, 44),
                              )
                            : const SizedBox(height: 0),
                        profiledetail.askMeAbout!.meandmyphone == null
                            ? const SizedBox()
                            : buildListInside(
                                title: "Me + My Phone",
                                ans: profiledetail.askMeAbout!.meandmyphone!,
                                icon: Icons.contact_phone_rounded,
                              ),
                      ],
                    ),
                  ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    );
  }

  Widget builsEssentials({required IconData icon, required String item}) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color.fromARGB(255, 133, 138, 142),
          size: 17,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildListInside(
      {required IconData icon, required String title, required String ans}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            const SizedBox(width: 5),
            Icon(
              icon,
              color: const Color.fromARGB(255, 133, 138, 142),
              size: 17,
            ),
            const SizedBox(width: 7),
            Text(
              ans,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        )
      ],
    );
  }
}
