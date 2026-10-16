import 'package:flutter/material.dart';
import 'models/user_profile.dart';
import 'pages/home_page.dart';
import 'pages/recommendation_page.dart';
import 'pages/progress_page.dart';
import 'pages/profile_page.dart';
import 'profile_storage.dart';

class MainNavigation extends StatefulWidget {
  final UserProfile profile;

  const MainNavigation({
    super.key,
    required this.profile,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late UserProfile profile;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    profile = widget.profile;
  }

  @override
  void didUpdateWidget(covariant MainNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.profile != widget.profile) {
      profile = widget.profile;
    }
  }

  Future<void> updateProfile(UserProfile newProfile) async {
    // تحديث البيانات في واجهة التطبيق
    setState(() {
      profile = newProfile;
    });

    // حفظ البيانات الجديدة على الجهاز
    try {
      await ProfileStorage.saveProfile(newProfile);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not save profile changes. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        key: const ValueKey('home'),
        age: profile.age,
        height: profile.height,
        weight: profile.weight,
        goal: profile.goal,
        gender: profile.gender,
        activity: profile.activity,
        foodPreference: profile.foodPreference,
      ),
      RecommendationPage(
        key: const ValueKey('meals'),
        age: int.tryParse(profile.age) ?? 0,
        height: double.tryParse(profile.height) ?? 0.0,
        weight: double.tryParse(profile.weight) ?? 0.0,
        goal: profile.goal,
        gender: profile.gender,
        activity: profile.activity,
        foodPreference: profile.foodPreference,
      ),

      ProgressPage(
        key: const ValueKey('progress'),
        currentWeight: profile.weight,
        goal: profile.goal,
      ),
      ProfilePage(
        key: const ValueKey('profile'),
        age: profile.age,
        height: profile.height,
        weight: profile.weight,
        goal: profile.goal,
        gender: profile.gender,
        activity: profile.activity,
        foodPreference: profile.foodPreference,
        onProfileUpdated: ({
          required String newAge,
          required String newHeight,
          required String newWeight,
          required String newGoal,
          required String newGender,
          required String newActivity,
          required String newFoodPreference,
        }) {
          updateProfile(
            profile.copyWith(
              age: newAge,
              height: newHeight,
              weight: newWeight,
              goal: newGoal,
              gender: newGender,
              activity: newActivity,
              foodPreference: newFoodPreference,
            ),
          );
        },
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: const Color(0xFFE91E63),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Meals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}