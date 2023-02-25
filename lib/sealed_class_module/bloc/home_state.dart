import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sealed_class/model/person.dart';
import 'package:flutter/foundation.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState.initial() = _HomeInitial;
  const factory HomeState.loading() = _HomeLoading;
  const factory HomeState.loaded(PersonModel model) = _HomeLoaded;
  const factory HomeState.error() = _HomeError;
}
