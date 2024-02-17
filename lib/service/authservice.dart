import 'dart:convert';
import 'package:medbox/screens/authscreen/signup.dart';
import 'package:medbox/service/userservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AuthService {
  static SharedPreferences? _prefs;
  static String? accessToken;
  static Map<String, dynamic>? user;
  static VoidCallback? onLogout;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    accessToken = _prefs!.getString('accessToken');
    bool feed = await User.loadCandidateDataFromSharedPref();
    if (!feed) {
      if (onLogout != null) {
        onLogout!();
      }
    }
  }

  static Future<void> setTokens(String newAccessToken) async {
    accessToken = newAccessToken;
    _prefs!.setString('accessToken', newAccessToken);
  }

  static Future<bool> setUser(dynamic newUser) async {
    user = newUser;
    _prefs!.setString('user', json.encode(user));
    int? response = User.updateData(user!);
    if (response != 200) {
      const SignUpPage();
      return false;
    } else {
      return true;
    }
  }

  static void logout() {
    accessToken = null;
    user = null;
    _prefs!.remove('accessToken');
    _prefs!.remove('user');
    User.reset();
  }
}
