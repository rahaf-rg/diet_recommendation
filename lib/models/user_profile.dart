import 'dart:convert';

class UserProfile {
final String age;
final String height;
final String weight;
final String goal;
final String gender;
final String activity;
final String foodPreference;

UserProfile({
required this.age,
required this.height,
required this.weight,
required this.goal,
required this.gender,
required this.activity,
required this.foodPreference,
});

// تحويل بيانات المستخدم إلى نص JSON للتخزين
String toJsonString() {
return jsonEncode({
'age': age,
'height': height,
'weight': weight,
'goal': goal,
'gender': gender,
'activity': activity,
'foodPreference': foodPreference,
});
}

// استرجاع بيانات المستخدم من نص JSON
factory UserProfile.fromJsonString(String jsonString) {
final Map<String, dynamic> data = jsonDecode(jsonString);

return UserProfile(
age: data['age'] as String,
height: data['height'] as String,
weight: data['weight'] as String,
goal: data['goal'] as String,
gender: data['gender'] as String,
activity: data['activity'] as String,
foodPreference: data['foodPreference'] as String,
);
}

UserProfile copyWith({
String? age,
String? height,
String? weight,
String? goal,
String? gender,
String? activity,
String? foodPreference,
}) {
return UserProfile(
age: age ?? this.age,
height: height ?? this.height,
weight: weight ?? this.weight,
goal: goal ?? this.goal,
gender: gender ?? this.gender,
activity: activity ?? this.activity,
foodPreference: foodPreference ?? this.foodPreference,
);
}
}
