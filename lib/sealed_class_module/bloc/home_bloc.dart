import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sealed_class/data/repository.dart';
import 'package:sealed_class/model/person.dart';
import 'package:sealed_unions/sealed_unions.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PeopleRepository repository;
  HomeBloc({required this.repository}) : super(HomeState.initial()) {
    on<GetPeopleEvent>(
      (event, emit) async {
        try {
          emit(HomeState.loading());
          final peopleData = await repository.getPeopleData();
          emit(HomeState.loaded(peopleData));
        } catch (e) {
          emit(HomeState.error());
        }
      },
    );
  }
}
