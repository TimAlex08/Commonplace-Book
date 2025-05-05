// Flutter Imports
import 'package:commonplace_book/app/commonplace_book/frontend/features/05-notebooks/state/notebook_bloc/notebook_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// Pages
import '../commonplace_book/frontend/features/02-main_screen/view/main_screen_page.dart';



class App extends StatelessWidget {
  const App({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotebookBloc>.value(
          value: GetIt.instance.get<NotebookBloc>()
        )
      ], 
      child: AppView()
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Commonplace Book',
      debugShowCheckedModeBanner: false,
      home: const MainScreenPage(),
    );
  }
}