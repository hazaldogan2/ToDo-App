import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/widgets/auxiliary/login.dart';
import 'package:todo/widgets/auxiliary/sign_up.dart';

import 'firebase_options.dart';


Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUp()));

}
