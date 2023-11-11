import 'dart:convert';
import 'package:http/http.dart' as http;

String apiKey = '6f1ddfb53ff8435f8c045d2e2612dec6';

Future<Map<String, dynamic>> fetchRecipe(int recipeId) async {
  final response = await http.get(
    Uri.parse(
        'https://api.spoonacular.com/recipes/$recipeId/information?apiKey=$apiKey'),
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load recipe');
  }
}
