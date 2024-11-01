import 'package:flutter/material.dart';
import 'package:foodbar/screens/food_detail_screen.dart';

class FoodScreen extends StatelessWidget {
  final List foods;

  const FoodScreen({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(child: Text("Halal Certified Food")),
          foregroundColor: Colors.white,
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return TextButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailScreen(food: foods[index]),
                  ),
                )
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.black54),
                  child: Center(
                    child: Text(
                      foods[index].name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}

// ListView.builder(
//         itemCount: foods.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(foods[index].name),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => FoodDetailScreen(food: foods[index]),
//                 ),
//               );
//             },
//           );
//         },
//       ),