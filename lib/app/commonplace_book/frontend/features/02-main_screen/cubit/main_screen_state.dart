part of 'main_screen_cubit.dart';

enum MainScreenTab {home, journal, notebooks, tasks}

final class MainScreenState extends Equatable {
  const MainScreenState({
    this.tab = MainScreenTab.home
  });
  
  final MainScreenTab tab;

  @override
  List<Object> get props => [tab];
}