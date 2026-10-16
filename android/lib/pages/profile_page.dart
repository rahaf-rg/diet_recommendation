import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String age;
  final String height;
  final String weight;
  final String goal;
  final String gender;
  final String activity;
  final String foodPreference;

  final Function({
  required String newAge,
  required String newHeight,
  required String newWeight,
  required String newGoal,
  required String newGender,
  required String newActivity,
  required String newFoodPreference,
  }) onProfileUpdated;

  static const Color primaryPink = Color(0xFFE91E63);
  static const Color lightPink = Color(0xFFFFF7FA);
  static const Color softPink = Color(0xFFFCE4EC);

  const ProfilePage({
    super.key,
    required this.age,
    required this.height,
    required this.weight,
    required this.goal,
    required this.gender,
    required this.activity,
    required this.foodPreference,
    required this.onProfileUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPink,

      appBar: AppBar(
        title: const Text(
          "Profile",
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
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: primaryPink,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: primaryPink.withOpacity(0.20),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                children: [
                  Container(
                    width: 85,
                    height: 85,

                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: primaryPink,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "My Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "Goal: $goal",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            profileItem(
              icon: Icons.cake_outlined,
              title: "Age",
              value: "$age years",
            ),

            profileItem(
              icon: Icons.height,
              title: "Height",
              value: "$height cm",
            ),

            profileItem(
              icon: Icons.monitor_weight_outlined,
              title: "Weight",
              value: "$weight kg",
            ),

            profileItem(
              icon: Icons.person_outline,
              title: "Gender",
              value: gender,
            ),

            const SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Lifestyle",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            profileItem(
              icon: Icons.directions_run,
              title: "Activity Level",
              value: activity,
            ),

            profileItem(
              icon: Icons.restaurant_menu,
              title: "Food Preference",
              value: foodPreference,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        age: age,
                        height: height,
                        weight: weight,
                        goal: goal,
                        gender: gender,
                        activity: activity,
                        foodPreference: foodPreference,
                        onSave: onProfileUpdated,
                      ),
                    ),
                  );
                },

                icon: const Icon(Icons.edit),

                label: const Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPink,
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget profileItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: primaryPink.withOpacity(0.06),
            blurRadius: 8,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
}


// ============================================================
// EDIT PROFILE PAGE
// ============================================================

class EditProfilePage extends StatefulWidget {
  final String age;
  final String height;
  final String weight;
  final String goal;
  final String gender;
  final String activity;
  final String foodPreference;

  final Function({
  required String newAge,
  required String newHeight,
  required String newWeight,
  required String newGoal,
  required String newGender,
  required String newActivity,
  required String newFoodPreference,
  }) onSave;

  const EditProfilePage({
    super.key,
    required this.age,
    required this.height,
    required this.weight,
    required this.goal,
    required this.gender,
    required this.activity,
    required this.foodPreference,
    required this.onSave,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  static const Color primaryPink = Color(0xFFE91E63);
  static const Color lightPink = Color(0xFFFFF7FA);

  late TextEditingController ageController;
  late TextEditingController heightController;
  late TextEditingController weightController;

  late String selectedGoal;
  late String selectedGender;
  late String selectedActivity;
  late String selectedFood;

  final List<String> goals = [
    "Lose Weight",
    "Maintain Weight",
    "Gain Weight",
    "Build Muscle",
  ];

  final List<String> genders = [
    "Male",
    "Female",
  ];

  final List<String> activities = [
    "Low",
    "Moderate",
    "High",
  ];

  final List<String> foods = [
    "No Preference",
    "Vegetarian",
    "High Protein",
  ];

  @override
  void initState() {
    super.initState();

    ageController = TextEditingController(text: widget.age);
    heightController = TextEditingController(text: widget.height);
    weightController = TextEditingController(text: widget.weight);

    selectedGoal = goals.contains(widget.goal)
        ? widget.goal
        : "Maintain Weight";

    selectedGender = genders.contains(widget.gender)
        ? widget.gender
        : "Male";

    selectedActivity = activities.contains(widget.activity)
        ? widget.activity
        : "Low";

    selectedFood = foods.contains(widget.foodPreference)
        ? widget.foodPreference
        : "No Preference";
  }

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  void saveProfile() {
    if (ageController.text.trim().isEmpty ||
        heightController.text.trim().isEmpty ||
        weightController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all personal information."),
        ),
      );
      return;
    }

    widget.onSave(
      newAge: ageController.text.trim(),
      newHeight: heightController.text.trim(),
      newWeight: weightController.text.trim(),
      newGoal: selectedGoal,
      newGender: selectedGender,
      newActivity: selectedActivity,
      newFoodPreference: selectedFood,
    );

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profile updated successfully!"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightPink,

      appBar: AppBar(
        title: const Text(
          "Edit Profile",
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
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Update your information",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "You can change your personal information and preferences here.",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Personal Information",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            editTextField(
              controller: ageController,
              label: "Age",
              icon: Icons.cake_outlined,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 15),

            editTextField(
              controller: heightController,
              label: "Height (cm)",
              icon: Icons.height,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 15),

            editTextField(
              controller: weightController,
              label: "Weight (kg)",
              icon: Icons.monitor_weight_outlined,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 25),

            dropdownField(
              label: "Gender",
              icon: Icons.person_outline,
              value: selectedGender,
              items: genders,
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            const Text(
              "Goal",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedGoal,
              decoration: inputDecoration(
                label: "Select your goal",
                icon: Icons.flag_outlined,
              ),
              items: goals
                  .map(
                    (goal) => DropdownMenuItem(
                  value: goal,
                  child: Text(goal),
                ),
              )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedGoal = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            dropdownField(
              label: "Activity Level",
              icon: Icons.directions_run,
              value: selectedActivity,
              items: activities,
              onChanged: (value) {
                setState(() {
                  selectedActivity = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            dropdownField(
              label: "Food Preference",
              icon: Icons.restaurant_menu,
              value: selectedFood,
              items: foods,
              onChanged: (value) {
                setState(() {
                  selectedFood = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 58,

              child: ElevatedButton.icon(
                onPressed: saveProfile,

                icon: const Icon(Icons.save_outlined),

                label: const Text(
                  "Save Changes",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPink,
                  foregroundColor: Colors.white,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget editTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required TextInputType keyboardType,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,

      decoration: inputDecoration(
        label: label,
        icon: icon,
      ),
    );
  }

  Widget dropdownField({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,

      decoration: inputDecoration(
        label: label,
        icon: icon,
      ),

      items: items
          .map(
            (item) => DropdownMenuItem(
          value: item,
          child: Text(item),
        ),
      )
          .toList(),

      onChanged: onChanged,
    );
  }

  InputDecoration inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,

      prefixIcon: Icon(
        icon,
        color: primaryPink,
      ),

      filled: true,
      fillColor: Colors.white,

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: primaryPink,
          width: 2,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }
}