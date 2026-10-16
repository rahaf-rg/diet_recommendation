import 'package:flutter/material.dart';

import 'pages/health_page.dart';
import 'models/user_profile.dart';
import 'profile_storage.dart';
import 'main_navigation.dart';


void main() {
  runApp(const DietApp());
}

class DietApp extends StatelessWidget {
  const DietApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diet AI',

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE91E63)),

        fontFamily: 'Roboto',

        scaffoldBackgroundColor: const Color(0xFFFFF7FA),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Color(0xFFE91E63), width: 2),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE91E63),
            foregroundColor: Colors.white,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),

      home: const StartupPage(),
    );
  }
}
class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  late Future<UserProfile?> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = ProfileStorage.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfile?>(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text(
                'Could not load your saved profile.',
              ),
            ),
          );
        }

        final profile = snapshot.data;

        if (profile != null) {
          return MainNavigation(profile: profile);
        }

        return const WelcomePage();
      },
    );
  }
}

// ==========================================================
// Welcome Page
// ==========================================================

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  String? selectedGoal;

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🌸 Pink background
      backgroundColor: const Color(0xFFFFF7FA),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        title: const Text(
          "Diet AI",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color(0xFFE91E63),
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🌸 Icon
              Center(
                child: Container(
                  width: 110,
                  height: 110,

                  decoration: BoxDecoration(
                    color: const Color(0xFFFCE4EC),
                    shape: BoxShape.circle,
                  ),

                  child: const Icon(
                    Icons.restaurant_menu,
                    size: 55,
                    color: Color(0xFFE91E63),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Center(
                child: Text(
                  "Find Your Best Diet",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 10),

              Center(
                child: Text(
                  "Tell us about yourself and we will\n"
                  "suggest a suitable diet for you.",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              const Text(
                "Personal Information",

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 18),

              // Age
              buildTextField(
                controller: ageController,
                label: "Age",
                icon: Icons.cake_outlined,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 15),

              // Height
              buildTextField(
                controller: heightController,
                label: "Height (cm)",
                icon: Icons.height,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 15),

              // Weight
              buildTextField(
                controller: weightController,
                label: "Weight (kg)",
                icon: Icons.monitor_weight_outlined,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 25),

              const Text(
                "What is your goal?",

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                initialValue: selectedGoal,

                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.flag_outlined,
                    color: Color(0xFFE91E63),
                  ),

                  labelText: "Select your goal",

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),

                items: const [
                  DropdownMenuItem(
                    value: "Lose Weight",
                    child: Text("Lose Weight"),
                  ),

                  DropdownMenuItem(
                    value: "Maintain Weight",
                    child: Text("Maintain Weight"),
                  ),

                  DropdownMenuItem(
                    value: "Gain Weight",
                    child: Text("Gain Weight"),
                  ),

                  DropdownMenuItem(
                    value: "Build Muscle",
                    child: Text("Build Muscle"),
                  ),
                ],

                onChanged: (value) {
                  setState(() {
                    selectedGoal = value;
                  });
                },
              ),

              const SizedBox(height: 35),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 58,

                child: ElevatedButton(
                  onPressed: () {
                    if (ageController.text.isEmpty ||
                        heightController.text.isEmpty ||
                        weightController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all information"),
                        ),
                      );

                      return;
                    }

                    if (selectedGoal == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select your goal"),
                        ),
                      );

                      return;
                    }

                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => HealthPage(
                          age: ageController.text,
                          height: heightController.text,
                          weight: weightController.text,
                          goal: selectedGoal!,
                        ),
                      ),
                    );
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE91E63),
                    foregroundColor: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  child: const Text(
                    "Continue",

                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  "Your information will be used to personalize\n"
                  "your dietary recommendations.",

                  textAlign: TextAlign.center,

                  style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required TextInputType keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,

      decoration: InputDecoration(
        labelText: label,

        prefixIcon: Icon(icon, color: const Color(0xFFE91E63)),

        filled: true,
        fillColor: Colors.white,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFE91E63), width: 2),
        ),
      ),
    );
  }
}

// ==========================================================
// Recommendation Page
// ==========================================================

class RecommendationPage extends StatelessWidget {
  final double bmi;
  final String goal;
  final String foodPreference;

  const RecommendationPage({
    super.key,
    required this.bmi,
    required this.goal,
    required this.foodPreference,
  });

  String get recommendation {
    if (goal == "Lose Weight") {
      if (foodPreference == "Vegetarian") {
        return "Vegetarian Balanced Diet";
      }

      if (foodPreference == "High Protein") {
        return "High Protein Weight Loss Diet";
      }

      return "Balanced Weight Loss Diet";
    }

    if (goal == "Build Muscle") {
      return "High Protein Muscle Building Diet";
    }

    if (goal == "Gain Weight") {
      return "High Calorie Balanced Diet";
    }

    return "Balanced Maintenance Diet";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7FA),

      appBar: AppBar(
        title: const Text("Your Recommendation"),

        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🌸 Pink Icon
            Container(
              width: 120,
              height: 120,

              decoration: const BoxDecoration(
                color: Color(0xFFFCE4EC),
                shape: BoxShape.circle,
              ),

              child: const Icon(Icons.eco, size: 60, color: Color(0xFFE91E63)),
            ),

            const SizedBox(height: 25),

            const Text(
              "Your BMI",

              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),

            const SizedBox(height: 5),

            Text(
              bmi.toStringAsFixed(1),

              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,

                color: Color(0xFFE91E63),
              ),
            ),

            const SizedBox(height: 30),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: Colors.white,

                borderRadius: BorderRadius.circular(20),

                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withValues(alpha: 0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Column(
                children: [
                  const Text(
                    "Recommended Diet",

                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    recommendation,

                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,

                      color: Color(0xFFE91E63),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "Based on your goal and food preference.",

                    textAlign: TextAlign.center,

                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 58,

              child: ElevatedButton(
                onPressed: () {
                  // سنضيف Meal Plan لاحقًا
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE91E63),
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                child: const Text(
                  "View Meal Plan",

                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
