import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:instagram/screens/profile_screen.dart';

class ArticleList extends StatefulWidget {
  final List<dynamic> items;
  final Function addItem;
  const ArticleList({required this.items, required this.addItem, super.key});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  getMore() async {
    var result = await http
        .get(Uri.parse("https://codingapple1.github.io/app/more1.json"));

    if (result.statusCode == 200) {
      var result2 = jsonDecode(result.body);
      widget.addItem(result2);
    }
  }

  @override
  void initState() {
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getMore();
      }
    });
  }

  var scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    if (widget.items.isNotEmpty) {
      return ListView.builder(
        controller: scroll,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              // widget.items[index]['image'].runtimeType == String // File 런타임에서 타입을 가져올 수 있다고하넹
              widget.items[index]['image'].toString().startsWith("http")
                  ? Image.network(widget.items[index]['image'])
                  : Image.file(widget.items[index]['image']),
              Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Text(widget.items[index]['user']),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (c, a1, a2) => const ProfileScreen(),
                            transitionsBuilder: (context, a1, a2, child) =>
                                FadeTransition(opacity: a1, child: child),
                            //     SlideTransition(
                            //   position: Tween(
                            //     begin: Offset(-1.0, 0.0),
                            //     end: Offset(0.0, 0.0),
                            //   ).animate(a1),
                            //   child: child,
                            // ),
                            transitionDuration:
                                const Duration(milliseconds: 100),
                          ),
                        );
                      },
                    ),
                    Text("좋아요 ${widget.items[index]['likes']}"),
                    Text("글쓴이 ${widget.items[index]['user']}"),
                    Text("${widget.items[index]['content']}"),
                  ],
                ),
              )
            ],
          );
        },
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
