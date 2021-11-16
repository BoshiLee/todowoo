part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class RegisterLoaded extends RegisterState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class RegisterSuccess extends RegisterState {
  final String jwt;

  RegisterSuccess(this.jwt);

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class RegisterErrorOccurred extends RegisterState {
  final String errorMessage;

  const RegisterErrorOccurred({required this.errorMessage});

  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}
