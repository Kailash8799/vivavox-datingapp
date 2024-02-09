// import 'dart:async';
// import 'dart:developer';

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import './agoravideo.dart';

// class CallScreen extends StatefulWidget {
//   const CallScreen({super.key});

//   @override
//   State<CallScreen> createState() => _CallScreenState();
// }

// class _CallScreenState extends State<CallScreen> {
//   final _channelController = TextEditingController();
//   bool _validateError = false;
//   ClientRoleType? _role = ClientRoleType.clientRoleBroadcaster;

//   @override
//   void dispose() {
//     _channelController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             Image.network("https://tinyurl.com/2p889y4k"),
//             const SizedBox(height: 20),
//             TextField(
//               controller: _channelController,
//               decoration: InputDecoration(
//                 errorText: _validateError ? "Required" : null,
//                 border: const UnderlineInputBorder(
//                   borderSide: BorderSide(width: 1),
//                 ),
//               ),
//             ),
//             RadioListTile(
//               value: ClientRoleType.clientRoleBroadcaster,
//               groupValue: _role,
//               onChanged: (ClientRoleType? value) {
//                 setState(() {
//                   _role = value;
//                 });
//               },
//             ),
//             RadioListTile(
//               value: ClientRoleType.clientRoleAudience,
//               groupValue: _role,
//               onChanged: (ClientRoleType? value) {
//                 setState(() {
//                   _role = value;
//                 });
//               },
//             ),
//             ElevatedButton(onPressed: onJoin, child: Text("Join"))
//           ],
//         ),
//       ),
//     ));
//   }

//   Future<void> onJoin() async {
//     setState(() {
//       _channelController.text.isEmpty
//           ? _validateError = true
//           : _validateError = false;
//     });
//     if (_channelController.text.isNotEmpty) {
//       await _handleCameraAndMic(Permission.camera);
//       await _handleCameraAndMic(Permission.microphone);
//       if (!context.mounted) return;
//       await Navigator.push(context, MaterialPageRoute(
//         builder: (context) {
//           return const VideoCallScreen();
//         },
//       ));
//     }
//   }

//   Future<void> _handleCameraAndMic(Permission per) async {
//     final val = await per.request();
//     if (val == PermissionStatus.denied) {
//       return;
//     }
//   }
// }
