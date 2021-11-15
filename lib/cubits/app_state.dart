part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();
}

class AppInitial extends AppState {
  @override
  List<Object> get props => [];
}

class AppUninitialized extends AppState {
  @override
  List<Object> get props => [];
}

class AppAuthenticated extends AppState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}

class AppUnauthenticated extends AppState {
  @override
  List<Object> get props => [DateTime.now().toIso8601String()];
}
