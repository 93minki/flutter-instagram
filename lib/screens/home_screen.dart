import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/screens/upload_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../widgets/articleList.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // This widget is the root of your application.
  var tab = 0;
  var data = [];
  var userImage;
  var userContent;

  saveData() async {
    var storage = await SharedPreferences.getInstance();
    storage.setString('name', 'john');
    var result = storage.get('name');
    print(result);
    storage.remove('name');

    // Map 자료형 저장하려면 JSON으로 바꿔서 저장해야 한다.
    var map = {'age': 20};
    storage.setString('map', jsonEncode(map));

    // 다시 가져올 때는 jsonDecode를 해야하는데, get으로 가져올경우 에러가 난다.
    // result2의 타입이 Object가 되기 때문에 그냥 get을 쓰는 것보다 getString으로 써야함.
    var result2 = storage.getString('map') ?? '없는데요';
    print(jsonDecode(result2)['age']);
  }

  setUserContent(a) {
    setState(() {
      userContent = a;
    });
  }

  addMyData() {
    var myData = {
      'id': data.length,
      'image': userImage,
      'likes': 5,
      'date': 'July 25',
      'content': userContent,
      'liked': false,
      'user': 'John Kim',
    };
    setState(() {
      data.insert(0, myData);
    });
  }

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var result2 = jsonDecode(result.body);
    setState(() {
      data = result2;
    });
  }

  addItem(var item) {
    setState(() {
      data.add(item);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    saveData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                  userImage = File(image.path);
                });
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadScreen(
                    userImage: userImage,
                    setUserContent: setUserContent,
                    addMyData: addMyData,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.add_box_outlined),
          ),
        ],
        title: const Text("Instagram"),
      ),
      body: ArticleList(items: data, addItem: addItem),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            tab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: "샵"),
        ],
      ),
    );
  }
}
