import 'package:flutter/material.dart';
import 'package:todo_list/Todo_Helper.dart';

void main() {
  runApp(MyApp());
}

//thank you for beean patent with me i have issus with my github account
//and also thank for your timee

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primaryColor: Colors.blue.shade900,
      ),
      home: MyHomePage(title: 'TODO LIST'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DemoCode _demoCode = DemoCode();
  List<DemoCode> _list = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[_container(), _button(), listbiulder(context)],
        ),
      ),
    );
  }

  listbiulder(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (cnt, i) {
              return Padding(
                padding: EdgeInsets.all(8),
                child: Dismissible(
                  key: Key(_list[i].name),
                  onDismissed: (d) {
                    _list.removeAt(i);
                    SnackBar(content: Text(_list[i].name));
                    showDialog(context: context);
                  },
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 23,
                        ),
                      ),
                      title: Text(
                        _list[i].name.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontSize: 18),
                      ),
                      subtitle: Text(
                        _list[i].contact,
                        style: TextStyle(
                          color: Colors.grey,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  _container() => Form(
        key: _formKey,
        child: Container(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                onSaved: (s) => setState(() => _demoCode.name = s),
                validator: (vl) => vl.isEmpty ? 'inser your name' : null,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number',
                ),
                validator: (vl) => vl.isEmpty ? 'inser your name' : null,
                onSaved: (s) => setState(() => _demoCode.contact = s),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );

  _button() => Container(
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: FlatButton(
          onPressed: _submit,
          child: Text(
            'Submit',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      );

  _submit() {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _list.add(DemoCode(contact: _demoCode.contact, name: _demoCode.name));
      form.reset();
    }
  }
}
