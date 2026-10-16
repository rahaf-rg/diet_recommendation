import 'package:flutter/material.dart';

class ProgressPage extends StatefulWidget {
  final String currentWeight;
  final String goal;

  const ProgressPage({
    super.key,
    required this.currentWeight,
    required this.goal,
  });

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  static const Color primaryPink = Color(0xFFE91E63);
  static const Color lightPink = Color(0xFFFFF7FA);
  static const Color softPink = Color(0xFFFCE4EC);

  late TextEditingController weightController;

  late double currentWeight;
  late double startingWeight;
  late double targetWeight;

  final List<double> weightHistory = [];

  @override
  void initState() {
    super.initState();


    currentWeight =
        double.tryParse(widget.currentWeight) ?? 0;

    startingWeight = currentWeight;

    targetWeight = calculateTargetWeight();

    weightController = TextEditingController(
      text: currentWeight > 0
          ? currentWeight.toStringAsFixed(1)
          : "",
    );

    if (currentWeight > 0) {
      weightHistory.add(currentWeight);
    }
  }

  @override
  void didUpdateWidget(covariant ProgressPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentWeight != widget.currentWeight) {
      final newWeight =
          double.tryParse(widget.currentWeight) ?? 0;

      setState(() {
        currentWeight = newWeight;
        startingWeight = newWeight;
        targetWeight = calculateTargetWeight();

        if (newWeight > 0 &&
            (weightHistory.isEmpty ||
                weightHistory.last != newWeight)) {
          weightHistory.add(newWeight);
        }
      });

      weightController.text = newWeight > 0
          ? newWeight.toStringAsFixed(1)
          : "";
    } else if (oldWidget.goal != widget.goal) {
      setState(() {
        targetWeight = calculateTargetWeight();
      });
    }
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  double calculateTargetWeight() {
    if (currentWeight <= 0) {
      return 0;
    }

    if (widget.goal == "Lose Weight") {
      return currentWeight > 5
          ? currentWeight - 5
          : currentWeight;
    }

    if (widget.goal == "Gain Weight") {
      return currentWeight + 5;
    }

    if (widget.goal == "Build Muscle") {
      return currentWeight + 2;
    }

    return currentWeight;
  }

  double calculateProgress() {
    if (currentWeight <= 0 ||
        startingWeight <= 0 ||
        targetWeight <= 0) {
      return 0;
    }

    if (widget.goal == "Lose Weight") {
      final difference =
          startingWeight - targetWeight;

      if (difference <= 0) {
        return 1;
      }

      final progress =
          (startingWeight - currentWeight) /
              difference;

      return progress.clamp(0.0, 1.0);
    }

    if (widget.goal == "Gain Weight" ||
        widget.goal == "Build Muscle") {
      final difference =
          targetWeight - startingWeight;

      if (difference <= 0) {
        return 1;
      }

      final progress =
          (currentWeight - startingWeight) /
              difference;

      return progress.clamp(0.0, 1.0);
    }

    return 1;
  }

  String getProgressMessage() {
    final progress = calculateProgress();

    if (widget.goal == "Maintain Weight") {
      return "Keep your weight consistent.";
    }

    if (progress >= 1) {
      return "Great job! You reached your target! 🎉";
    }

    if (progress >= 0.7) {
      return "You're very close to your target! 💪";
    }

    if (progress >= 0.3) {
      return "Great progress! Keep going! 💗";
    }

    return "Every step counts. Stay consistent! 🌸";
  }

