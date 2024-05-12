import 'dart:developer';

import 'package:TheStafferEmployee/Network_Constant/NetworkConstant.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as h;


class HomeNetworkCalls{

//////for home
  static Future<h.Response> homeData(String token)async{
   var request = h.Request('GET', Uri.parse(NetworkConstants.BASE_URL+NetworkConstants.HOME));

request.headers.addAll({
  'Authorization': 'Bearer $token',
});
log(token, name: 'TOKEN INSIDE HOMEDATA');
log(request.headers.toString(),name: 'Headers of HOMEDATA');

h.StreamedResponse response = await request.send();
var b =await h.Response.fromStream(response);
log(b.body.toString(),name: 'BODY INSIDE HOMEDATA');
return b;
  }

  ////////////// for formate
 
 static Future<h.Response> formate(String token)async{
   var request = h.Request('GET', Uri.parse(NetworkConstants.BASE_URL+NetworkConstants.FORMATE));

request.headers.addAll({
   'Authorization': 'Bearer $token',
});

h.StreamedResponse response = await request.send();
var c =await h.Response.fromStream(response);
return c;
  }

}
