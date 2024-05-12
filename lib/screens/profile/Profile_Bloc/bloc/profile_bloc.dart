import 'dart:convert';
import 'package:TheStafferEmployee/screens/profile/Model/Network_Call/profile_network_call.dart';
import 'package:TheStafferEmployee/screens/profile/Model/changePasswordmodel.dart';
import 'package:TheStafferEmployee/screens/profile/Model/profileApi.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>(profileState);
    on<LogoutButtonPressEvent>(logoutstate);
  }
  Future<void> profileState(
      ProfileEvent event, Emitter<ProfileState> emit) async {
    if (event is GetUserProfileDataEvent) {
      emit(ProfileLoadingState());
      try {
        SharedPreferences p = await SharedPreferences.getInstance();
        var token = await p.getString('token') ?? '';

        var profileresponse = await ProfileNetworkCall.profileData(token);
        if (profileresponse.statusCode == 200) {
          print('profile response status is 200');
          var profileBody = jsonDecode(profileresponse.body);
          print('profile data is $profileBody');
          if (profileBody != null) {
            print('profile body is not null $profileBody');
            ProfileModel profileModel = ProfileModel.fromJson(profileBody);

            // var changePasswordResponse =await ProfileNetworkCall.changePassword(
            //   token,
            //   password: event.password,
            //   newpassword: event.newpassword,
            //   currentpassword: event.confirmpassword,
            // );
            // if (changePasswordResponse.statusCode == 200) {
            //   print('changepassword response status is 200');
            //   var changepasswordjson = jsonDecode(changePasswordResponse.body);
            //   if (changepasswordjson['token'] != null) {

                emit(ProfileLoadedState(
                  profileResponse: profileModel, 
                  // changespasswordResponse: changepasswordjson,
                ));
               
              // else {
              //   emit(ProfileErrorState(
              //       message: 'changepasswordjson token is null' +
              //           changepasswordjson.toString()));
            //   }
            // }
            
          } else {
            emit(ProfileErrorState(
                message: 'profileBody data is null' + profileBody.toString()));
          }
        } else {
          emit(ProfileErrorState(
              message:
                  'the status code of profileresponse is ${profileresponse.statusCode}'));
        }
      } catch (e) {
        emit(ProfileErrorState(message: e.toString()));
      }
    }
  }

  Future<void> logoutstate(
      ProfileEvent event, Emitter<ProfileState> emit) async {
    if (event is LogoutButtonPressEvent) {
      emit(ProfileLogoutState());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('token');
      } catch (e) {
        emit(ProfileErrorState(message: e.toString()));
      }
    }
  }
}
