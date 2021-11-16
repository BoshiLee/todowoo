import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todowoo/cubits/app_cubit.dart';
import 'package:todowoo/cubits/auth/auth_cubit.dart';
import 'package:todowoo/utils/bs_navigator.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthScreen'),
        actions: [
          TextButton(
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            onPressed: () => BSRouteManager.navigateToRegisterScreen(
              context,
              onRegistered: context.read<AuthCubit>().writeToken,
            ),
          ),
        ],
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.read<AppCubit>().emit(AppAuthenticated());
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 15),
                    ),
                    onPressed: context.read<AuthCubit>().login,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
