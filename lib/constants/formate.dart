
// Future<FormateApi> fetchformate() async {
//   final s.FlutterSecureStorage storage = new s.FlutterSecureStorage();
//   final String? token = await storage.read(key: 'token');
//   //  UserRepository request = UserRepository();

//    var mainUrl = "https://dev5.thestaffer.com/api/";
//   final url =mainUrl +'admin/get-general-setting-and-profile-data';

//   print('dddddddddddddddddddd$token');
//   String? authorization = token;
//   print('sssssssssssssssssssss$authorization');
//   var request = await http.Request('GET',Uri.parse(url));
//    request.headers.addAll({
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//     'Authorization': 'Bearer $authorization'
//   });
//   print('Token : ${authorization}');
//   // print('aaaaaaaaaaaaaaaaaaaaaaaaa${request.statusCode}');
//   http.StreamedResponse response = await request.send();
//   if (response.statusCode == 200) {
//      print(await response.stream.bytesToString());
//     print('ccccccccccccccccccc${request.body}');
//     print('vvvvvvvvvvvvvvvvvvv${jsonDecode(request.body)}');
//     print(response.statusCode);
//     return FormateApi.fromJson(jsonDecode(request.body));
//   } else {
//     // Throw an exception or return a default Profile in case of an error
//     throw Exception('Failed to fetch formate : ${response.reasonPhrase}');
//   }
// }

class FormatModel {
 late List<Data> data;

  FormatModel({required this.data});

  FormatModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
 late String empName;
 late String empEmail;
 late String currentDateFormat;
 late String currencyformat;

  Data(
      {required this.empName,
      required this.empEmail,
  
      required this.currentDateFormat,
      required this.currencyformat});

  Data.fromJson(Map<String, dynamic> json) {
    empName = json['emp_name'];
    empEmail = json['emp_email'];
   
    currentDateFormat = json['current_date_format'];
    currencyformat = json['currencyformat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emp_name'] = this.empName;
    data['emp_email'] = this.empEmail;
  
    data['current_date_format'] = this.currentDateFormat;
    data['currencyformat'] = this.currencyformat;
    return data;
  }
}
