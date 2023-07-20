import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Store1 extends ChangeNotifier {
  var name = "john kim";
  var follower = 0;
  var isFollwed = false;
  var profileImage = [];

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var result2 = jsonDecode(result.body);
    profileImage = result2;
    print(profileImage);
    notifyListeners();
  }

  changeName() {
    name = 'John Park';
    notifyListeners(); // 리렌더링해줘
  }

  changeFollowState() {
    isFollwed ? follower-- : follower++;
    isFollwed = !isFollwed;
    notifyListeners();
  }
}
