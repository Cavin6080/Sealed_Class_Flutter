part of 'home_bloc.dart';

class _HomeInitial {}

class _HomeLoading {}

class _HomeLoaded {
  _HomeLoaded({required this.model});
  final PersonModel model;
}

class _HomeError {}

class HomeState
    extends Union4Impl<_HomeInitial, _HomeLoading, _HomeLoaded, _HomeError> {
  static const factory =
      Quartet<_HomeInitial, _HomeLoading, _HomeLoaded, _HomeError>();
  HomeState._(Union4<_HomeInitial, _HomeLoading, _HomeLoaded, _HomeError> union)
      : super(union);

  factory HomeState.initial() => HomeState._(factory.first(_HomeInitial()));
  factory HomeState.loading() => HomeState._(factory.second(_HomeLoading()));
  factory HomeState.loaded(PersonModel model) =>
      HomeState._(factory.third(_HomeLoaded(model: model)));
  factory HomeState.error() => HomeState._(factory.fourth(_HomeError()));
}
