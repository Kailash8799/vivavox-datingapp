import 'dart:ui' as ui;
import 'package:flutter/material.dart';

@immutable
class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  List<Message> data = [];
  final TextEditingController _chatController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _chatController.dispose();
  }

  void sendMessage() async {
    if (_chatController.text.trim().isEmpty) return;
    setState(() {
      data.insert(
        0,
        Message(owner: MessageOwner.myself, text: _chatController.text.trim()),
      );
      _chatController.clear();
    });
  }

  // final DecorationTween _tween = DecorationTween(
  //   begin: BoxDecoration(
  //     color: Colors.transparent,
  //     boxShadow: const <BoxShadow>[],
  //     borderRadius: BorderRadius.circular(20.0),
  //   ),
  //   end: BoxDecoration(
  //     color: Colors.transparent,
  //     boxShadow: CupertinoContextMenu.kEndBoxShadow,
  //     borderRadius: BorderRadius.circular(20.0),
  //   ),
  // );

  // Animation<Decoration> _boxDecorationAnimation(Animation<double> animation) {
  //   return _tween.animate(
  //     CurvedAnimation(
  //       parent: animation,
  //       curve: Interval(
  //         0.0,
  //         CupertinoContextMenu.animationOpensAt,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF4F4F4F),
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              position: PopupMenuPosition.under,
              splashRadius: 100,
              color: const Color.fromARGB(255, 52, 54, 56),
              surfaceTintColor: Colors.transparent,
              itemBuilder: (context) {
                return <PopupMenuEntry<int>>[
                  PopupMenuItem(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width - 250,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.block,
                              size: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "Block",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ],
                        )),
                  ),
                ];
              },
              icon: const Icon(
                Icons.more_vert_outlined,
              ),
            ),
            const SizedBox(width: 3)
          ],
          backgroundColor: const Color.fromARGB(255, 16, 15, 15),
          titleSpacing: 0,
          title: InkWell(
            overlayColor: const MaterialStatePropertyAll(Colors.transparent),
            onTap: () {},
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 24, 25, 26),
                  maxRadius: 23,
                  minRadius: 23,
                  // child: profileimage.isEmpty
                  //     ? const SizedBox()
                  //     : CachedNetworkImage(
                  //         imageUrl: profileimage,
                  //       ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "Kailash Rajput here studfdgf fgf skfg gdfjg bv",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        "Online",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                reverse: true,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final message = data[index];
                  return MessageBubble(
                    message: message,
                    child: Text(message.text),
                  );
                  // return Expanded(
                  //   child: CupertinoContextMenu.builder(
                  //     actions: [
                  //       CupertinoContextMenuAction(
                  //         onPressed: () {
                  //           Navigator.pop(context);
                  //         },
                  //         isDefaultAction: true,
                  //         trailingIcon: CupertinoIcons.doc_on_clipboard_fill,
                  //         child: const Text('Copy'),
                  //       ),
                  //     ],
                  //     builder:
                  //         (BuildContext context, Animation<double> animation) {
                  //       final Animation<Decoration> boxDecorationAnimation =
                  //           _boxDecorationAnimation(animation);
                  //       return Container(
                  //         decoration: animation.value <
                  //                 CupertinoContextMenu.animationOpensAt
                  //             ? boxDecorationAnimation.value
                  //             : null,
                  //         child: MessageBubble(
                  //           message: message,
                  //           child: Text(message.text),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // );
                },
              ),
            ),
            SizedBox(
              // height: 70,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLines: 4,
                        minLines: 1,
                        controller: _chatController,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: const Color(0xFFFE3C72),
                        decoration: const InputDecoration(
                          fillColor: Color.fromARGB(255, 19, 21, 23),
                          filled: true,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          hintText: "Message",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: sendMessage,
                      icon: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                                colors: [
                                  Colors.orange,
                                  Colors.pink,
                                  Colors.red
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                stops: [0, 0.5, 0.7]),
                          ),
                          padding: const EdgeInsets.all(2),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              IconData(
                                0xe571,
                                fontFamily: 'MaterialIcons',
                                matchTextDirection: true,
                              ),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.child,
  });

  final Message message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final messageAlignment =
        message.isMine ? Alignment.topLeft : Alignment.topRight;

    return FractionallySizedBox(
      alignment: messageAlignment,
      widthFactor: 0.8,
      child: Align(
        alignment: messageAlignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            child: BubbleBackground(
              colors: [
                if (message.isMine) ...const [
                  Color(0xFF6C7689),
                  Color(0xFF3A364B),
                ] else ...const [
                  Color(0xFF19B7FF),
                  Color(0xFF491CCB),
                ],
              ],
              child: DefaultTextStyle.merge(
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        child,
                        const Text(
                          "Today",
                          style:
                              TextStyle(fontSize: 10, color: Colors.blueGrey),
                        )
                      ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class BubbleBackground extends StatelessWidget {
  const BubbleBackground({
    super.key,
    required this.colors,
    this.child,
  });

  final List<Color> colors;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(
        scrollable: Scrollable.of(context),
        bubbleContext: context,
        colors: colors,
      ),
      child: child,
    );
  }
}

class BubblePainter extends CustomPainter {
  BubblePainter({
    required ScrollableState scrollable,
    required BuildContext bubbleContext,
    required List<Color> colors,
  })  : _scrollable = scrollable,
        _bubbleContext = bubbleContext,
        _colors = colors,
        super(repaint: scrollable.position);

  final ScrollableState _scrollable;
  final BuildContext _bubbleContext;
  final List<Color> _colors;

  @override
  void paint(Canvas canvas, Size size) {
    final scrollableBox = _scrollable.context.findRenderObject() as RenderBox;
    final scrollableRect = Offset.zero & scrollableBox.size;
    final bubbleBox = _bubbleContext.findRenderObject() as RenderBox;

    final origin =
        bubbleBox.localToGlobal(Offset.zero, ancestor: scrollableBox);
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        scrollableRect.topCenter,
        scrollableRect.bottomCenter,
        _colors,
        [0.0, 1.0],
        TileMode.clamp,
        Matrix4.translationValues(-origin.dx, -origin.dy, 0.0).storage,
      );
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) {
    return oldDelegate._scrollable != _scrollable ||
        oldDelegate._bubbleContext != _bubbleContext ||
        oldDelegate._colors != _colors;
  }
}

enum MessageOwner { myself, other }

@immutable
class Message {
  const Message({
    required this.owner,
    required this.text,
  });

  final MessageOwner owner;
  final String text;

  bool get isMine => owner != MessageOwner.myself;
}
