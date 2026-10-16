
import 'food_database.dart';
import 'food_items.dart';

class MealRecommender {
  static List<FoodItem> getMeals({
    required String mealType,
    required String foodPreference,
    required String goal,
  }) {
    final matchingMeals = FoodDatabase.foods.where((food) {
      // اختيار نوع الوجبة المطلوب.
      if (food.mealType != mealType) {
        return false;
      }

      // فلترة الوجبات حسب التفضيل الغذائي.
      if (foodPreference == 'Vegetarian' &&
          !food.dietTypes.contains('Vegetarian')) {
        return false;
      }

      if (foodPreference == 'High Protein' &&
          !food.dietTypes.contains('High Protein')) {
        return false;
      }

      // No Preference: لا نضيف فلترة غذائية.
      return true;
    }).toList();

    // ترتيب النتائج حسب هدف المستخدم.
    if (goal == 'Build Muscle') {
      matchingMeals.sort(
            (a, b) => b.protein.compareTo(a.protein),
      );
    } else if (goal == 'Lose Weight') {
      matchingMeals.sort(
            (a, b) => a.calories.compareTo(b.calories),
      );
    } else if (goal == 'Gain Weight') {
      matchingMeals.sort(
            (a, b) => b.calories.compareTo(a.calories),
      );
    }

    return matchingMeals;
  }
}
