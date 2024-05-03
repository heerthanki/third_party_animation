import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:animations/animations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation & Curved Navigation Bar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Animation & Curved Navigation Bar Example'),
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _buildPage(_currentIndex), //pass page index
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return MyAnimatedList(); // Replace with MyAnimatedList widget
      case 1:
        return Container(
            color: Colors.green); // Can replace with your desired page content
      case 2:
        return ProfilePage(); // Profile page content
      default:
        return Container();
    }
  }
}

class MyAnimatedList extends StatefulWidget {
  @override
  _MyAnimatedListState createState() => _MyAnimatedListState();
}

class _MyAnimatedListState extends State<MyAnimatedList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10'
  ];

  void _addItem() {
    final newIndex = _items.length; // Calculate the index for the new item
    final newItem = 'Item ${newIndex + 1}'; // Create a new item

    // Update the underlying data list
    setState(() {
      _items.add(newItem);
    });

    // Insert the new item into the AnimatedList
    _listKey.currentState!.insertItem(newIndex);
  }

  void _removeItem(int index) {
    final removedItem = _items[index];

    // Remove the item from the data list
    setState(() {
      _items.removeAt(index);
    });

    // Remove the item from the AnimatedList with animation
    _listKey.currentState!.removeItem(
      index,
      (context, animation) => buildItem(removedItem, animation),
    );
  }

  Widget buildItem(String item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        title: Text(item), // Display the item's text
        trailing: IconButton(
          icon: Icon(Icons.delete), // Display a delete icon
          onPressed: () =>
              _removeItem(_items.indexOf(item)), // Remove the item when pressed
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedList Example'), // Set the app bar title
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return buildItem(_items[index], animation); // Build each list item
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem, // Add a new item when the FAB is pressed
        child: Icon(Icons.add), // Display a plus icon
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          SizedBox(height: 20),
          Text(
            'Heer Thanki',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 10),
          Text(
            'Flutter Developer',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
