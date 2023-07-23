import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:provider/provider.dart';
import './store/global_store.dart';
import './store/second_store.dart';
import 'screens/home_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Store1()),
        ChangeNotifierProvider(create: (context) => Store2()),
      ],
      child: MaterialApp(
        theme: style.theme,
        home: const Home(),
      ),
    ),
  );
}
