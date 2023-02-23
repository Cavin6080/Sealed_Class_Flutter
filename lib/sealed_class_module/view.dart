import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sealed_class/data/api.dart';
import 'package:sealed_class/data/repository.dart';
import 'package:sealed_class/sealed_class_module/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static create() {
    return BlocProvider(
      create: (_) => HomeBloc(
        repository: PeopleRepository(
          spaceApi: SpaceApi(
            dio: Dio(),
          ),
        ),
      ),
      child: const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Who are in space right now?"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              return state.join(
                (initial) => const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Center(
                    child: Text("No data to show"),
                  ),
                ),
                (loading) => const Center(
                  child: CircularProgressIndicator(),
                ),
                (loaded) => Expanded(
                  child: ListView.builder(
                    itemCount: loaded.model.people?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          loaded.model.people?[index].name ?? "",
                        ),
                      );
                    },
                  ),
                ),
                (error) => const Center(
                  child: Text("a big erro"),
                ),
              );
            },
          )
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          context.read<HomeBloc>().add(GetPeopleEvent());
        },
        child: Container(
          height: 60,
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Text(
              "GetData",
            ),
          ),
        ),
      ),
    );
  }
}
