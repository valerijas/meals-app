Create homepage and buttons in main.dart.
Create folder widgets and new file drawer.dart to add drawer to main screen. Then we need to create new files for screens "Home" and "CreatingProcess" in folder "pages".
Now we need to create folder "pages" and create new files for each button in the main screen.
Now we need to import this new pages to "main.dart" and bind it to our buttons.
Creating folder "services" and new file "api.dart" and "api_services.dart".
Now we need to connect your Flutter application to the Spoonacular API.We need it to take information about meals.
We need the "http" and "webview_flutter".
"webview" allows us to view web pages within our app and "http" Allows us to send requests to API to get data. Open openning pubspec.yaml file and adding the dependency.
Then, run "flutter pub get" to fetch the package.
You can create functions to make API requests to Spoonacular.
Creating new folder "models" and new file in it "meal_model.dart" , "meal_plan_model.dart", "ingredient_model.dart" and "recipe_model.dart".
create new folder "screens" and new files "meals_screen.dart", "recipe_screen.dart" ,"search_screen.dart" and "recipe_detail_screen.dart".
Now we need to create folder "lists" and create "list" for each button to see information about recipes as image and name.
Now we need to create function "Add to favorites". Create new file "favorite_recipes.dart" in folder "services".
And create new file "favorites.dart" in folder "pages" for our favorite list of recipes.