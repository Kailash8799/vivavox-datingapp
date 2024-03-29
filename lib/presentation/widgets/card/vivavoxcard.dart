import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vivavox/presentation/pages/userprofiledetails.dart';
import 'package:vivavox/presentation/providers/cardprovider.dart';
import 'package:vivavox/services/model/profileinfo.dart';

class VivavoxCard extends StatefulWidget {
  final Profileinfo profile;
  final bool isFront;
  const VivavoxCard({
    super.key,
    required this.profile,
    required this.isFront,
  });
  @override
  State<VivavoxCard> createState() => _VivavoxCardState();
}

class _VivavoxCardState extends State<VivavoxCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      final provider = Provider.of<CardProvider>(context, listen: false);
      provider.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: widget.isFront ? buildfirstcard() : buildCard(),
    );
  }

  Widget buildfirstcard() => GestureDetector(
        child: LayoutBuilder(builder: (context, constraints) {
          final provider = Provider.of<CardProvider>(context);
          final position = provider.position;
          final milliseconds = provider.isDragging ? 0 : 400;
          final center = constraints.smallest.center(Offset.zero);
          final angle = provider.angle * pi / 180;
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);
          return AnimatedContainer(
            curve: Curves.linear,
            duration: Duration(milliseconds: milliseconds),
            transform: rotatedMatrix..translate(position.dx, position.dy),
            child: Stack(
              children: [
                buildCard(),
                buildStamps(),
              ],
            ),
          );
        }),
        onPanStart: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.startPosition(details);
        },
        onPanUpdate: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.updatePosition(details);
        },
        onPanEnd: (details) {
          final provider = Provider.of<CardProvider>(context, listen: false);
          provider.endPosition();
        },
      );
  Widget buildCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.black,
                    child: Hero(
                      tag: widget.profile.id,
                      child: CachedNetworkImage(
                        imageUrl: widget.profile.profileimage ?? "",
                        placeholder: (context, url) {
                          return Shimmer(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 26, 26, 28),
                                Color.fromARGB(255, 23, 23, 23),
                                Color.fromARGB(255, 17, 17, 18),
                              ],
                              stops: [
                                0.1,
                                0.3,
                                0.4,
                              ],
                              begin: Alignment(-1.0, -0.3),
                              end: Alignment(1.0, 0.3),
                              tileMode: TileMode.clamp,
                            ),
                            child: Container(
                              color: Colors.black,
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Container(
                            color: Colors.black,
                            child: const Center(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Image loading error",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ])),
                          );
                        },
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  gradient: LinearGradient(
                    tileMode: TileMode.repeated,
                    colors: [
                      Color.fromARGB(255, 34, 65, 92),
                      Color.fromARGB(255, 6, 16, 27),
                      Colors.black
                    ],
                    stops: [0.1, 0.6, 0.9],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(0),
                    Colors.white.withOpacity(1),
                  ],
                  stops: const [0.1, 0.4, 0.8],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color.fromARGB(255, 32, 41, 45),
                      Colors.black,
                    ])),
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.profile.username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                CupertinoIcons.location_solid,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            const TextSpan(text: " "),
                            TextSpan(
                                text: widget.profile.liviningIn ??
                                    "21 miles away"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const UserProfileDetailScreen();
                          },
                          settings: RouteSettings(arguments: {
                            "profile": widget.profile,
                            "keytag": widget.profile.id
                          }),
                        ),
                      );
                    },
                    icon: const Icon(
                      CupertinoIcons.up_arrow,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStamps() {
    final provider = Provider.of<CardProvider>(context);
    final status = provider.getStatus(force: true);
    switch (status) {
      case CardStatus.like:
        final child =
            buildStamp(angle: -0.5, color: Colors.green, text: "LIKE");
        return Positioned(top: 64, left: 50, child: child);
      case CardStatus.dislike:
        final child = buildStamp(angle: 0.5, color: Colors.red, text: "NOPE");
        return Positioned(top: 64, right: 50, child: child);
      case CardStatus.superlike:
        final child = buildStamp(color: Colors.blue, text: "SUPERLIKE");
        return Positioned(bottom: 170, left: 0, right: 0, child: child);
      default:
    }
    return Container();
  }

  Widget buildStamp(
      {double angle = 0, required Color color, required String text}) {
    final provider = Provider.of<CardProvider>(context);
    final opacity = provider.getStatusOpacity();
    return Opacity(
      opacity: opacity,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color,
              width: 4,
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
