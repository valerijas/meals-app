import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:meals_app/main.dart';
import 'package:meals_app/models/ingredient_model.dart';
import 'package:meals_app/screens/recipe_detail_screen.dart';
import 'package:meals_app/services/favorite_recipes.dart';

class French extends StatefulWidget {
  final FavoriteRecipes favoriteRecipes;

  const French({Key? key, required this.favoriteRecipes}) : super(key: key);

  @override
  _FrenchState createState() => _FrenchState();
}

class _FrenchState extends State<French> {
  List<IngredientModel> _parseIngredients(dynamic ingredients) {
    if (ingredients is List<IngredientModel>) {
      return ingredients;
    }
    return [];
  }

  final logger = Logger();
  List<dynamic>? FrenchFoodData;

  @override
  void initState() {
    super.initState();
    fetchApiData();
  }

  Future<void> fetchApiData() async {
    try {
      const apiKey = '6f1ddfb53ff8435f8c045d2e2612dec6';
      const query = 'French food';
      final response = await http.get(
        Uri.parse(
          'https://api.spoonacular.com/recipes/complexSearch?apiKey=$apiKey&query=$query',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        logger.d(data);
        setState(() {
          FrenchFoodData = data['results'] as List<dynamic>?;
        });
      } else {
        logger.e('Ошибка: HTTP статус ${response.statusCode}');
        logger.e('Ошибка: ${response.reasonPhrase}');
        throw Exception('Не удалось загрузить данные из API');
      }
    } catch (error, stackTrace) {
      logger.e('Ошибка: $error');
      logger.e('StackTrace: $stackTrace');
    }
  }

  Future<void> _navigateToRecipeDetail(dynamic recipe) async {
    final recipeDetails = await _fetchRecipeDetails(recipe['id']);
    final ingredients = _parseIngredients(
        recipeDetails['extendedIngredients'] as List<dynamic>);

    navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(
          title: recipeDetails['title'],
          imageUrl: recipeDetails['image'],
          recipeUrl: recipeDetails['sourceUrl'] ?? 'No URL available',
          ingredients: ingredients,
          instructions:
              recipeDetails['instructions'] ?? 'No instructions available',
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchRecipeDetails(int recipeId) async {
    try {
      const apiKey = '6f1ddfb53ff8435f8c045d2e2612dec6';
      final response = await http.get(
        Uri.parse(
            'https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$apiKey'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['extendedIngredients'] is List) {
          final ingredients = (data['extendedIngredients'] as List)
              .map<IngredientModel>((ingredient) {
            return IngredientModel(
              name: ingredient['name'].toString(),
              amount: ingredient['amount'].toString(),
            );
          }).toList();

          data['extendedIngredients'] = ingredients;

          return data;
        } else {
          logger.e(
              'Ошибка: Формат данных extendedIngredients не является списком');
          throw Exception('Не удалось загрузить данные о рецепте');
        }
      } else {
        logger.e('Ошибка: HTTP статус ${response.statusCode}');
        logger.e('Ошибка: ${response.reasonPhrase}');
        throw Exception('Не удалось загрузить данные о рецепте');
      }
    } catch (error, stackTrace) {
      logger.e('Ошибка: $error');
      logger.e('StackTrace: $stackTrace');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('French Food'),
        ),
        body: FrenchFoodData == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: FrenchFoodData!.length,
                itemBuilder: (context, index) {
                  final item = FrenchFoodData![index];
                  return ListTile(
                    leading: item['image'] != null
                        ? Image.network(item['image'], width: 160, height: 160)
                        : const SizedBox(width: 160, height: 160),
                    title: Text(
                      item['title'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      item['summary'] ?? 'Click to see more information',
                      style: const TextStyle(
                        backgroundColor: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    trailing: IconButton(
                        icon: Icon(
                          widget.favoriteRecipes.isRecipeInFavorites(item['id'])
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (widget.favoriteRecipes
                              .isRecipeInFavorites(item['id'])) {
                            logger.d('Удаление из избранного: ${item['id']}');
                            widget.favoriteRecipes.removeRecipe(item['id']);
                          } else {
                            logger.d('Добавление в избранное: ${item['id']}');
                            final recipe = {
                              'id': item['id'],
                              'title': item['title'],
                              'imageURL': item['image'],
                            };
                            widget.favoriteRecipes.addRecipe(recipe);
                          }
                        }),
                    onTap: () => _navigateToRecipeDetail(item),
                  );
                },
              ));
  }
}
