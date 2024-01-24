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

  @override
  void initState() {
    super.initState();
    _aboutController = TextEditingController(text: "");
    _jobTitleController = TextEditingController(text: "");
    _companyController = TextEditingController(text: "");
    _collegeController = TextEditingController(text: "");
    _livinginController = TextEditingController(text: "");
    _instagramController = TextEditingController(text: "");
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
    return Scaffold(
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
                return buildWithOutImage();
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
                height: 300,
                subcategoryname: "Select interest",
                title: "Interests",
                modalContent: Container(
                  child: Text("data"),
                )),
            buildMainCategory(
              icon: CupertinoIcons.eye,
              height: 200,
              subcategoryname: "Looking for",
              title: "Relationship Goals",
              modalContent: Text("data"),
            ),
            buildMainCategory(
              icon: CupertinoIcons.tag,
              height: 120,
              subcategoryname: "Add height",
              title: "Height",
              modalContent: Text("data"),
            ),
            buildMainCategory(
              icon: CupertinoIcons.eye,
              height: 340,
              subcategoryname: "Open to...",
              title: "Relationship Type",
              modalContent: Text("data"),
            ),
            buildMainCategory(
              icon: Icons.language,
              height: 300,
              subcategoryname: "Open to...",
              title: "Add languages",
              modalContent: Text("data"),
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
              height: 200,
              subcategoryname: "Add sexual Orintation",
              title: "Sexual Orientation",
              modalContent: Text("data"),
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
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.menu_book_sharp,
                        subcategoryname: "Education",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.family_restroom,
                        subcategoryname: "Family Plans",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.medical_information,
                        subcategoryname: "Covid Vaccine",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.tips_and_updates_rounded,
                        subcategoryname: "Personality Type",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.add_call,
                        subcategoryname: "Communication style",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: CupertinoIcons.heart,
                        subcategoryname: "Love style",
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
                      buildInsideSubCategory(
                        icon: CupertinoIcons.moon_stars,
                        subcategoryname: "Zodiac",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.menu_book_sharp,
                        subcategoryname: "Education",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.family_restroom,
                        subcategoryname: "Family Plans",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.medical_information,
                        subcategoryname: "Covid Vaccine",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.tips_and_updates_rounded,
                        subcategoryname: "Personality Type",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.add_call,
                        subcategoryname: "Communication style",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: CupertinoIcons.heart,
                        subcategoryname: "Love style",
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
                      buildInsideSubCategory(
                        icon: CupertinoIcons.moon_stars,
                        subcategoryname: "Zodiac",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.menu_book_sharp,
                        subcategoryname: "Education",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.family_restroom,
                        subcategoryname: "Family Plans",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.medical_information,
                        subcategoryname: "Covid Vaccine",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.tips_and_updates_rounded,
                        subcategoryname: "Personality Type",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: Icons.add_call,
                        subcategoryname: "Communication style",
                      ),
                      const SizedBox(height: 25),
                      buildInsideSubCategory(
                        icon: CupertinoIcons.heart,
                        subcategoryname: "Love style",
                      ),
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

  Widget buildInsideSubCategory({
    required IconData icon,
    required String subcategoryname,
    String? subcategory,
  }) {
    return InkWell(
      onTap: basicBottomSheet,
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
                    textDirection: TextDirection.rtl,
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

  void basicBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      elevation: 0,
      context: context,
      builder: (context) {
        return buildSheet();
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

  Widget buildSheet() {
    return makeDismissable(
      child: DraggableScrollableSheet(
        shouldCloseOnMinExtent: true,
        minChildSize: 0.5,
        maxChildSize: 0.85,
        builder: (context, scrollController) {
          return Container(
            color: Colors.red,
            child: ListView.builder(
              itemCount: 100,
              controller: scrollController,
              itemBuilder: (context, index) {
                return Container(
                  child: Text("Hello"),
                );
              },
            ),
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
}
