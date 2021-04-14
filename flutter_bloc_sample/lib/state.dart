import 'package:flutter_bloc_sample/data.dart';

abstract class DataState {
  const DataState();
  
  @override
  List<Object> get props => [];
}

class DataInit extends DataState {}

class DataFail extends DataState {}

class DataSuccess extends DataState {
  final List<UserData> data;

  const DataSuccess({
    this.data
  });


}