import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivavox/presentation/providers/cardprovider.dart';
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
              return value.assetImages.isNotEmpty
                  ? Positioned(
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
                                  child: const Icon(
                                    CupertinoIcons.restart,
                                    color: Color.fromARGB(255, 255, 239, 69),
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
                                  color:
                                      const Color.fromARGB(133, 229, 232, 220)
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
                                    child: const Icon(
                                      CupertinoIcons.multiply,
                                      color: Color(0xFFE91E63),
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
                                  color:
                                      const Color.fromARGB(133, 229, 232, 220)
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
                                    child: const Icon(
                                      CupertinoIcons.heart_fill,
                                      color: Color.fromARGB(255, 64, 205, 68),
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
                                  color:
                                      const Color.fromARGB(133, 229, 232, 220)
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
                                    child: const Icon(
                                      CupertinoIcons.bolt_fill,
                                      color: Color(0xFF9C27B0),
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          )
        ],
      ),
    );
  }

  Widget buildCards() {
    final provider = Provider.of<CardProvider>(context);
    final assetImages = provider.assetImages;
    return assetImages.isEmpty
        ? Center(
            child: ElevatedButton(
                child: const Text('Restart'),
                onPressed: () {
                  provider.userimages();
                }))
        : Stack(
            alignment: AlignmentDirectional.center,
            children: assetImages
                .map((assetImage) => VivavoxCard(
                      assetImage: assetImage,
                      isFront: assetImages.last == assetImage,
                    ))
                .toList(),
          );
  }
}
