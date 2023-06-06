// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// class PermissionHandlerPage extends StatefulWidget {
//   @override
//   _PermissionHandlerPageState createState() => _PermissionHandlerPageState();
// }

// class _PermissionHandlerPageState extends State<PermissionHandlerPage> {
//   Map<Permission, PermissionStatus> _permissionStatus = {};

//   @override
//   void initState() {
//     super.initState();
//     requestAllPermissions();
//   }

//   Future<void> requestAllPermissions() async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.camera,
//       Permission.microphone,
//       Permission.sms,
//       Permission.bluetooth
//       // Add other required permissions
//     ].request();
//     setState(() {
//       _permissionStatus = statuses;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Permission Handler'),
//       ),
//       body: ListView(
//         children: _permissionStatus.entries.map((entry) {
//           return ListTile(
//             title: Text(
//               entry.key.toString(),
//             ),
//             subtitle: Text(entry.value.toString()),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
