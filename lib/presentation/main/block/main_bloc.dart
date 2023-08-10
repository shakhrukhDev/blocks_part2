import 'package:blocks_part2/presentation/main/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<LoadTaskEvent>(_loadTasks);
    on<CheckTaskEvent>(_checkTask);
    on<DeleteTaskEvent>(_deleteTask);
  }

  void _loadTasks(LoadTaskEvent event, Emitter<MainState> emit) async{

    emit(state.copyWith(
      pageStatus: PageStatus.loading
    ));
    var tasks = _getTasks(event.count);
    await Future.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(
      pageStatus: PageStatus.success,
      tasks: tasks
    ));
  }

  void _checkTask(CheckTaskEvent event, Emitter<MainState> emit){
    MyTask editingTask = state.tasks[event.index];
    editingTask = editingTask.copyWith(isDone: !editingTask.isDone);

    var editingTasksList =state.tasks;
    editingTasksList.removeAt(event.index);
    editingTasksList.insert(event.index, editingTask);

    emit(state.copyWith(
      tasks: editingTasksList,
    ));
  }

  void _deleteTask(DeleteTaskEvent event, Emitter<MainState> emit) async {
    emit(state.copyWith(
      pageStatus: PageStatus.loading,
    ));
    var editingTaskList = state.tasks;

    editingTaskList = editingTaskList..removeAt(event.index);
    await Future.delayed(const Duration(milliseconds: 300));

    emit(state.copyWith(
      tasks: editingTaskList,
      pageStatus: PageStatus.success,
    ));
  }

  List<MyTask> _getTasks(int count) {
    return List.generate(
      count,
          (index) => MyTask(
        description: 'Task $index',
        isDone: false,
      ),
    );
  }
}
