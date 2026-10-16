import 'package:flutter/material.dart';
import 'recommendation_page.dart';
import '../models/nutrition_calculator.dart';

class HomePage extends StatelessWidget {
  final String age;
  final String height;
  final String weight;
  final String goal;
  final String gender;
  final String activity;
  final String foodPreference;

  static const Color primaryPink = Color(0xFFE91E63);
  static const Color lightPink = Color(0xFFFFF7FA);
  static const Color softPink = Color(0xFFFCE4EC);

  const HomePage({
    super.key,
    required this.age,
    required this.height,
    required this.weight,
    required this.goal,
    required this.gender,
    required this.activity,
    required this.foodPreference,
  });

  double calculateBMI() {
    final double heightValue = double.tryParse(height) ?? 0;
    final double weightValue = double.tryParse(weight) ?? 0;

    return NutritionCalculator.calculateBMI(
      weight: weightValue,
      height: heightValue,
    );
  }

  double calculateBMR() {
    final double ageValue = double.tryParse(age) ?? 0;
    final double heightValue = double.tryParse(height) ?? 0;
    final double weightValue = double.tryParse(weight) ?? 0;

    return NutritionCalculator.calculateBMR(
      age: ageValue.round(),
      weight: weightValue,
      height: heightValue,
      gender: gender,
    );
  }

  double calculateCalories() {
    final double ageValue = double.tryParse(age) ?? 0;
    final double heightValue = double.tryParse(height) ?? 0;
    final double weightValue = double.tryParse(weight) ?? 0;

    return NutritionCalculator.calculateCalories(
      age: ageValue.round(),
      weight: weightValue,
      height: heightValue,
      gender: gender,
      activity: activity,
      goal: goal,
    );
  }
  String getBMIStatus(double bmi) {
    if (bmi <= 0) return "Not available";
    if (bmi < 18.5) return "Underweight";
    if (bmi < 25) return "Normal weight";
    if (bmi < 30) return "Overweight";
    return "Obesity range";
  }

  @override
  Widget build(BuildContext context) {
    final double bmi = calculateBMI();
    final double calories = calculateCalories();

    return Scaffold(
      backgroundColor: lightPink,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          "Diet AI",
          style: TextStyle(
            color: primaryPink,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none,
              color: primaryPink,
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 25),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome
            const Text(
              "Welcome back! 👋",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              "Let's keep working toward your goal.",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 25),

            // Goal Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: primaryPink,
                borderRadius: BorderRadius.circular(22),

                boxShadow: [
                  BoxShadow(
                    color: primaryPink.withValues(alpha: 0.20),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Goal",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    goal,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 20,
                      ),

                      SizedBox(width: 7),

                      Text(
                        "Stay consistent!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Stats
            const Text(
              "Your Health Overview",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: statCard(
                    icon: Icons.monitor_weight_outlined,
                    title: "BMI",
                    value: bmi > 0
                        ? bmi.toStringAsFixed(1)
                        : "--",
                    subtitle: getBMIStatus(bmi),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: statCard(
                    icon: Icons.local_fire_department,
                    title: "Calories",
                    value: calories > 0
                        ? calories.round().toString()
                        : "--",
                    subtitle: "kcal / day",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // User Details
            const Text(
              "Your Details",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            detailCard(
              icon: Icons.directions_run,
              title: "Activity Level",
              value: activity,
            ),

            detailCard(
              icon: Icons.restaurant_menu,
              title: "Food Preference",
              value: foodPreference,
            ),

            const SizedBox(height: 15),

            // Meal Plan
            const Text(
              "Today's Meal Plan 🍽️",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            mealPreview(
              icon: Icons.free_breakfast,
              title: "Breakfast",
              meal: "Eggs, whole grain bread & vegetables",
            ),

            mealPreview(
              icon: Icons.apple,
              title: "Morning Snack",
              meal: "Apple & almonds",
            ),

            mealPreview(
              icon: Icons.restaurant,
              title: "Lunch",
              meal: "Grilled chicken, rice & salad",
            ),

            mealPreview(
              icon: Icons.local_cafe,
              title: "Afternoon Snack",
              meal: "Greek yogurt & fruit",
            ),

            mealPreview(
              icon: Icons.dinner_dining,
              title: "Dinner",
              meal: "Tuna, bread & vegetables",
            ),

            const SizedBox(height: 10),

            // View Full Plan
            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>

                          RecommendationPage(
                            age: int.tryParse(age) ?? 0,
                            height: double.tryParse(height) ?? 0.0,
                            weight: double.tryParse(weight) ?? 0.0,
                            goal: goal,
                            gender: gender,
                            activity: activity,
                            foodPreference: foodPreference,
                          ),

                    ),
                  );
                },

                icon: const Icon(
                  Icons.restaurant_menu,
                ),

                label: const Text(
                  "View Full Meal Plan",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPink,
                  foregroundColor: Colors.white,
                  elevation: 2,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: primaryPink.withValues(alpha:0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,

            decoration: const BoxDecoration(
              color: softPink,
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: primaryPink,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget detailCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 10),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),

        boxShadow: [
          BoxShadow(
            color: primaryPink.withValues(alpha:0.05),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,

            decoration: const BoxDecoration(
              color: softPink,
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: primaryPink,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget mealPreview({
    required IconData icon,
    required String title,
    required String meal,
  }) {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),

        boxShadow: [
          BoxShadow(
            color: primaryPink.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,

            decoration: const BoxDecoration(
              color: softPink,
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: primaryPink,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  meal,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}