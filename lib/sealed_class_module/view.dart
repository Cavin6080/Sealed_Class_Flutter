import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sealed_class/data/api.dart';
import 'package:sealed_class/data/repository.dart';
import 'package:sealed_class/sealed_class_module/bloc/home_bloc.dart';
import 'package:sealed_class/sealed_class_module/bloc/home_state.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) => state.maybeWhen(
              error: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Not Available",
                  ),
                ),
              ),
              orElse: () => -1,
            ),
            builder: (context, state) {
              return state.when(
                initial: () => const Center(
                  child: Text("No data to show"),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                loaded: (model) => Expanded(
                  child: ListView.builder(
                    itemCount: model.people?.length ?? 0,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          model.people?[index].name ?? "",
                        ),
                      );
                    },
                  ),
                ),
                error: () => const Center(
                  child: Text("Something went wrong"),
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
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              "Get Data",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
