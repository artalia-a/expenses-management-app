import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/dto/datas.dart';
import 'package:my_app/dto/news.dart';
import 'package:my_app/endpoints/endpoints.dart';
import 'package:my_app/screens/routes/cs_screen.dart'; // Import cs.dart, bukan cs_screen.dart
import 'package:my_app/dto/cs.dart'; // Import DTO Cs
import 'package:my_app/dto/balance.dart';
import 'package:my_app/dto/spending.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_app/utils/constants.dart';
import 'package:my_app/utils/secure_storage_util.dart';

class DataService {
  static Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse(Endpoints.news));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((item) => News.fromJson(item)).toList();
    } else {
      //handle error
      throw Exception('Failed to load news');
    }
  }

  static Future<List<Datas>> fetchDatas() async {
    final response = await http.get(Uri.parse(Endpoints.datas));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Datas.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      // Handle error
      throw Exception('Failed to load data');
    }
  }

  static Future<void> deleteDatas(int id) async {
    final url = Uri.parse('${Endpoints.datas}/$id');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

  static Future<List<Cs>> fetchCustomerService() async {
    final response = await http.get(Uri.parse(Endpoints.cs));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Cs.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load customer service data');
    }
  }

//delete function for customer service
  static Future<void> deleteCutomerService(int idCustomerService) async {
    final url = Uri.parse('${Endpoints.cs}/$idCustomerService');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

  static Future<List<Balance>> fetchBalance() async {
    final response = await http.get(Uri.parse(Endpoints.balance));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Balance.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      //handle error
      throw Exception('Failed to load data');
    }
  }

  //get spending
  static Future<List<Spendings>> fetchSpendings() async {
    final response = await http.get(Uri.parse(Endpoints.spending));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return (data['datas'] as List<dynamic>)
          .map((item) => Spendings.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      //handle error
      throw Exception('Failed to load data');
    }
  }

  static Future<http.Response> sendSpendingData(int spending) async {
    final url = Uri.parse(Endpoints.spending);
    final data = {'spending': spending};

    final response = await http.post(
      url,
      headers: {'Conteent-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }

  //past login with email and password
  static Future<http.Response> sendLoginData(
      String email, String password) async {
    final url = Uri.parse(Endpoints.login);
    final data = {'email': email, 'password': password};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    return response;
  }

  static Future<http.Response> logoutData() async {
    final url = Uri.parse(Endpoints.logout);
    final String? accessToken =
        await SecureStorageUtil.storage.read(key: tokenStoreName);
    debugPrint("logout with $accessToken");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
    );
    return response;
  }
}
