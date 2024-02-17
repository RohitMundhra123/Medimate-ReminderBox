import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset("assets/logos/profile.png"),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "We Are Working On It !!!!",
            style: TextStyle(color: Colors.white, fontSize: 24),
          )
        ],
      ),
    );
  }
}
