
import 'package:TheStafferEmployee/Network_Constant/NetworkConstant.dart';
import 'package:http/http.dart'as h;

class ProfileNetworkCall{

  static Future <h.Response> profileData(String token)async{
   var request = h.Request('GET', Uri.parse(NetworkConstants.BASE_URL+NetworkConstants.PROFILE));
   
request.headers.addAll({
    'Authorization': 'Bearer $token',
});

h.StreamedResponse response = await request.send();
var a =await h.Response.fromStream(response);
return a; 
  } 


  static Future <h.Response> changePassword(String token,
   { 
     required String password,
     required String newpassword,
     required String currentpassword,}
     )async{
   var request = h.Request('GET', Uri.parse(NetworkConstants.BASE_URL+NetworkConstants.CHANGEPASSWORD));
   request.bodyFields ={
  'password':password,
  'newpassword' : newpassword, 
  'currentpassword' : currentpassword,
};
request.headers.addAll({
    'Authorization': 'Bearer $token',
});

h.StreamedResponse response = await request.send();
var a =await h.Response.fromStream(response);
return a; 
  } 
}