import 'dart:developer';
import 'package:TheStafferEmployee/Network_Constant/NetworkConstant.dart';
import 'package:http/http.dart' as h;


class AssignmentNetworkCalls{

      /// Assignment network call
  static Future<h.Response> assignmentData(String token)async{
  var request = h.Request('GET', Uri.parse(NetworkConstants.BASE_URL+NetworkConstants.ASSIGNMENTS));

request.headers.addAll({
  'Authorization': 'Bearer $token',
});
log(token, name: 'TOKEN INSIDE HOMEDATA');
log(request.headers.toString(),name: 'Headers of HOMEDATA');

h.StreamedResponse response = await request.send();
var a =await h.Response.fromStream(response);
log(a.body.toString(),name: 'BODY INSIDE ASSIGNMENTDATA');
return a;
  }

    /// format network call
  static Future<h.Response> formate(String token)async{
  var request = h.Request('GET', Uri.parse(NetworkConstants.BASE_URL+NetworkConstants.FORMATE));

request.headers.addAll({
  'Authorization': 'Bearer $token',
});
h.StreamedResponse response = await request.send();
var b =await h.Response.fromStream(response);
return b;
  }

    ///Assignment Detail network call
   static Future<h.Response> detail(String token,int jobId)async{
    var url = '${NetworkConstants.BASE_URL}admin/employee/assignment/detail/$jobId';
    log(url,name: 'url of detail');
   var request = h.Request('GET', Uri.parse(url));

request.headers.addAll({
  'Authorization': 'Bearer $token',
});
log(token,name: 'token inside assignmentbody');
log(request.headers.toString(),name: 'header of assignment details');
h.StreamedResponse response = await request.send();
var b =await h.Response.fromStream(response);

log(b.body.toString(),name: 'BODY INSIDE ASSIGNMENTDetailsDATA');
return b;
  }
}
