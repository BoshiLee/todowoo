part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class AuthLoaded extends AuthState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class AuthSuccess extends AuthState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class AuthErrorOccurred extends AuthState {
  final String errorMessage;

  const AuthErrorOccurred({required this.errorMessage});

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}
