import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todowoo/cubits/app_cubit.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDoWoo'),
        actions: [
          TextButton(
            child: const Text(
              'Log out',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            onPressed: context.read<AppCubit>().unAuthenticate,
          ),
        ],
      ),
    );
  }
}
