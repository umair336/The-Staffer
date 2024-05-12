import 'package:TheStafferEmployee/Network_Constant/NetworkConstant.dart';
import 'package:http/http.dart' as h;



class NetworkCalls{
  static Future<h.Response> login(
    {
      required String email,
      required String password,
    }
  )async{
   var request = h.Request('POST', Uri.parse(NetworkConstants.BASE_URL+NetworkConstants.LOGIN));
   ///this is the body's form data 
request.bodyFields ={
  'email':email,
  'password':password,
};
request.headers.addAll({
  'Accept': 'application/json',
});

h.StreamedResponse response = await request.send();
var a =await h.Response.fromStream(response);
return a;
  }
}

