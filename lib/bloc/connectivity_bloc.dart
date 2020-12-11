import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectivityEvent { on, off }

class ConnectivityBloc extends Bloc<ConnectivityEvent, bool> {
  ConnectivityBloc() : super(true);

  @override
  Stream<bool> mapEventToState(ConnectivityEvent event) async* {
    switch (event) {
      case ConnectivityEvent.on:
        yield true;
        break;
      case ConnectivityEvent.off:
        yield false;
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }
}
