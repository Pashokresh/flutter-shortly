import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shortly/networking/exceptions.dart';

class ApiBaseHelper {
  final String _baseUrl = 'api.shrtco.de';
  final String _version = "v2/";

  Future<dynamic> get(String url, Map<String, String> parameters) async {
    var responseJson;
    try {
      final uri = Uri.https(_baseUrl, _version + url, parameters);
      print(uri);
      final response = await http.get(uri);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No Internet');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}