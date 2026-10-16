import 'package:flutter/material.dart';
import '../models/nutrition_calculator.dart';
import '../models/food_items.dart';
import '../models/meal_recommender.dart';

class RecommendationPage extends StatelessWidget {
  final int age;
  final double height;
  final double weight;
  final String goal;
  final String gender;
  final String activity;
  final String foodPreference;

  const RecommendationPage({
    super.key,
    required this.age,
    required this.height,
    required this.weight,
    required this.goal,
    required this.gender,
    required this.activity,
    required this.foodPreference,
  });

  @override
  Widget build(BuildContext context) {
    final double bmi = NutritionCalculator.calculateBMI(
      weight: weight,
      height: height,
    );

    final double bmr = NutritionCalculator.calculateBMR(
      age: age,
      height: height,
      weight: weight,
      gender: gender,
    );

    final double dailyCalories = NutritionCalculator.calculateCalories(
      age: age,
      height: height,
      weight: weight,
      gender: gender,
      activity: activity,
      goal: goal,
    );

    final breakfastMeals = MealRecommender.getMeals(
      mealType: 'Breakfast',
      foodPreference: foodPreference,
      goal: goal,
    );


    final snackMeals = MealRecommender.getMeals(
      mealType: 'Snack',
      foodPreference: foodPreference,
      goal: goal,
    );

    final morningSnackMeals = snackMeals.isNotEmpty
        ? [snackMeals.first]
        : <FoodItem>[];

    final afternoonSnackMeals = snackMeals.length > 1
        ? [snackMeals[1]]
        : <FoodItem>[];

    final lunchMeals = MealRecommender.getMeals(
      mealType: 'Lunch',
      foodPreference: foodPreference,
      goal: goal,
    );


    final dinnerMeals = MealRecommender.getMeals(
      mealType: 'Dinner',
      foodPreference: foodPreference,
      goal: goal,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F8),
      appBar: AppBar(
        title: const Text(
          'Your Diet Plan',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFE91E63),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Health Summary 💗',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC2185B),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: infoCard(
                    title: 'BMI',
                    value: bmi.toStringAsFixed(1),
                    icon: Icons.monitor_weight_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: infoCard(
                    title: 'Daily Calories',
                    value: dailyCalories.toStringAsFixed(0),
                    icon: Icons.local_fire_department_outlined,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            infoCard(
              title: 'Daily Energy Used at Rest (BMR)',
              value: '${bmr.toStringAsFixed(0)} calories',
              icon: Icons.bedtime_outlined,
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFF8BBD0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Goal 🎯',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC2185B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    getRecommendedDiet(),
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    getDietReason(),
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Today's Meals 🍓",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC2185B),
              ),
            ),

            const SizedBox(height: 16),

            mealCard(
              icon: Icons.wb_sunny_outlined,
              title: 'Breakfast',
              color: const Color(0xFFFFD6E5),
              meals: breakfastMeals,
            ),

            mealCard(
              icon: Icons.coffee_outlined,
              title: 'Morning Snack',
              color: const Color(0xFFFFE8CC),
              meals: morningSnackMeals,
            ),

            mealCard(
              icon: Icons.lunch_dining_outlined,
              title: 'Lunch',
              color: const Color(0xFFD9F2E6),
              meals: lunchMeals,
            ),

            mealCard(
              icon: Icons.apple_outlined,
              title: 'Afternoon Snack',
              color: const Color(0xFFE4DDF8),
              meals: afternoonSnackMeals,
            ),

            mealCard(
              icon: Icons.nightlight_outlined,
              title: 'Dinner',
              color: const Color(0xFFD9E8FF),
              meals: dinnerMeals,
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE4EC),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                '💧 Remember to drink water throughout the day '
                'and choose portions that suit your needs.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Color(0xFFAD1457)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF8BBD0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFE91E63), size: 28),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC2185B),
            ),
          ),
        ],
      ),
    );
  }

  Widget mealCard({
    required IconData icon,
    required String title,
    required Color color,
    required List<FoodItem> meals,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF8BBD0)),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: Icon(icon, color: const Color(0xFFC2185B)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC2185B),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          if (meals.isEmpty)
            const Text(
              'No meals found for this preference.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            )
          else
            ...meals.map(
              (meal) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF5F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Serving: ${meal.servingGrams.toStringAsFixed(0)} g',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Calories: ${meal.calories.toStringAsFixed(0)} kcal',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Protein: ${meal.protein.toStringAsFixed(1)} g'
                      '   •   Carbs: ${meal.carbs.toStringAsFixed(1)} g'
                      '   •   Fat: ${meal.fat.toStringAsFixed(1)} g',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  String getRecommendedDiet() {
    switch (goal) {
      case 'Lose Weight':
        return 'A balanced diet with suitable portions and nutrient-rich foods.';
      case 'Maintain Weight':
        return 'A balanced diet that supports your daily energy needs.';
      case 'Gain Weight':
        return 'A balanced diet with enough energy and nutritious foods.';
      case 'Build Muscle':
        return 'A balanced diet with protein-rich foods to support muscle growth.';
      default:
        return 'A balanced diet suited to your personal goal.';
    }
  }

  String getDietReason() {
    switch (goal) {
      case 'Lose Weight':
        return 'Your plan prioritizes balanced choices and calorie awareness.';
      case 'Maintain Weight':
        return 'Your estimated calorie target is based on your profile and activity.';
      case 'Gain Weight':
        return 'Your plan favors foods that can help meet a higher energy target.';
      case 'Build Muscle':
        return 'Your plan prioritizes protein-containing foods alongside balanced meals.';
      default:
        return 'Choose varied foods and portions that fit your needs.';
    }
  }
}
