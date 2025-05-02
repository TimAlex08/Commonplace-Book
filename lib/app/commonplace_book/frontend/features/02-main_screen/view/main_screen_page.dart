// Flutter
import 'package:commonplace_book/app/commonplace_book/frontend/features/02-main_screen/widgets/floating_action_button.dart';
import 'package:flutter/material.dart';

// External Imports
import 'package:flutter_bloc/flutter_bloc.dart';

// Pages
import 'package:commonplace_book/app/commonplace_book/frontend/features/02-main_screen/cubit/main_screen_cubit.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/03-home/view/home_page.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/04-journal/view/journal_page.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/05-notebooks/view/notebook_dashboard_page.dart';
import 'package:commonplace_book/app/commonplace_book/frontend/features/06-task/view/task_page.dart';




class MainScreenPage extends StatelessWidget {
  const MainScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainScreenCubit(),
      child: MainScreenView(),
    );
  }
}



class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((MainScreenCubit cubit) => cubit.state.tab);
    
    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [HomePage(), JournalPage(), NotebookDashboardPage(), TaskPage()]
      ),
      floatingActionButton: MainScreenFAB(selectedTab: selectedTab),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _MainScreenTabButton(
              icon: const Icon(Icons.home),
              groupValue: selectedTab, 
              value: MainScreenTab.home, 
            ),
            
            _MainScreenTabButton(
              icon: const Icon(Icons.menu_book_rounded),
              groupValue: selectedTab, 
              value: MainScreenTab.journal, 
            ),
            
            _MainScreenTabButton(
              icon: const Icon(Icons.library_books_rounded),
              groupValue: selectedTab, 
              value: MainScreenTab.notebooks, 
            ),
            
            _MainScreenTabButton(
              groupValue: selectedTab, 
              value: MainScreenTab.tasks, 
              icon: const Icon(Icons.checklist_rounded)
            )
          ],
        ),
      ),
    );
  }
}

class _MainScreenTabButton extends StatelessWidget {
  const _MainScreenTabButton({
    required this.groupValue, 
    required this.value, 
    required this.icon
  });
  
  final MainScreenTab groupValue;
  final MainScreenTab value;
  final Widget icon;
  
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<MainScreenCubit>().setTab(value), 
      iconSize: 32,
      color: groupValue != value
        ? null
        : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}