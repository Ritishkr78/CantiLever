import 'package:flutter/material.dart';
import 'package:home_made/items/ingredient_item.dart';

class IngredientList extends StatelessWidget {
  const IngredientList({required this.ingredients, super.key});
  final List<dynamic> ingredients;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const ScrollPhysics(
          parent: NeverScrollableScrollPhysics(),
        ),
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          int quantity = ingredients[index]['quantity'].toInt() ?? 1;

          return IngredientItem(
            quantity: quantity.toString(),
            food: ingredients[index]['food'] ?? '',
            measure: ingredients[index]['measure'] ?? '',
            imageUrl: ingredients[index]['image'] ?? '',
          );
        });
  }
}
