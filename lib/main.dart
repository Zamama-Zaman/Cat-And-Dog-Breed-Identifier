import 'package:camera/camera.dart';
import 'package:cat_and_dog_breed_identifier/app_const/app_colors.dart';
import 'package:cat_and_dog_breed_identifier/pages/cat_breed/cat_live_stream.dart';
import 'package:cat_and_dog_breed_identifier/pages/cat_breed/cat_local.dart';
import 'package:cat_and_dog_breed_identifier/pages/cat_breed/cat_static_pic.dart';
import 'package:cat_and_dog_breed_identifier/pages/dog_breed/dog_live_stream.dart';
import 'package:cat_and_dog_breed_identifier/pages/dog_breed/dog_local.dart';
import 'package:cat_and_dog_breed_identifier/pages/dog_breed/dog_static_pic.dart';
import 'package:cat_and_dog_breed_identifier/pages/home_page.dart';
import 'package:flutter/material.dart';

List<CameraDescription>? cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
