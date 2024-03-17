import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Favorites List',
      home: FavoriteListScreen(),
    );
  }
}

class FavoriteListScreen extends StatefulWidget {
  @override
  _FavoriteListScreenState createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  List<String> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/favorites.json');
      if (file.existsSync()) {
        final data = await file.readAsString();
        setState(() {
          favoriteItems = List<String>.from(json.decode(data));
        });
      }
    } catch (e) {
      print("Error loading favorites from file: $e");
    }
  }

  Future<void> _saveFavorites() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/favorites.json');
      await file.writeAsString(json.encode(favoriteItems));
    } catch (e) {
      print("Error saving favorites to file: $e");
    }
  }

  void _toggleFavorite(String item) {
    setState(() {
      if (favoriteItems.contains(item)) {
        favoriteItems.remove(item);
      } else {
        favoriteItems.add(item);
      }
      _saveFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites List'),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          final item = 'Item $index';
          return ListTile(
            title: Text(item),
            trailing: IconButton(
              icon: favoriteItems.contains(item)
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_border),
              onPressed: () => _toggleFavorite(item),
            ),
          );
        },
      ),
    );
  }
}
