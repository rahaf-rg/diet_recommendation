import 'package:flutter/material.dart';
import '../main_navigation.dart';
import '../models/user_profile.dart';
import '../profile_storage.dart';

class HealthPage extends StatefulWidget {
  final String age;
  final String height;
  final String weight;
  final String goal;

  const HealthPage({
    super.key,
    required this.age,
    required this.height,
    required this.weight,
    required this.goal,
  });

  @override
  State<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  String? selectedGender;
  String? selectedActivity;
  String? selectedFood;

  // اللون الوردي الأساسي للتطبيق
  static const Color primaryPink = Color(0xFFE91E63);
  static const Color lightPink = Color(0xFFFFF7FA);
  // static const Color iconPink = Color(0xFFFCE4EC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPink,

      appBar: AppBar(
        title: const Text(
          "Health & Lifestyle",
          style: TextStyle(
            color: primaryPink,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: primaryPink,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Tell us more about you",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              "This information will help us find a suitable diet for you.",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Gender",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: primaryPink,
                ),
                labelText: "Select gender",
                labelStyle: const TextStyle(
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: primaryPink,
                    width: 2,
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Male",
                  child: Text("Male"),
                ),
                DropdownMenuItem(
                  value: "Female",
                  child: Text("Female"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              },
            ),

            const SizedBox(height: 25),

            const Text(
              "Activity Level",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.directions_run,
                  color: primaryPink,
                ),
                labelText: "Select activity level",
                labelStyle: const TextStyle(
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: primaryPink,
                    width: 2,
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Low",
                  child: Text("Low"),
                ),
                DropdownMenuItem(
                  value: "Moderate",
                  child: Text("Moderate"),
                ),
                DropdownMenuItem(
                  value: "High",
                  child: Text("High"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedActivity = value;
                });
              },
            ),

            const SizedBox(height: 25),

            const Text(
              "Food Preference",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.restaurant,
                  color: primaryPink,
                ),
                labelText: "Select preference",
                labelStyle: const TextStyle(
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: primaryPink,
                    width: 2,
                  ),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: "No Preference",
                  child: Text("No Preference"),
                ),
                DropdownMenuItem(
                  value: "Vegetarian",
                  child: Text("Vegetarian"),
                ),
                DropdownMenuItem(
                  value: "High Protein",
                  child: Text("High Protein"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedFood = value;
                });
              },
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(


                onPressed: () async {
                  if (selectedGender == null ||
                      selectedActivity == null ||
                      selectedFood == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please complete all health information'),
                      ),
                    );
                    return;
                  }

                  final profile = UserProfile(
                    age: widget.age,
                    height: widget.height,
                    weight: widget.weight,
                    goal: widget.goal,
                    gender: selectedGender!,
                    activity: selectedActivity!,
                    foodPreference: selectedFood!,
                  );

                  try {
                    await ProfileStorage.saveProfile(profile);
                    final savedProfile = await ProfileStorage.loadProfile();

                    debugPrint(
                      'Saved profile: ${savedProfile?.age}, '
                          '${savedProfile?.weight}',
                    );
                    if (!mounted) return;

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainNavigation(
                          profile: profile,
                        ),
                      ),
                    );
                  } catch (e) {
                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Could not save your profile. Please try again.',
                        ),
                      ),
                    );
                  }
                },


                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPink,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Get My Recommendation",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}