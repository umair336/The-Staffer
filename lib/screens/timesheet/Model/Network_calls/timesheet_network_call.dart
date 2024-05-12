
  import 'dart:developer';
  import 'package:TheStafferEmployee/Network_Constant/NetworkConstant.dart';
  import 'package:http/http.dart' as h;

class TimeSheetNetworkCall {
  static Future<h.Response> timesheetData(String token, String startDate, String endDate) async {
    var url = Uri.parse("https://dev5.thestaffer.com/api/admin/employee/timesheet/list?start_date=$startDate&end_date=$endDate");
    var headers = {'Authorization': 'Bearer $token'};
    var response = await h.get(url, headers: headers);

    return response;
  }

    /// for format
    static Future <h.Response> formatData(String token)async{
    var request = h.Request('GET', Uri.parse(NetworkConstants.BASE_URL+NetworkConstants.FORMATE));
  request.headers.addAll({
      'Authorization': 'Bearer $token',
  });
  h.StreamedResponse response = await request.send();
  var b =await h.Response.fromStream(response);
  return b;
    }
    
  }