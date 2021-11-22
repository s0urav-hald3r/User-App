import 'package:flutter/material.dart';

class UserDetail extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final user;

  const UserDetail({Key? key, @required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user["first_name"]),
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 125.0,
              backgroundImage: NetworkImage(
                user["avatar"],
              ),
            ),
            const SizedBox(
              height: 100.0,
            ),
            Text(
              "${user["first_name"]} ${user["last_name"]}",
              style: const TextStyle(
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Text(
              "${user["email"]}",
              style: const TextStyle(
                fontSize: 24,
              ),
            )
          ],
        ),
      ),
    );
  }
}
