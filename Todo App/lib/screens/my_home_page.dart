import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_action.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textFieldController = TextEditingController();
  String newTask = '';

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(() {
      newTask = _textFieldController.text;
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

  void _submit() {
    Provider.of<TodoProvider>(context, listen: false).addTask(newTask);
    Navigator.pop(context);
    _textFieldController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showAddTextDialog() async {
      return showDialog(
        context: context,
        builder: (context) {
          return AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: 1.0,
            child: AlertDialog(
              title: const Text("Add New List"),
              content: TextField(
                autofocus: true,
                controller: _textFieldController,
                decoration: InputDecoration(
                  hintText: "What would you like to do?",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(120, 40),
                    primary: Colors.lightGreen,
                  ),
                )
              ],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              actionsAlignment: MainAxisAlignment.center,
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "To Do List",
          style: TextStyle(color: Color.fromARGB(255, 102, 185, 51)),
        ),
      ),
      body: TodoAction(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 102, 185, 51),
        foregroundColor: Colors.black54,
        onPressed: (() {
          _showAddTextDialog();
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
