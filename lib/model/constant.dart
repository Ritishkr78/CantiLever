import 'dart:convert';
import 'package:http/http.dart' as http;

class ConstantFunction {
  static Future<List<Map<String, dynamic>>> getResponse(
      String findRecipe) async {
    String api =
        'https://newsapi.org/v2/everything?q=$findRecipe&apiKey=2e7d1d12fbc5425aba604925323075b7';
    final response = await http.get(Uri.parse(api));
    List<Map<String, dynamic>> recipe = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['articles'] != null) {
        for (var article in data['articles']) {
          recipe.add(article['recipe']);
        }
      }
      return recipe;
    }
    return recipe;
  }
}
