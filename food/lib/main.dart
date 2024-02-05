import 'package:flutter/material.dart';

void main() {
  runApp(myapp());
}

class myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      home: myapphome(),
    );
  }
}

class myapphome extends StatefulWidget {
  @override
  _myapphomeState createState() => _myapphomeState();
}

class _myapphomeState extends State<myapphome> {
  List<String> todoItems = ['item1', 'item2', 'item3'];

  void _addTodoItem() {
    setState(() {
      int index = todoItems.length;
      todoItems.add('item $index');
    });
  }

  void _deleteTodoItem(int index) {
    setState(() {
      todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        title: Text('TodoList UI'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: todoItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todoItems[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _deleteTodoItem(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodoItem,
        child: Icon(Icons.add),
      ),
    );
  }
}
