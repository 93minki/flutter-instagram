import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store/global_store.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
