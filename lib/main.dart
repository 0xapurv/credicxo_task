import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:credicxo_task/bloc/connectivity_bloc.dart';
import 'package:credicxo_task/bloc/observer_bloc.dart';
import 'package:credicxo_task/bloc/loading_bloc.dart';
import 'package:credicxo_task/pages/music_list.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:credicxo_task/models/music_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  initHive();

  runApp(MyApp());
}
void initHive() async{
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(MusicModelAdapter());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Credicxo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:MultiBlocProvider(
        providers: [
          BlocProvider(
          create: (_) => ConnectivityBloc(),
          ),
          BlocProvider(
          create: (_) => LoadingBloc(),),
        ],
        child: MusicList(),
      ),
    );
  }
}

