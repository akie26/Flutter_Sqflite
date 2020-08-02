import 'package:MyTodoList/screens/cartegory_screen.dart';
import 'package:MyTodoList/screens/home_screen.dart';
import 'package:flutter/material.dart';

class DrawerNavigation extends StatefulWidget {
  DrawerNavigation({Key key}) : super(key: key);

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png'),
              ),
              accountName: Text('Zwe Sithu'),
              accountEmail: Text('akie@gmail.com'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen())),
            ),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Categories'),
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CategoryScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
