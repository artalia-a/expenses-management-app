import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/dto/datas.dart';
import 'package:my_app/dto/news.dart';
import 'package:my_app/endpoints/endpoints.dart';
import 'package:my_app/screens/routes/cs_screen.dart'; // Import cs.dart, bukan cs_screen.dart
import 'package:my_app/dto/cs.dart'; // Import DTO Cs

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
}
