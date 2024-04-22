import 'package:flutter/material.dart';
import 'package:flutter_application1/task_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.blueGrey,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      );
  }
}


class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
      return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: Icon(Icons.check),
            ),
            SizedBox(
              width: 16,
            ),
            Text("Todo List",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              title: Text(
                ref.watch(taskProviderProvider)[index].name,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              subtitle: Text("Mon 23 April 2024",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.white60)),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              color: Colors.blue,
              thickness: 1,
            );
          },
          itemCount: ref.watch(taskProviderProvider).length),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog();
            },
          )
        },
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }
}

class CustomDialog extends ConsumerWidget {
  const CustomDialog({
    super.key,
  });

  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double screenWidth = MediaQuery.sizeOf(context).width;
   final provider = ref.read(taskProviderProvider.notifier);
    return Dialog(
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: SizedBox(
        height: screenHeight * 0.6,
        width: screenWidth * 0.8,
        child: Column(children: [
          Text(
            "Add task",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
          ),
          CustomTextField(
            onChanged: (text) {
             provider.setName(text);
            },
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(onPressed: () {
              provider.addTask();
              if(context.mounted){
                Navigator.pop(context);
              }
            }, child: Text("CREATE")),
          )
        ]),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final void Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: "Add something to do",
          hintStyle: TextStyle(color: Colors.white38)),
    );
  }
}
