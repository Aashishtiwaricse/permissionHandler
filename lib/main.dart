import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:permissionhandler/home.dart';
import 'package:permissionhandler/new.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // requestPermissions();
  runApp(const MyApp());
}

// void requestPermissions() async {
//   await Permission.camera.request();
//   await Permission.location.request();
//   await Permission.sms.request();
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const permissionhandler(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<Permission, PermissionStatus> _permissionStatus = {};
  List<Permission> requiredPermissions = [
    Permission.camera,
    Permission.location,
    Permission.sms,
    Permission.storage
    // Add other required permissions
  ];

  String status = " ";
  String location = " ";
  String sms = " ";
  String storage = " ";

  @override
  void initState() {
    super.initState();
    checkPermissionsAndNavigate();

    // checkCameraPermissionStatus();
  }

  Future<void> checkPermissionsAndNavigate() async {
    bool allGranted = true;

    for (var permission in requiredPermissions) {
      if (await permission.status != PermissionStatus.granted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("allow all the permissions")));
        allGranted = false;
        break;
      }
    }

    if (allGranted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Nextpage()),
      );
    }
  }

  // void onPressed() {
  //   if (status == PermissionStatus.granted &&
  //       location == PermissionStatus.granted &&
  //       sms == PermissionStatus.granted &&
  //       storage == PermissionStatus.granted) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const Nextpage()),
  //     );
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("allow all the permissions")));
  //   }
  // }

  // void checkCameraPermissionStatus() async {
  //   PermissionStatus status = await Permission.camera.status;
  //   if (status.isGranted) {
  //     print("Camera Permission Granted");
  //   } else if (status.isDenied) {
  //     print('camera permission is denied');
  //   } else if (status.isPermanentlyDenied) {
  //     print('camera permission is permanently denied');
  //   }
  // }
  // Future<void> requestAllPermissions() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.camera,
  //     Permission.microphone,
  //     Permission.sms,
  //     Permission.bluetooth
  //     // Add other required permissions
  //   ].request();
  //   setState(() {
  //     _permissionStatus = statuses;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Permission handler'),
        ),

        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.camera),
              ),
              onTap: () async {
                PermissionStatus cameraStatus =
                    await Permission.camera.request();

                if (cameraStatus == PermissionStatus.granted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Camera permission guranted")));
                }
                if (cameraStatus == PermissionStatus.denied) {
                  //Text('This Permission is recommended');

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("You need to provide the camera permission")));
                }
                if (cameraStatus == PermissionStatus.permanentlyDenied) {
                  openAppSettings();
                }
                setState(() {
                  status = cameraStatus.toString();
                });
              },
              title: Text("Camera permission"),
              //subtitle: Text("Status of  Permission: $status")
              subtitle: Text('Camera Permission Status: ${status}'),
            ),
            ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.location_city),
                ),
                onTap: () async {
                  PermissionStatus locationStatus =
                      await Permission.location.request();

                  if (locationStatus == PermissionStatus.granted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("location permission guranted")));
                  }
                  if (locationStatus == PermissionStatus.denied) {
                    Text('This Permission is recommended');
                  }
                  if (locationStatus == PermissionStatus.permanentlyDenied) {
                    openAppSettings();
                  }
                  setState(() {
                    location = locationStatus.toString();
                  });
                },
                title: const Text("location permission"),
                subtitle: Text("Status of  Permission: $location")),
            ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.sms),
                ),
                onTap: () async {
                  PermissionStatus smsStatus = await Permission.sms.request();

                  if (smsStatus == PermissionStatus.granted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Sms permission guranted")));
                  }
                  if (smsStatus == PermissionStatus.denied) {
                    Text('This Permission is recommended');
                  }
                  if (smsStatus == PermissionStatus.permanentlyDenied) {
                    openAppSettings();
                  }
                  setState(() {
                    sms = smsStatus.toString();
                  });
                },
                title: Text("sms permission"),
                subtitle: Text("Status of  Permission: $sms")),
            ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.storage),
                ),
                onTap: () async {
                  PermissionStatus storageStatus =
                      await Permission.storage.request();

                  if (storageStatus == PermissionStatus.granted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("storage permission guranted")));
                  }
                  if (storageStatus == PermissionStatus.denied) {
                    Text('This Permission is recommended');
                  }
                  if (storageStatus == PermissionStatus.permanentlyDenied) {
                    openAppSettings();
                  }
                  setState(() {
                    storage = storageStatus.toString();
                  });
                },
                title: Text("storage permission"),
                subtitle: Text("Status of  Permission: $storage")),
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    checkPermissionsAndNavigate();
                  },
                  child: Text("next screen")),
            )
          ]),
        ),
        // body: Container(
        //   child: Column(
        //     children: [
        //       // Container(
        //       //   child: ElevatedButton(
        //       //       onPressed: () async {
        //       //         var status = await Permission.camera.status;
        //       //         if (status.isGranted) {
        //       //           print('camera permission is granted');
        //       //         } else if (status.isDenied) {
        //       //           print('camera permission is denied');
        //       //         } else if (status.isRestricted) {
        //       //           print('camera is permamently denied');
        //       //         }
        //       //       },
        //       //       child: Text('camera permission')),
        //       // ),
        //       // Container(
        //       //   child: ElevatedButton(
        //       //       onPressed: () async {
        //       //         var status = await Permission.location.status;
        //       //         if (status.isGranted) {
        //       //           print('location permission is granted');
        //       //         } else if (status.isDenied) {
        //       //           print('location permission is denied');
        //       //         } else if (status.isRestricted) {
        //       //           print('location is permamently denied');
        //       //         }
        //       //       },
        //       //       child: Text('location permission')),
        //       // ),
        //       // Container(
        //       //   child: ElevatedButton(
        //       //       onPressed: () async {
        //       //         var status = await Permission.sms.status;
        //       //         if (status.isGranted) {
        //       //           print('sms permission is granted');
        //       //         } else if (status.isDenied) {
        //       //           print('sms permission is denied');
        //       //         } else if (status.isRestricted) {
        //       //           print('sms is permamently denied');
        //       //         }
        //       //       },
        //       //       child: Text('sms permission')),
        //       // ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

class Nextpage extends StatefulWidget {
  const Nextpage({super.key});

  @override
  State<Nextpage> createState() => _NextpageState();
}

class _NextpageState extends State<Nextpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('welcome to pagr'),
      ),
    );
  }
}
