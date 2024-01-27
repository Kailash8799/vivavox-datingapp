import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                                icon: Icons.list,
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
                                icon: Icons.list,
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
                                icon: Icons.list,
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
                                icon: Icons.list,
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
                                icon: Icons.list,
                                item: "${profiledetail.language}",
                              )
                            : const SizedBox(height: 0),
                      ],
                    ),
                  ),
          ),
          SliverToBoxAdapter(
            child: buildList(
              icon: CupertinoIcons.tray_full,
              title: "Basics",
              listitem: profiledetail.toJson(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildList(
      {required IconData icon,
      Map<String, dynamic>? listitem,
      String? desc,
      required String title}) {
    if (desc != null) {
      return Container(
        margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color.fromARGB(255, 19, 21, 23),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                    child: Icon(
                  icon,
                  color: const Color.fromARGB(255, 133, 138, 142),
                  size: 17,
                )),
                const TextSpan(text: "  "),
                TextSpan(
                  text: title,
                  style: const TextStyle(
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
          Text(
            desc,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          )
        ]),
      );
    }
    if (listitem != null) {
      return Container(
        margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
        padding: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color.fromARGB(255, 19, 21, 23),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                    child: Icon(
                  icon,
                  color: const Color.fromARGB(255, 133, 138, 142),
                  size: 17,
                )),
                const TextSpan(text: "  "),
                TextSpan(
                  text: title,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 133, 138, 142),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          // listitem["askMeAbout"].values.forEach((v) => {buildListInside()})
          buildListInside(),
          buildListInside(),
          buildListInside(),
        ]),
      );
    }
    return const SizedBox();
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

  Widget buildListInside() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "❤️ Short time fun",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "❤️ Short time fun",
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        )
      ],
    );
  }
}
