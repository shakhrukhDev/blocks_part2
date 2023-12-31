import 'package:blocks_part2/presentation/main/block/main_bloc.dart';
import 'package:blocks_part2/presentation/main/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (_, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home Page"),
          ),
          body: state.pageStatus.isLoading
          ? const Center(child: CircularProgressIndicator.adaptive())
              :state.tasks.isNotEmpty
            ?ListView.builder(
            itemCount: state.tasks.length,
              itemBuilder: (context, index){
                MyTask currentTask = state.tasks[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    elevation: 1,
                    child: ListTile(
                      leading: Checkbox(
                        value: currentTask.isDone,
                        onChanged: (bool? value) {
                          context.read<MainBloc>().add(CheckTaskEvent(index: index));
                        },
                      ),
                      title: Text(currentTask.description),
                      trailing: IconButton(
                        onPressed: () {
                          context.read<MainBloc>().add(DeleteTaskEvent(index: index));
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
              )
              : Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 const Text('Oops, you have no tasks to do!',
                    style: TextStyle(fontSize: 30),),
                  ElevatedButton(onPressed: (){
                    context.read<MainBloc>().add(LoadTaskEvent());
                  }, child: const Text('Generate tasks'))
                ],
              ),
            ),
          )
        );
      },
    );
  }
}
