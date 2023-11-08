import 'package:beatz_player/presentation/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
Future<void> requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
  ].request();
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}