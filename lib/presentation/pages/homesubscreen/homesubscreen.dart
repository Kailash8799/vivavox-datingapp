import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivavox/presentation/providers/cardprovider.dart';
import 'package:vivavox/presentation/widgets/animation/rippleanimation.dart';
import 'package:vivavox/presentation/widgets/card/vivavoxcard.dart';

class HomesubScreen extends StatefulWidget {
  const HomesubScreen({super.key});
  @override
  State<HomesubScreen> createState() => _HomesubScreenState();
}

class _HomesubScreenState extends State<HomesubScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          buildCards(),
          Consumer<CardProvider>(
            builder: (context, value, child) {
              return Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(133, 229, 232, 220)
                              .withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color.fromARGB(255, 227, 209, 15)
                                      .withOpacity(1),
                                  const Color.fromRGBO(255, 255, 255, 1)
                                      .withOpacity(0.7),
                                  const Color.fromARGB(255, 255, 223, 16)
                                      .withOpacity(1),
                                ],
                              ).createShader(bounds);
                            },
                            child: Icon(
                              CupertinoIcons.restart,
                              color: value.profileDetails.isNotEmpty
                                  ? const Color.fromARGB(255, 255, 239, 69)
                                  : Colors.grey,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          value.dislike();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: value.isDisLike ? 80 : 60,
                          width: value.isDisLike ? 80 : 60,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(133, 229, 232, 220)
                                .withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: ShaderMask(
                              shaderCallback: (bounds) {
                                return const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(255, 233, 240, 232),
                                    Color.fromARGB(255, 255, 255, 255),
                                    Color.fromARGB(255, 4, 18, 5)
                                  ],
                                ).createShader(bounds);
                              },
                              child: Icon(
                                CupertinoIcons.multiply,
                                color: value.profileDetails.isNotEmpty
                                    ? const Color(0xFFE91E63)
                                    : Colors.grey,
                                size: 50,
                                weight: 900,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          value.like();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: value.isLike ? 80 : 60,
                          width: value.isLike ? 80 : 60,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(133, 229, 232, 220)
                                .withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: ShaderMask(
                              shaderCallback: (bounds) {
                                return const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(255, 233, 240, 232),
                                    Color.fromARGB(255, 255, 255, 255),
                                    Color.fromARGB(255, 4, 18, 5)
                                  ],
                                ).createShader(bounds);
                              },
                              child: Icon(
                                CupertinoIcons.heart_fill,
                                color: value.profileDetails.isNotEmpty
                                    ? const Color.fromARGB(255, 64, 205, 68)
                                    : Colors.grey,
                                size: 44,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          value.superlike();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: value.isSuperLike ? 70 : 50,
                          width: value.isSuperLike ? 70 : 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(133, 229, 232, 220)
                                .withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: ShaderMask(
                              shaderCallback: (bounds) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 233, 240, 232),
                                    Color.fromARGB(255, 255, 255, 255),
                                    Color.fromARGB(255, 92, 82, 82)
                                  ],
                                ).createShader(bounds);
                              },
                              child: Icon(
                                CupertinoIcons.bolt_fill,
                                color: value.profileDetails.isNotEmpty
                                    ? const Color(0xFF9C27B0)
                                    : Colors.grey,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(
      context,
    );
    final userprofiles = provider.profileDetails;
    return provider.isProfilefetching
        ? const RippleAnimation()
        : userprofiles.isEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No such more profiles found!',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      child: const Text(
                        'Try again',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        provider.initialize();
                      },
                    ),
                  ),
                ],
              )
            : Stack(
                alignment: AlignmentDirectional.center,
                children: userprofiles
                    .map((profile) => VivavoxCard(
                          profile: profile,
                          isFront: userprofiles.last.id == profile.id,
                        ))
                    .toList(),
              );
  }
}
