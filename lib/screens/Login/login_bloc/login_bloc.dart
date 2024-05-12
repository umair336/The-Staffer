
import 'dart:convert';
import 'package:TheStafferEmployee/screens/Login/Repository/Login_API_call.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login_event.dart';
part 'login_state.dart';

class   LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc():super(LoginInitial()) {
    on<LoginEvent>((loginstate));
  }

  Future<void> loginstate(LoginEvent event, Emitter<LoginState>emit) async{
  if (event is LoginButtonPressed){
    emit(LoginLoadingState());
    try{
      var loginResponse= await NetworkCalls.login(
       email: event.email,
       password: event.password);
       if(loginResponse.statusCode==200){
        var loginjson= jsonDecode(loginResponse.body);
        if(loginjson["token"]!= null){

          SharedPreferences p = await SharedPreferences.getInstance();
          var token = await p.setString('token',loginjson['token']);

          emit(LoginSuccessState());
        }
        else{
          print('your token is not correct');
          emit(LoginFailureState(error: 'status code is not 200'));
        }
       }
    }catch(e){
      print(e.toString());
      emit(LoginFailureState(error: e.toString()));
    }
  }
}  
}
