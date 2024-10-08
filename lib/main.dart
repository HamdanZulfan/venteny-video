import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/video_bloc.dart';
import 'repositories/video_repository.dart';
import 'screens/video_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => VideoBloc(
          VideoRepository(),
        ),
        child: const VideoScreen(),
      ),
    );
  }
}
