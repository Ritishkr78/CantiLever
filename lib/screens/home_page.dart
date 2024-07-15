import 'package:flutter/material.dart';
import 'package:home_made/screens/favourite_screen.dart';
// import 'package:home_made/screens/search_screen.dart';

import 'package:home_made/widgets/home_page_screen.dart';
import 'package:home_made/navigators/bottom_nav_bar.dart';
import 'package:home_made/widgets/recipe_category.dart';
// import 'package:home_made/model/search.dart';
// import 'package:home_made/model/app_bare.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late PageController pageController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
          onTap: (index) {
            pageController.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut);
            setState(() {
              currentIndex = index;
            });
          },
          selectedItem: currentIndex),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePageScreen(),
          RecipeCategory(),
          SavedScreen(recipe: ''),
        ],
      ),
    );
  }
}
