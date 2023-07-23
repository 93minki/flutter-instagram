import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

final fireStore = FirebaseFirestore.instance;

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  getData() async {
    try {
      var result = await fireStore.collection('product').get();
      for (var doc in result.docs) {
        print(doc['name']);
      }
    } catch (e) {
      print("error $e");
    }
  }

  signUp() async {
    try {
      var result = await auth.createUserWithEmailAndPassword(
        email: "johnKim@test.com",
        password: "123123",
      );
      result.user?.updateDisplayName('john');
      print(result.user);
    } catch (e) {
      print("signUp Error $e");
    }
  }

  signIn() async {
    try {
      var result = await auth.signInWithEmailAndPassword(
        email: "kim@test.com",
        password: "123123",
      );
    } catch (e) {
      print("signIn Error $e");
    }

    if (auth.currentUser?.uid == null) {
      print("로그인 안된 상태");
    } else {
      print("로그인 하셨군요");
    }
  }

  isLoggedIn() async {
    if (auth.currentUser?.uid == null) {
      print("로그인 안한 상태");
    } else {
      print("로그인 상태!!!");
    }
  }

  addData() async {
    try {
      var result = await fireStore
          .collection('product')
          .add({'name': '내복', 'price': 5000});
      print(result);
    } catch (e) {
      print("add Error $e");
    }
  }

  logOut() async {
    await auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    // await 키워드를 쓸 수 없음 여기안에서
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            child: const Text("회원가입"),
            onPressed: () {
              signIn();
            },
          ),
          ElevatedButton(
            child: const Text("로그인"),
            onPressed: () {
              signIn();
            },
          ),
          ElevatedButton(
            child: const Text("로그인 했나"),
            onPressed: () {
              isLoggedIn();
            },
          ),
          ElevatedButton(
            child: const Text("로그아웃"),
            onPressed: () {
              logOut();
            },
          ),
          ElevatedButton(
            child: const Text("데이터 가져오기"),
            onPressed: () {
              getData();
            },
          ),
        ],
      ),
    );
  }
}
