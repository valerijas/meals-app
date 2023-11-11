import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:meals_app/models/ingredient_model.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final String recipeUrl;
  final List<IngredientModel> ingredients;
  final String instructions;

  const RecipeDetailScreen({
    Key? key,
    required this.title,
    required this.recipeUrl,
    this.imageUrl,
    required this.ingredients,
    required this.instructions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(title, style: const TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: Colors.black,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl != null)
                Image.network(
                  imageUrl!,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16.0),
              const Text(
                'Ingredients:',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ingredients.map<Widget>((ingredient) {
                  final name = ingredient.name;
                  final amount = ingredient.amount;
                  return Text(
                    '$name - $amount',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Instructions:',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 8.0),
              Text(
                instructions.isNotEmpty
                    ? _cleanHtmlTags(instructions)
                    : 'No instructions available',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (recipeUrl != 'No URL available') {
                    final uri = Uri.parse(recipeUrl);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      throw 'Could not launch $recipeUrl';
                    }
                  }
                },
                child: const Text('View Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _cleanHtmlTags(String htmlString) {
    return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
  }
}
