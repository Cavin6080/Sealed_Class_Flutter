import 'dart:developer';

import 'package:sealed_class/data/api.dart';
import 'package:sealed_class/model/person.dart';

class PeopleRepository {
  const PeopleRepository({required SpaceApi spaceApi}) : _spaceApi = spaceApi;

  final SpaceApi _spaceApi;

  Future<PersonModel> getPeopleData() async {
    try {
      final response = await _spaceApi.getPeople();
      final data = PersonModel.fromJson(response.data);
      return data;
    } catch (e) {
      throw Exception();
    }
  }
}
