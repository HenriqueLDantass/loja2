import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trocapc/core/config/config_api.dart';

final Dio dio = Dio();

class RegistroStore extends ChangeNotifier {
  Future registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final String url = "${ConfigApi.globalUrl}/api/user";

    try {
      final response = await dio.post(
        url,
        data: {
          "name": name,
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        print("Registrado com sucesso!");
        print(response.data);
      } else {
        print("Erro durante o registro. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro durante o registro: $e");
    }
  }

  Future<void> login({required String email, required String password}) async {
    final String url = "${ConfigApi.globalUrl}/api/login";
    print(url);
    try {
      final response = await dio.post(
        url,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        print("usuario encontrado");

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', response.data['token']);
        printToken();
      }
    } catch (e) {
      print("usuario nao encontrado");
    }
  }

  Future<void> printToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    print('Token armazenado no SharedPreferences: $token');
  }
}
