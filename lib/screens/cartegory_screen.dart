import 'package:MyTodoList/models/Category.dart';
import 'package:MyTodoList/screens/home_screen.dart';
import 'package:MyTodoList/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  var _category = Category();
  var _categoryService = CategoryService();
  List<Category> _categoryList = List<Category>();

  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();
  var _editcategoryNameController = TextEditingController();
  var _editcategoryDescriptionController = TextEditingController();

  var category;

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllCategories() async {
    _categoryList = List<Category>();
    var cartegories = await _categoryService.readCategory();

    cartegories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];

        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editcategoryNameController.text = category[0]['name'] ?? 'No Name';
      _editcategoryDescriptionController.text =
          category[0]['description'] ?? 'No Description';
    });
    _editFormDialog(context);
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  color: Colors.redAccent,
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              FlatButton(
                  color: Colors.green,
                  onPressed: () async {
                    _category.name = _categoryNameController.text;
                    _category.description = _categoryDescriptionController.text;

                    var result = await _categoryService.saveCategory(_category);
                    if (result > 0) {
                      _categoryNameController.clear();
                      _categoryDescriptionController.clear();
                      getAllCategories();
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Submit')),
            ],
            title: Text('Add Category'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                      controller: _categoryNameController,
                      decoration: InputDecoration(
                          hintText: 'Name', labelText: 'Category')),
                  TextField(
                      controller: _categoryDescriptionController,
                      decoration: InputDecoration(
                          hintText: 'Description', labelText: 'Description'))
                ],
              ),
            ),
          );
        });
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  color: Colors.redAccent,
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              FlatButton(
                  color: Colors.green,
                  onPressed: () async {
                    _category.id = category[0]['id'];
                    _category.name = _editcategoryNameController.text;
                    _category.description =
                        _editcategoryDescriptionController.text;

                    var result =
                        await _categoryService.updateCategory(_category);
                    if (result > 0) {
                      Navigator.pop(context);
                      getAllCategories();
                      _showSuccessSnackBar(Text('Successfully Updated'));
                    }
                  },
                  child: Text('Save')),
            ],
            title: Text('Edit Category'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                      controller: _editcategoryNameController,
                      decoration: InputDecoration(
                          hintText: 'Name', labelText: 'Category')),
                  TextField(
                      controller: _editcategoryDescriptionController,
                      decoration: InputDecoration(
                          hintText: 'Description', labelText: 'Description'))
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                  color: Colors.green,
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
              FlatButton(
                  color: Colors.redAccent,
                  onPressed: () async {
                    await _categoryService.deleteCategory(categoryId);
                    setState(() {
                      getAllCategories();
                    });
                    Navigator.pop(context);
                    _showSuccessSnackBar(Text('Successfully Deleted'));
                  },
                  child: Text('Delete')),
            ],
            title: Text('Are you sure?'),
          );
        });
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(duration: Duration(seconds: 1), content: message);
    _globalKey.currentState.showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: RaisedButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          )),
          elevation: 0.0,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          color: Colors.blue,
        ),
        title: Text('Categories'),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0, right: 16.0, left: 16.0),
              child: Card(
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editCategory(context, _categoryList[index].id);
                    },
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_categoryList[index].name),
                      IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () {
                            _deleteFormDialog(context, _categoryList[index].id);
                          })
                    ],
                  ),
                  // subtitle: Text(_categoryList[index].description),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
