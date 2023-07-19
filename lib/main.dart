import 'package:flutter/material.dart';
import './style.dart' as style;
import 'package:provider/provider.dart';
import './store/global_store.dart';
import './store/second_store.dart';
import 'screens/home_screen.dart';

void main() {
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
