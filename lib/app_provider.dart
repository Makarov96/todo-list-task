import 'package:flutter/material.dart';
import 'package:todo_list/feature/todo/domain/repository/todo_repo.dart';
import 'package:todo_list/feature/todo/ui/bloc/task_bloc.dart';

class AppProvider extends StatefulWidget {
  final TodoRepo repo;
  final Widget child;

  const AppProvider({
    super.key,
    required this.repo,
    required this.child,
  });

  static TaskBloc of(BuildContext context) {
    final _AppInherited? inherited =
        context.dependOnInheritedWidgetOfExactType<_AppInherited>();
    assert(inherited != null, 'AppProvider didnt found');
    return inherited!.bloc;
  }

  @override
  AppProviderState createState() => AppProviderState();
}

class AppProviderState extends State<AppProvider> {
  late TaskBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = TaskBloc(repo: widget.repo);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _AppInherited(
      bloc: _bloc,
      child: widget.child,
    );
  }
}

class _AppInherited extends InheritedNotifier<TaskBloc> {
  final TaskBloc bloc;
  const _AppInherited({
    required this.bloc,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant _AppInherited oldWidget) =>
      bloc != oldWidget.bloc;
}
