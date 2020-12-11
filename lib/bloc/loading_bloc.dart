import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LoadingEvent { on, off }

class LoadingBloc extends Bloc<LoadingEvent, bool> {
  /// {@macro Loading_bloc}
  LoadingBloc() : super(true);

  @override
  Stream<bool> mapEventToState(LoadingEvent event) async* {
    switch (event) {
      case LoadingEvent.on:
        yield true;
        break;
      case LoadingEvent.off:
        yield false;
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }
}
