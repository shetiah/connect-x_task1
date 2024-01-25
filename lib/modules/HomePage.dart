import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/shared/cubit/cubit.dart';
import 'package:task1/shared/cubit/states.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
   Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit(),
        child: BlocConsumer<AppCubit, AppState>(
            builder: (context, state) {
              return const Scaffold(
                body: Column(
                  children: [
                    Text("data")
                  ],
                )
              );
            }, listener: (context, state) {}));
  }
}