import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class permissionhandler extends StatefulWidget {
  const permissionhandler({super.key});

  @override
  State<permissionhandler> createState() => _permissionhandlerState();
}

class _permissionhandlerState extends State<permissionhandler> {
  @override
  void initState() {
    super.initState();
    requestAllPermissions();
  }

  Future<void> requestAllPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.storage,
      Permission.sms,
    ].request();
    handlePermissions(statuses);
  }

  void handlePermissions(Map<Permission, PermissionStatus> statuses) {
    bool allGuranted = statuses.values.every((statuses) => statuses.isGranted);
    if (allGuranted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Mainscreen()));
    }
    if (!allGuranted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Permissions Required'),
          content: Text('Please grant all the permissions to proceed.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                requestAllPermissions();
              },
              child: Text('Retry'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Exit'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permission Demo'),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    openAppSettings();
                  },
                  child: Text("To grant all the permissions click here")),
            )
          ],
        ),
      ),
      // body: Center(
      //   child: CircularProgressIndicator(),
      // ),
    );
  }
}

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Welcome to the Main Screen'),
      ),
    );
  }
}
