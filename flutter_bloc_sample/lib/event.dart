abstract class DataEvent {
  @override
  List<Object> get props => [];
}

class DataFetched extends DataEvent {}

class DataRefresh extends DataEvent {}