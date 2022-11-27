import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:hydrogen_complian/models/complain_model.dart';
import 'package:hydrogen_complian/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

const String baseUrl = 'http://complain-app.herokuapp.com';

class GeneralHttpRequest {
  String output = '';
  var client = http.Client();

  Future<dynamic> registerUser(
      {required String api, required UserModel object}) async {
    var url = Uri.parse(baseUrl + api);
    var body = json.encode(object.toJson());
    var headers = {'Content-Type': 'application/json'};

    var response = await client.post(url, body: body, headers: headers);
    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      var data = response.statusCode;
      return data;
    }
  }

  Future<dynamic> loginUser(
      {required String name,
      required String secretCode,
      required String api}) async {
    var url = Uri.parse(baseUrl + api);
    var payload = {'username': name, 'password': secretCode};

    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var response = await client.post(url, body: payload, headers: headers);
    if (response.statusCode == 200) {
      var tokendata = jsonDecode(response.body);
    

      return tokendata;
    } else {
      var data = response.body + response.statusCode.toString();
      return data;
    } 
  } 
  // 175162 ali
  // 157641 gone

  getAllComplaintsForUsers(
      {required String? token, required String api}) async {
    var url = Uri.parse(baseUrl + api);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    };
    var response = await client.get(url, headers: headers);
    // print('called' + response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body); 

      return data;
    } else {
      var data = response.body;
      return data;
    }
  }

  Future<dynamic> postComplain(
    BuildContext context, {
    required String? token,
    required String api,
    required ComplainModel complain,
  }) async {
    String output = '';
    final pref = await SharedPreferences.getInstance();
    var url = Uri.parse(baseUrl + api);
    var payLoad = json.encode(complain.toJson());
    var header = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var response = await client.post(url, headers: header, body: payLoad);
    if (response.statusCode == 201) {
      output = 'success';
      print(response.body + '1');
      return response.body;
    } else {
      output = response.statusCode.toString();
      print(response.statusCode.toString() + '2');
    }
  }
}
