import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todowoo/cubits/app_cubit.dart';
import 'package:todowoo/cubits/auth/auth_cubit.dart';
import 'package:todowoo/screens/gathering_text_form.dart';
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthTextForm(
                      title: 'Email',
                      hints: 'Please input Email',
                      enable: state is! AuthLoading,
                      onChanged: (email) =>
                          context.read<AuthCubit>().model.username = email,
                    ),
                    const SizedBox(height: 20),
                    AuthTextForm(
                      title: 'Password',
                      hints: 'Please input password',
                      enable: state is! AuthLoading,
                      onChanged: (password) =>
                          context.read<AuthCubit>().model.password = password,
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: context.read<AuthCubit>().login,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