  void addWeight() {
    final newWeight =
    double.tryParse(weightController.text.trim());

    if (newWeight == null || newWeight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter a valid weight.",
          ),
        ),
      );

      return;
    }

    setState(() {
      currentWeight = newWeight;
      weightHistory.add(newWeight);
    });

    weightController.text =
        newWeight.toStringAsFixed(1);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Weight updated successfully!",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = calculateProgress();

    return Scaffold(
      backgroundColor: lightPink,

      appBar: AppBar(
        title: const Text(
          "Progress",
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
              "Your Progress",
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "Track your weight and stay consistent.",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 25),

            // Main Progress Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                color: primaryPink,
                borderRadius: BorderRadius.circular(22),

                boxShadow: [
                  BoxShadow(
                    color:
                    primaryPink.withOpacity(0.20),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Current Weight",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    currentWeight > 0
                        ? "${currentWeight.toStringAsFixed(1)} kg"
                        : "--",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Progress",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),

                      Text(
                        "${(progress * 100).round()}%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  ClipRRect(
                    borderRadius:
                    BorderRadius.circular(10),

                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor:
                      Colors.white30,
                      valueColor:
                      const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Weight Information
            Row(
              children: [
                Expanded(
                  child: weightInfoCard(
                    title: "Starting",
                    value: startingWeight,
                    icon: Icons.flag_outlined,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: weightInfoCard(
                    title: "Target",
                    value: targetWeight,
                    icon: Icons.track_changes,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // Goal
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(18),

                boxShadow: [
                  BoxShadow(
                    color:
                    primaryPink.withOpacity(0.06),
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

                    decoration:
                    const BoxDecoration(
                      color: softPink,
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.flag_outlined,
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
                          "Your Goal",
                          style: TextStyle(
                            color:
                            Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          widget.goal,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // Progress Message
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: softPink,
                borderRadius:
                BorderRadius.circular(16),
              ),

              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.favorite,
                    color: primaryPink,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      getProgressMessage(),
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Add Weight
            const Text(
              "Update Today's Weight",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: weightController,
                    keyboardType:
                    const TextInputType.numberWithOptions(
                      decimal: true,
                    ),

                    decoration: InputDecoration(
                      labelText: "Weight (kg)",
                      prefixIcon: const Icon(
                        Icons.monitor_weight_outlined,
                        color: primaryPink,
                      ),

                      filled: true,
                      fillColor: Colors.white,

                      focusedBorder:
                      OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(15),
                        borderSide:
                        const BorderSide(
                          color: primaryPink,
                          width: 2,
                        ),
                      ),

                      enabledBorder:
                      OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(15),
                        borderSide:
                        BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: addWeight,

                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:
                      primaryPink,
                      foregroundColor:
                      Colors.white,

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(15),
                      ),
                    ),

                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // History
            const Text(
              "Weight History",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (weightHistory.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.circular(16),
                ),

                child: Text(
                  "No weight records yet.",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

            ...weightHistory.reversed
                .toList()
                .asMap()
                .entries
                .map(
                  (entry) {
                final index = entry.key;
                final weight =
                    entry.value;

                return Container(
                  width: double.infinity,

                  margin:
                  const EdgeInsets.only(
                    bottom: 10,
                  ),

                  padding:
                  const EdgeInsets.all(16),

                  decoration:
                  BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(
                      16,
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: primaryPink
                            .withOpacity(0.05),
                        blurRadius: 7,
                        offset:
                        const Offset(0, 3),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      Container(
                        width: 45,
                        height: 45,

                        decoration:
                        const BoxDecoration(
                          color: softPink,
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.monitor_weight,
                          color:
                          primaryPink,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Text(
                              index == 0
                                  ? "Latest"
                                  : "Previous",
                              style: TextStyle(
                                color: Colors
                                    .grey
                                    .shade600,
                                fontSize: 12,
                              ),
                            ),

                            const SizedBox(
                                height: 3),

                            Text(
                              "${weight.toStringAsFixed(1)} kg",
                              style:
                              const TextStyle(
                                fontSize: 16,
                                fontWeight:
                                FontWeight
                                    .bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget weightInfoCard({
    required String title,
    required double value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: primaryPink.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,

            decoration: const BoxDecoration(
              color: softPink,
              shape: BoxShape.circle,
            ),

            child: Icon(
              icon,
              color: primaryPink,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            value > 0
                ? "${value.toStringAsFixed(1)} kg"
                : "--",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}