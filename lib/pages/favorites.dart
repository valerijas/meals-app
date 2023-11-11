import 'package:flutter/material.dart';
import 'package:meals_app/services/favorite_recipes.dart';

class FavoriteRecipesScreen extends StatefulWidget {
  final FavoriteRecipes favoriteRecipes;

  const FavoriteRecipesScreen({Key? key, required this.favoriteRecipes})
      : super(key: key);

  @override
  _FavoriteRecipesScreenState createState() => _FavoriteRecipesScreenState();
}

class _FavoriteRecipesScreenState extends State<FavoriteRecipesScreen> {
  Future<List<int>>? _favoriteRecipeIdsFuture;

  @override
  void initState() {
    super.initState();
    _updateFavoriteRecipeIds();
  }

  void _updateFavoriteRecipeIds() {
    _favoriteRecipeIdsFuture =
        Future.value(widget.favoriteRecipes.getFavoriteRecipeIds());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Фон установлен в белый цвет
      appBar: AppBar(
        backgroundColor: Colors.black, // Цвет фона AppBar
        title: const Text(
          'Favorite recipes',
          style: TextStyle(color: Colors.white),
        ), // Цвет текста в AppBar
        foregroundColor: Colors.white, // Цвет иконок и текста в AppBar
      ),
      body: FutureBuilder<List<int>>(
        future: _favoriteRecipeIdsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final favoriteRecipeIds = snapshot.data;

          if (favoriteRecipeIds == null || favoriteRecipeIds.isEmpty) {
            return const Center(
              child: Text('You do not have favorite recipes'),
            );
          }

          return ListView.builder(
            itemCount: favoriteRecipeIds.length,
            itemBuilder: (context, index) {
              final recipeId = favoriteRecipeIds[index];
              final recipe = widget.favoriteRecipes.getRecipeById(recipeId);

              return ListTile(
                leading: Image.network(
                  recipe['imageURL'] ?? 'URL_по_умолчанию',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  recipe['title'],
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
