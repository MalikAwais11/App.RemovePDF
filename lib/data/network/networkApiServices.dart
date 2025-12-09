import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:deletepdfpage/res/appUrls/appUrls.dart';
import 'package:http/http.dart' as http;

import '../appExceptions.dart';
import 'baseApiServices.dart';
class NetworkApiServices extends BaseApiServices{

  @override
  Future<dynamic> getApi(String url) async {

    dynamic jsonResponse;
    try {
      final response = await http.get(Uri.parse(url),
          headers: {"_token" : AppUrls.token,});

      jsonResponse = returnResponse(response);
     } on SocketException{
      throw InternetExceptions("");
    } on RequestTimeOutException{
      throw RequestTimeOutException("");
    }
    return jsonResponse;
  }

  @override

  dynamic returnResponse(http.Response response){

    switch(response.statusCode){
      case 200:
        dynamic res = jsonDecode(response.body);
        return res;
      case 500:
        throw ServerErrorException("");

      case 400:
        throw UrlNotFoundException("");
      default:
        throw ServerErrorException("");
    }


  }
}