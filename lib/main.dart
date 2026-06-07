import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexo_app/core/theme/app_theme.dart';
import 'package:nexo_app/feature/login/bloc/bloc/login_bloc.dart';
import 'package:nexo_app/feature/login/repo/login_repo.dart';
import 'package:nexo_app/feature/login/ui/login_screen.dart';
import 'package:nexo_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final loginRepository = LoginRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              LoginBloc(loginRepository: loginRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nexo Finance App',
      theme: AppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}
