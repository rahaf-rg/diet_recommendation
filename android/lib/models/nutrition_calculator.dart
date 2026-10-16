
class NutritionCalculator {
  /// حساب مؤشر كتلة الجسم BMI
  static double calculateBMI({
    required double weight,
    required double height,
  }) {
    if (weight <= 0 || height <= 0) {
      return 0;
    }

    final heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  /// حساب معدل الحرق الأساسي BMR
  static double calculateBMR({
    required int age,
    required double weight,
    required double height,
    required String gender,
  }) {
    final baseValue = (10 * weight) + (6.25 * height) - (5 * age);

    if (gender == 'Male') {
      return baseValue + 5;
    }

    return baseValue - 161;
  }

  /// حساب السعرات اليومية التقديرية حسب النشاط والهدف
  static double calculateCalories({
    required int age,
    required double weight,
    required double height,
    required String gender,
    required String activity,
    required String goal,
  }) {
    final bmr = calculateBMR(
      age: age,
      weight: weight,
      height: height,
      gender: gender,
    );

    final activityMultiplier = switch (activity) {
      'Low' => 1.2,
      'Moderate' => 1.55,
      'High' => 1.725,
      _ => 1.2,
    };

    var calories = bmr * activityMultiplier;

    if (goal == 'Lose Weight') {
      calories -= 300;
    } else if (goal == 'Gain Weight') {
      calories += 300;
    }

    return calories > 0 ? calories : 0;
  }
}