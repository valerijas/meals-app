import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoriteRecipes {
  List<Map<String, dynamic>> _favoriteRecipes = [];

  void addRecipe(Map<String, dynamic> recipe) {
    _favoriteRecipes.add(recipe);
  }

  void removeRecipe(int recipeId) {
    _favoriteRecipes.removeWhere((recipe) => recipe['id'] == recipeId);
  }

  bool isRecipeInFavorites(int recipeId) {
    return _favoriteRecipes.any((recipe) => recipe['id'] == recipeId);
  }

  List<int> getFavoriteRecipeIds() {
    return _favoriteRecipes.map((recipe) => recipe['id'] as int).toList();
  }

  Map<String, dynamic> getRecipeById(int recipeId) {
    final recipe = _favoriteRecipes.firstWhere(
        (recipe) => recipe['id'] == recipeId,
        orElse: () => Map<String, dynamic>());
    return recipe;
  }

  Future<Map<String, dynamic>> fetchRecipeDetails(int recipeId) async {
    final apiKey = '6f1ddfb53ff8435f8c045d2e2612dec6';
    final response = await http.get(
      Uri.parse(
        'https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Не удалось загрузить данные о рецепте');
    }
  }
}
