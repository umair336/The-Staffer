import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:TheStafferEmployee/constants/formate.dart';
import 'package:TheStafferEmployee/screens/timesheet/Model/timesheetApi.dart';
import 'package:TheStafferEmployee/screens/timesheet/Model/Network_calls/timesheet_network_call.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'time_sheet_event.dart';
part 'time_sheet_state.dart';

class TimeSheetBloc extends Bloc<TimeSheetEvent, TimeSheetState> {
  TimeSheetBloc() : super(TimeSheetLoadingState()) {
    on<TimeSheetEvent>(_gettimesheetdata);
    // on<GetJobsForDateEvent>(_getJobsForDate);
  }
   
  Future<void> _gettimesheetdata(TimeSheetEvent event,Emitter<TimeSheetState>emit)async{
    if(event is GetTimeSheetDataEvent){
      emit(TimeSheetLoadingState());
      try{
          SharedPreferences p = await SharedPreferences.getInstance();
        var token=await p.getString('token')??'';

        var timesheetresponse= await TimeSheetNetworkCall.timesheetData(token,event.startDate,event.endDate);
        // log(timesheetresponse.body.toString(),name: 'timsheet response');
          if(timesheetresponse.statusCode==200){
          print('timesheetresponse status code is 200');
          
          var timesheetBody=jsonDecode(timesheetresponse.body);
          if(timesheetBody!=null){
            TimeSheetModel timesheetModel=
                       TimeSheetModel.fromJson(timesheetBody);
                                      
            var formatresponse= await TimeSheetNetworkCall.formatData(token);
            // log(formatresponse.body.toString(),name: 'format response');

            if(formatresponse.statusCode==200){
            print('formatresponse status is 200');
              var formatBody=jsonDecode(formatresponse.body);
              if(formatBody!=null){
                   FormatModel formatModel=FormatModel.fromJson(formatBody);
                   
            emit(TimeSheetCompletedState(timesheetResponse: timesheetModel, formateResponse: formatModel));
              }
            }
          }else{
            emit(TimeSheetErrorState(message: 'timesheet body data is null'+ timesheetBody.toString()));
          }
        }else{
          emit(TimeSheetErrorState(message: 'status code of timesheetresponse is ${timesheetresponse.statusCode}'));
        }

      }catch(e){
        emit(TimeSheetErrorState(message: e.toString()));
      }
    }
  }

}
