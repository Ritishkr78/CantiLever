import 'package:flutter/material.dart';
import 'package:news_app/widget/text_search_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: w * .06,
              letterSpacing: 2,
              color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 233, 44, 44),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: h * .016, horizontal: w * .032),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextFieldWidget(),
            SizedBox(
              height: h * .04,
            ),
            Text(
              'Search Tags',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: w * .06),
            ),
            Wrap(
                spacing: 8,
                children: tags.map((label) {
                  return ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => AllRecipe(recipe: label)),
                        // );
                      },
                      child: Text(label));
                }).toList()),
          ],
        ),
      ),
    );
  }
}

List tags = [
  'General',
  'Indian',
  'USA',
  'BBC',
  'CNN',
  'Global',
];
