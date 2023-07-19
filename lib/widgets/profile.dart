import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/global_store.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var images;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Store1>().getData();
  }

  @override
  Widget build(BuildContext context) {
    print("images ${context.watch<Store1>().profileImage}");
    return Scaffold(
      appBar: AppBar(title: Text(context.watch<Store1>().name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                ),
                Text("팔로워 ${context.watch<Store1>().follower}명"),
                ElevatedButton(
                  onPressed: () {
                    context.read<Store1>().changeFollowState();
                  },
                  child: const Text('팔로우'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
