import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sealed_class/data/repository.dart';
import 'package:sealed_class/sealed_class_module/bloc/home_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PeopleRepository repository;
  HomeBloc({required this.repository}) : super(const HomeState.initial()) {
    on<GetPeopleEvent>(
      (event, emit) async {
        try {
          emit(const HomeState.loading());
          final peopleData = await repository.getPeopleData();
          emit(HomeState.loaded(peopleData));
        } catch (e) {
          emit(const HomeState.error());
        }
      },
    );
  }
}
