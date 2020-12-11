import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum BookMarkEvent { added, neutral, removed }

class BookMarkBloc extends Bloc<BookMarkEvent, BookMarkEvent> {
  BookMarkBloc() : super(BookMarkEvent.neutral);

  @override
  Stream<BookMarkEvent> mapEventToState(BookMarkEvent event) async* {
    yield event;
  }
}
