import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  const Upload({
    required this.userImage,
    required this.setUserContent,
    required this.addMyData,
    super.key,
  });
  final dynamic userImage;
  final Function setUserContent;
  final Function addMyData;

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  // 유저 정보? 가져온 데이터 형식과 완전히 일치해야 한다?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              // MaterialApp 컨텍스트가 있으면됨
              Navigator.pop(context);
            },
          ),
          IconButton(
            onPressed: () {
              widget.addMyData();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.upload),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(widget.userImage),
          TextField(
            onChanged: (value) {
              widget.setUserContent(value);
            },
          ),
        ],
      ),
    );
  }
}
