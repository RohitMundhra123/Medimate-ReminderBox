import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medbox/service/authservice.dart';

Future<int> loginUser(email, password, context) async {
  try {
    final response = await http.post(
      Uri.parse('https://medimate-lwso.onrender.com/api/user/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      String accessToken = responseData['token'];
      dynamic user = {
        "name": responseData['name'],
        "_id": responseData['_id'],
        "email": responseData['email'],
        "gender": responseData['gender'],
        "medicine": responseData['medicine']
      };

      await AuthService.setTokens(accessToken);

      bool gotData = await AuthService.setUser(user);
      if (gotData) {
        return 200;
      }
      return 400;
    } else {
      final Map<String, dynamic> errorData = json.decode(response.body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${errorData['message']}"),
          duration: const Duration(seconds: 2),
        ),
      );
      return 400;
    }
  } catch (e) {
    if (e is SocketException) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No Internet Connection"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          duration: const Duration(seconds: 2),
        ),
      );
    }
    return 400;
  }
}

Future<int> registerUser(name, email, password, gender, context) async {
  try {
    final response = await http.post(
      Uri.parse('https://medimate-lwso.onrender.com/api/user/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'gender': gender,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      String accessToken = responseData['token'];
      dynamic user = {
        "name": responseData['name'],
        "_id": responseData['_id'],
        "email": responseData['email'],
        "gender": responseData['gender'],
        "medicine": responseData['medicine']
      };
      AuthService.setTokens(accessToken);
      bool gotData = await AuthService.setUser(user);
      if (gotData) {
        return 200;
      }
      return 400;
    } else {
      final Map<String, dynamic> errorData = json.decode(response.body);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${errorData['message']}"),
          duration: const Duration(seconds: 2),
        ),
      );
      return 400;
    }
  } catch (e) {
    if (e is SocketException) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No Internet Connection"),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          duration: const Duration(seconds: 2),
        ),
      );
    }
    return 400;
  }
}
