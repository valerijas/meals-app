import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Text(
              'Meals App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('About App'),
            iconColor: Colors.white,
            textColor: Colors.white,
            onTap: () {
              Navigator.pop(context); // Закрыть боковую панель
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const HomeScreen()), // Переход на экран Home
              );
            },
          ),
          // Добавьте другие элементы боковой панели по необходимости.
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Home'),
      ),
      body: Container(
        color: Colors.black, // Установка черного фона
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text:
                            'Welcome to the Meals App, your gateway to a world of culinary delight! With the Meals App, you can embark on a journey to explore a wide range of cuisines and recipes. Whether you are a seasoned chef or just getting started in the kitchen, our app is designed to cater to your every culinary need.\n',
                      ),
                      TextSpan(
                        text: 'Key Features:\n',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            '- Endless Culinary Exploration: Dive into a world of diverse cuisines, each offering its own unique flavors and traditions.\n'
                            '- Recipe Details: Access comprehensive recipes, complete with ingredients, step-by-step instructions, and cooking tips.\n'
                            '- Favorites: Save your favorite recipes for quick and easy access.\n'
                            '\nUser-Friendly Interface:\n',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            'The Meals App features an intuitive and visually appealing design, making it a breeze to navigate through the app extensive list of categories.\n',
                      ),
                      TextSpan(
                        text: 'Target Audience:\n',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Our app caters to food enthusiasts, cooking novices, and anyone with a passion for trying new dishes. Whether you are looking for quick and easy meals or gourmet delights, the Meals App has something for everyone.\n',
                      ),
                      TextSpan(
                        text: 'How It Works:\n',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Using the app is easy. Simply select a category, explore the recipes, and follow the detailed instructions to create delicious meals in your own kitchen. The app user-friendly interface ensures a smooth experience every time.\n',
                      ),
                    ],
                  ),
                ),
              ),
              // Вставьте здесь большой объем текста
            ],
          ),
        ),
      ),
    );
  }
}
