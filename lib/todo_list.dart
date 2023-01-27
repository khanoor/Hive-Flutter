import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/boxes.dart';
import 'package:hive_test/global/global.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Map<String, dynamic>> listData = [];
  // final box = Hive.box("Todo");
  @override
  void initState() {
    super.initState();
    // openBox();
    TodoData();
    // print(listData.length);
  }

  void TodoData() {
    final data = TODOBox.keys.map((key) {
      final value = TODOBox.get(key);
      print(value);
      return {
        "key": key,
        "title": value["title"],
        "description": value["description"]
      };
    }).toList();
    setState(() {
      listData = data.reversed.toList();
    });
  }

  Future<void> deleteTODO(int id) async {
    await TODOBox.delete(id);
    TodoData();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An item has been deleted')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List"),
        ),
        body:
            //ValueListenableBuilder(valueListenable: Boxes.getData().listenable(), builder: (context,box){
            //   return
            // }
            // )

            ListView.builder(
                itemCount: listData.length,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(166, 113, 187, 183),
                      ),
                      child: ListTile(
                        trailing: IconButton(
                          onPressed: () {
                            deleteTODO(listData[index]['key']);
                          },
                          icon: Icon(Icons.delete),
                        ),

                        title: Text(listData[index]['title']),
                        subtitle: Text(listData[index]['description']),
                        // subtitle: Text(listData[index]['key'].toString()),
                      ),
                    ),
                  );
                })));
  }
}
