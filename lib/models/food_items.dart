
class FoodItem {
  final String id;
  final String name;
  final String mealType;
  final List<String> dietTypes;
  final double servingGrams;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;

  const FoodItem({
    required this.id,
    required this.name,
    required this.mealType,
    required this.dietTypes,
    required this.servingGrams,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });
}
