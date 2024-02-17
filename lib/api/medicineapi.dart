import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medbox/service/authservice.dart';
import 'package:medbox/service/userservice.dart';

Future<int> addMedicine(medicine, context) async {
  try {
    var accessToken = AuthService.accessToken;
    var id = User.id!;
    final response = await http.post(
      Uri.parse('https://medimate-lwso.onrender.com/api/user/addMedicine'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'newMedicine': medicine,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      dynamic user = {
        "name": responseData['name'],
        "_id": responseData['_id'],
        "email": responseData['email'],
        "medicine": responseData['medicine']
      };

      int gotData = User.updateData(user);
      if (gotData == 200) {
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

Future<int> removeMedicine(medId, context) async {
  try {
    var accessToken = AuthService.accessToken;
    var id = User.id!;
    final response = await http.post(
      Uri.parse('https://medimate-lwso.onrender.com/api/user/removeMedicine'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'medId': medId,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      dynamic user = {
        "name": responseData['name'],
        "_id": responseData['_id'],
        "email": responseData['email'],
        "medicine": responseData['medicine']
      };

      int gotData = User.updateData(user);
      if (gotData == 200) {
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

Future<int> updateMedicine(medId, medicine, context) async {
  try {
    var accessToken = AuthService.accessToken;
    var id = User.id!;
    final response = await http.post(
      Uri.parse('https://medimate-lwso.onrender.com/api/user/updateMedicine'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $accessToken'
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
        'medId': medId,
        'updatedMedValue': medicine
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      dynamic user = {
        "name": responseData['name'],
        "_id": responseData['_id'],
        "email": responseData['email'],
        "medicine": responseData['medicine']
      };

      int gotData = User.updateData(user);
      if (gotData == 200) {
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
