import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_test/boxes.dart';

import 'package:hive_test/todo_list.dart';

import 'global/global.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> addTODO(Map<String, dynamic> newTODO) async {
    await TODOBox.add(newTODO);
    Navigator.pop(context);
    title.text = '';
    description.text = '';
  }

  // final titleController = TextEditingController();
  // final descriptionController = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Hive"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (() {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return AlertDialog(
                          title: Text("TODO"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                maxLength: null,
                                autofocus: true,
                                decoration: InputDecoration(hintText: 'title'),
                                controller: title,
                              ),
                              TextField(
                                controller: description,
                                maxLength: null,
                                autofocus: true,
                                decoration:
                                    InputDecoration(hintText: 'description'),
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (title.text != "" &&
                                      description.text != "") {
                                    addTODO({
                                      'title': title.text,
                                      'description': description.text
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Enter title & description");
                                  }
                                  // Navigator.pop(context, build(context));
                                  // final data = Tododatabase(
                                  //     title: title.text,
                                  //     description: description.text);
                                  // Fluttertoast.showToast(msg: 'TODO Add');
                                  // final box = Boxes.getData();
                                  // box.add(data);

                                  // data.save();
                                  // title.clear();
                                  // description.clear();
                                  // print(data.title);
                                },
                                child: Text("ADD"))
                          ],
                        );
                      }));
                }),
                child: Text("Add TODO")),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TodoList()));
                },
                child: Text("Show TODO")),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    ));
  }
}
