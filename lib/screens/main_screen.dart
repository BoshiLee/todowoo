import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todowoo/cubits/app_cubit.dart';
import 'package:todowoo/screens/auth_screen.dart';
import 'package:todowoo/screens/splash_screen.dart';
import 'package:todowoo/screens/todo_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (state is AppAuthenticated) {
          return const ToDoScreen();
        }
        if (state is AppUnauthenticated) {
          return const AuthScreen();
        }
        return const SplashScreen();
      },
    );
  }
}
