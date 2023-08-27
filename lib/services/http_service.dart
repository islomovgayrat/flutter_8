import 'dart:convert';

import 'package:flutter_8/services/logger.dart';
import 'package:http/http.dart';

import '../ models/post_model.dart';

class Network {
  static String BASE = "jsonplaceholder.typicode.com";
  static Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
  };

  //REQUESTS
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    LogService.i('Api $BASE$api');
    LogService.d('Params $params');
    LogService.w('Response ${response.body}');
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    LogService.i('Api $BASE$api');
    LogService.d('Params $params');
    LogService.w('Response ${response.body}');
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    LogService.i('Api $BASE$api');
    LogService.d('Params $params');
    LogService.w('Response ${response.body}');
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DEL(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await delete(uri, headers: headers);
    LogService.i('Api $BASE$api');
    LogService.d('Params $params');
    LogService.w('Response ${response.body}');
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  //APIS
  static String API_POST = '/posts';
  static String API_CREATE = '/posts';
  static String API_UPDATE = '/posts/'; //ID
  static String API_DELETE = '/posts/'; //ID

  //PARAMS
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsCreate(Post post) {
    Map<String, String> params = {};
    params.addAll({
      'title': post.title.toString(),
      'body': post.body.toString(),
      'userId': post.userId.toString(),
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Post post) {
    Map<String, String> params = {};
    params.addAll({
      'id': post.id.toString(),
      'title': post.title.toString(),
      'body': post.body.toString(),
      'userId': post.userId.toString(),
    });
    return params;
  }

  //Http parsing
  static List<Post> parsePostList(String response) {
    dynamic json = jsonDecode(response);
    var data = List<Post>.from(json.map((x) => Post.fromJson(x)));
    return data;
  }
}
