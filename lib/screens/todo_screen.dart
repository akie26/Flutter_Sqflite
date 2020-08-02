import 'package:MyTodoList/services/category_service.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({Key key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var todoTitleController = TextEditingController();
  var todoDescriptionController = TextEditingController();
  var todoDateController = TextEditingController();
  var _selectedValue;
  var _categories;

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: todoTitleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Todo Title',
              ),
            ),
            TextField(
              controller: todoDescriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Todo Description',
              ),
            ),
            TextField(
              controller: todoDateController,
              decoration: InputDecoration(
                labelText: 'Date',
                hintText: 'Todo Date',
                prefixIcon: InkWell(
                  onTap: () {},
                  child: Icon(Icons.calendar_today),
                ),
              ),
            ),
            DropdownButtonFormField(
                value: _selectedValue,
                hint: Text('Categories'),
                items: _categories,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                }),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {},
              color: Colors.blue,
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
