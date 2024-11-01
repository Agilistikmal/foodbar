import 'package:flutter/material.dart';
import 'package:foodbar/model/food_model.dart';

class FoodDetailScreen extends StatelessWidget {
  final Food food;
  const FoodDetailScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Detail"),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              food.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            food.certificate != null
                ? Text("Nomor Sertifikat: ${food.certificate}")
                : const Text("Sertifikat tidak ditemukan")
          ],
        ),
      ),
    );
  }
}
