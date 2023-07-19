import 'package:flutter/material.dart';
import 'package:instagram/widgets/Upload.dart';

class UploadScreen extends StatelessWidget {
  final dynamic userImage;
  final Function setUserContent;
  final Function addMyData;

  const UploadScreen({
    required this.userImage,
    required this.setUserContent,
    required this.addMyData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Upload(
      userImage: userImage,
      setUserContent: setUserContent,
      addMyData: addMyData,
    );
  }
}
