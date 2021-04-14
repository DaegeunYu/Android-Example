import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_sample/data.dart';
import 'package:flutter_bloc_sample/event.dart';
import 'package:flutter_bloc_sample/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

class MyBloc extends Bloc<DataEvent, DataState> {
  MyBloc() : super(DataInit());

  Stream<Transition<DataEvent, DataState>> transformEvents(
      Stream<DataEvent> events, transitionFn) {
    return events.debounceTime(const Duration(milliseconds: 500)).switchMap((transitionFn));
  }

  Future<List<UserData>> loadData() async {
    List<UserData> data = [];
    UserData buf;
    String dataUrl = "https://raw.githubusercontent.com/Derrick-08/JsonFiles/main/example.json";
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'De0rr8ic0k8'
    };
    http.Response response = await http.get(dataUrl, headers:requestHeaders);
    // http.Response response = await http.post(dataUrl, body:data headers:requestHeaders);
    List<dynamic> typ = json.decode(response.body);

    for(int i = 0; i < typ.length; i++) {
      buf = new UserData();
      buf.name   = typ[i]["name"];
      buf.family = typ[i]["family"];
      buf.age    = typ[i]["age"];
      buf.weight = typ[i]["weight"];
      data.add(buf);
      buf = null;
    }

    return data;
  }

  Stream<DataState> mapEventToState(DataEvent event) async* {
    final currentState = state;

    if (event is DataFetched) {
      try {
        if (currentState is DataInit) {
          final data = await loadData();
          yield DataSuccess(data: data);
        } else if (currentState is DataSuccess) {
          final data = await loadData();
        }
      } catch (e) {
        print(e.toString());
        yield DataFail();
      }
    } else if (event is DataRefresh) {
      yield DataInit();
      this.add(DataFetched());
    }
  }

}