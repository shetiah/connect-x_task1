import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1/shared/cubit/cubit.dart';
import 'package:task1/shared/cubit/states.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(),
            body: WebViewWidget(
              controller: cubit.controllerWeb,
            ));
      },
      listener: (context, state) {},
    );
  }
}
