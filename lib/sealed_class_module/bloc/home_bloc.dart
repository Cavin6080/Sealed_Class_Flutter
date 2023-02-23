import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sealed_class/data/repository.dart';
import 'package:sealed_class/model/person.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PeopleRepository repository;
  HomeBloc({required this.repository}) : super(HomeInitial()) {
    on<GetPeopleEvent>(
      (event, emit) async {
        try {
          emit(HomeLoading());
          final peopleData = await repository.getPeopleData();
          emit(HomeLoaded(model: peopleData));
        } catch (e) {
          emit(HomeError());
        }
      },
    );
  }
}
