// Flutter Imports
import 'package:commonplace_book/app/commonplace_book/frontend/features/05-notebooks/state/notebook_bloc/notebook_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class NotebookDashboardPage extends StatelessWidget {
  const NotebookDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libretas'),
      ),
      
      body: BlocBuilder<NotebookBloc, NotebookState>(
        builder: (context, state) {  
          switch(state.status) {
            case NotebookStatus.failure:
              return Center(child: Text('Error en la carga de libretas'));
            case NotebookStatus.loading:
              return const Center(child: CircularProgressIndicator());
              
            default: 
              if(state.notebooks.isEmpty) {
                return const Center(child: Text('No hay libretas disponibles'));
              } else {
                return const Center(child: Text('Hay libretas disponibles'));
              }
          }
        },
      ),
    );
  }
}