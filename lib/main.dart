import 'package:flutter/material.dart';
import 'package:todo_list/Todo_Helper.dart';

void main() {
  runApp(MyHomePage());
}

//thank you for beean patent with me i have issus with my github account
//and also thank for your timee

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // is not restarted.
          primaryColor: Colors.blue.shade900,
        ),
        home: Todolist());

    //
  }
}

class Todolist extends StatefulWidget {
  @override
  _TodolistState createState() => _TodolistState();
}

TodoModel _todoModel = TodoModel();
List<TodoModel> _list = [];
final _formkey = GlobalKey<FormState>();

class _TodolistState extends State<Todolist> {
  void _todosubmit() {
    var form = _formkey.currentState;
    if (form.validate()) {
      form.save();
      _list.add(TodoModel(todo: _todoModel.todo));
      form.reset();
      print(_todoModel.todo);
    }
  }

  Widget _todoBoutton() => FloatingActionButton(
        onPressed: _todosubmit,
        child: Icon(Icons.add, size: 20, color: Colors.white),
      );

  Widget _todobody() => Container(
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Todo',
              labelStyle: TextStyle(
                fontSize: 17,
              )),
          onSaved: (onsave) => setState(() => _todoModel.todo = onsave),
          validator: (valid) => valid.isEmpty ? 'insert Todo ' : null,
        ),
      );

  Widget _todooutput() => Flexible(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_list[index].todo),
                  onDismissed: (derection) {
                    _list.removeAt(index);
                  },
                  child: Card(
                    margin: EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _list[index].todo,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _todoBoutton(),
      appBar: AppBar(
        title: Text('Todo list'),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            _todobody(),
            SizedBox(
              height: 10,
            ),
            _todooutput()
          ],
        ),
      ),
    );
  }
}
