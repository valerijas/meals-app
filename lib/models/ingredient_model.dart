class IngredientModel {
  final String name;
  final String amount;

  IngredientModel({
    required this.name,
    required this.amount,
  });

  static IngredientModel fromMap(Map<String, dynamic> map) {
    return IngredientModel(
      name: map['name'],
      amount: map['amount'],
    );
  }
}
