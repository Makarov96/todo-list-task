import 'package:flutter/material.dart';
import 'package:todo_list/app_provider.dart';
import 'package:todo_list/feature/todo/domain/entity/task.dart';
import 'package:todo_list/feature/todo/ui/components/feedback/add_task_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskBloc = AppProvider.of(context);

    void _showAddTaskDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AddTaskDialog(onSend: (value) async {
            await taskBloc.addTask(
              value.title,
              value.description,
            );
          });
        },
      );
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text("Task Management App"),
            ),
            SliverToBoxAdapter(
              child: TabBar(
                tabs: [
                  Tab(icon: Text('All')),
                  Tab(icon: Text('Completed')),
                  Tab(icon: Text('Incompleted')),
                ],
                onTap: (index) {
                  switch (index) {
                    case 0:
                      taskBloc.showAll();
                      break;
                    case 1:
                      taskBloc.filterByCompleted();
                      break;
                    case 2:
                      taskBloc.filterByInCompleted();
                      break;
                  }
                },
              ),
            ),
            StreamBuilder(
              stream: taskBloc.stream,
              initialData: <Task>[],
              builder:
                  (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                return AnimatedBuilder(
                    animation: taskBloc,
                    builder: (ctx, child) {
                      return SliverList.builder(
                        itemCount: taskBloc.tasks.length,
                        itemBuilder: (context, index) {
                          Task task = taskBloc.tasks[index];
                          return ListTile(
                            title: Text(task.title),
                            subtitle: Text(task.description),
                            trailing: Checkbox(
                              value: task.completed,
                              onChanged: (value) => taskBloc.toggleTaskStatus(
                                  id: task.id, completed: !task.completed),
                            ),
                          );
                        },
                      );
                    });
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddTaskDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
