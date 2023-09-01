import 'package:coupinos_project/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'controller/post_get_bloc/post_get_bloc.dart';
import 'model/post_get_data/post_get_repository.dart';

void main(){
  runApp(BlocProvider(create: (context) => PostGetBloc(repository: PostGetFetch()),
     child: const MyApp(),
  )
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
