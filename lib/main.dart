import 'package:coupinos_project/model/login_data/login_repository.dart';
import 'package:coupinos_project/model/post_get_data/post_get_repository.dart';
import 'package:coupinos_project/views/splash/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controller/login_bloc/login_bloc.dart';
import 'controller/post_get_bloc/post_get_bloc.dart';

void main(){
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => LoginBloc(repository: CoupinosLogin())),
    ],
       child:BlocProvider(create: (context) => PostGetBloc(repository: PostGetFetch()),
         child: DevicePreview(builder: (BuildContext context) => MyApp(),
            ),
       )
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      );
  }
}
