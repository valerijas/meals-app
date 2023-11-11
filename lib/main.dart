import 'package:flutter/material.dart';
import 'package:meals_app/pages/asian.dart';
import 'package:meals_app/pages/breakfast.dart';
import 'package:meals_app/pages/christmas.dart';
import 'package:meals_app/pages/exotic.dart';
import 'package:meals_app/pages/favorites.dart';
import 'package:meals_app/pages/french.dart';
import 'package:meals_app/pages/german.dart';
import 'package:meals_app/pages/gluten_free.dart';
import 'package:meals_app/pages/hamburgers.dart';
import 'package:meals_app/pages/italian.dart';
import 'package:meals_app/pages/light&lovely.dart';
import 'package:meals_app/pages/quick&easy.dart';
import 'package:meals_app/pages/summer.dart';
import 'package:meals_app/pages/vegan.dart';
import 'package:meals_app/pages/vegetarian.dart';
import 'package:meals_app/services/favorite_recipes.dart';
import 'package:meals_app/widgets/drawer.dart';

void main() {
  final favoriteRecipes = FavoriteRecipes();
  runApp(
    MaterialApp(
      navigatorKey: navigatorKey,
      home: MyApp(favoriteRecipes: favoriteRecipes),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final FavoriteRecipes favoriteRecipes;

  MyApp({Key? key, required this.favoriteRecipes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const MyHomePage(),
        '/Asian': (context) => Asian(favoriteRecipes: favoriteRecipes),
        '/Breakfast': (context) => Breakfast(favoriteRecipes: favoriteRecipes),
        '/Exotic': (context) => Exotic(favoriteRecipes: favoriteRecipes),
        '/French': (context) => French(favoriteRecipes: favoriteRecipes),
        '/German': (context) => German(favoriteRecipes: favoriteRecipes),
        '/Hamburgers': (context) =>
            Hamburgers(favoriteRecipes: favoriteRecipes),
        '/Italian': (context) => Italian(favoriteRecipes: favoriteRecipes),
        '/Light&Lovely': (context) =>
            LightLovely(favoriteRecipes: favoriteRecipes),
        '/Quick&Easy': (context) => QuickEasy(favoriteRecipes: favoriteRecipes),
        '/Summer': (context) => Summer(favoriteRecipes: favoriteRecipes),
        '/Vegan': (context) => Vegan(favoriteRecipes: favoriteRecipes),
        '/Vegetarian': (context) =>
            Vegetarian(favoriteRecipes: favoriteRecipes),
        '/GlutenFree': (context) =>
            GlutenFree(favoriteRecipes: favoriteRecipes),
        '/Favorites': (context) =>
            FavoriteRecipesScreen(favoriteRecipes: favoriteRecipes),
        '/Christmas': (context) => Christmas(favoriteRecipes: favoriteRecipes),
      },
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: ButtonGrid(),
      drawer: const MyDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        selectedLabelStyle: const TextStyle(
          color: Colors.red,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.blue,
        ),
        onTap: (int index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/Favorites');
          }
        },
      ),
    );
  }
}

class ButtonGrid extends StatelessWidget {
  ButtonGrid({Key? key}) : super(key: key);

  final List<String> buttonNames = [
    'Italian',
    'Quick&Easy',
    'Hamburgers',
    'German',
    'Light&Lovely',
    'Exotic',
    'Breakfast',
    'Asian',
    'French',
    'Summer',
    'Vegan',
    'Vegetarian',
    'GlutenFree',
    'Christmas',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 50.0,
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16.0),
      children: List.generate(14, (index) {
        Color buttonColor = _getButtonColor(index);

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
          ),
          onPressed: () {
            String routeName = '/${buttonNames[index]}';
            Navigator.pushNamed(context, routeName);
          },
          child: Container(
            width: 160,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              buttonNames[index],
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
      }),
    );
  }

  Color _getButtonColor(int index) {
    List<Color> buttonColors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.blueGrey,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.brown,
      const Color.fromARGB(255, 210, 64, 255),
      const Color.fromARGB(255, 163, 64, 255),
      const Color.fromARGB(255, 57, 201, 220),
      const Color.fromARGB(255, 163, 181, 63),
    ];

    return buttonColors[index % buttonColors.length];
  }
}
