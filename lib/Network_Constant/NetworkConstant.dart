class NetworkConstants {

    /// this https://dev5.thestaffer.com/api is the basee url for the wholle app api callls
  static const String BASE_URL = "https://dev5.thestaffer.com/api/";

  /// this /login is an endpoiint
  static const String LOGIN = "login";

  /// this /home is an endpoiint
  static const String HOME = "admin/home";

    /// this /formate is an endpoiint
      static const String FORMATE ='admin/get-general-setting-and-profile-data';

  /// https://dev5.thestaffer.com/api/admin/employee/assignment/all-assignments
  static const String ASSIGNMENTS = "admin/employee/assignment/all-assignments";

    /// this is details endpints;
    static const String DETAILS ='admin/employee/assignment/detail/';
 
  ///end point of timesheet api
    static const String TIMESHEET ='admin/employee/timesheet/list';

  ///end point of profile api
    static const String PROFILE ='admin/get-profile-data';
  ///for changing the password in profile
      static const String CHANGEPASSWORD ='reset-password';

}
