import 'package:flutter/material.dart';
import 'package:home_made/screens/search_screen.dart';
import 'package:home_made/widgets/greet.dart';
import 'package:home_made/model/tab_bar_widget.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          centerTitle: false,
          leading: IconButton(
            style: IconButton.styleFrom(
              foregroundColor: const Color.fromARGB(0, 238, 234, 234),
            ),
            onPressed: () {},
            icon: const Icon(
              Icons.sort,
              size: 5.0,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: OutlinedButton.icon(
                iconAlignment: IconAlignment.start,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsetsDirectional.all(15),
                  backgroundColor: const Color.fromARGB(255, 207, 178, 162),
                  minimumSize: const Size(900, 10),
                  foregroundColor: const Color.fromARGB(255, 167, 80, 37),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchScreen()));
                },
                icon: const Icon(
                  Icons.search,
                ),
                label: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'what\'s cooking in your mind...',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color.fromARGB(222, 83, 42, 3),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/food.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Greet(),
                const SizedBox(
                  height: 1,
                ),
                const Text(
                  'What are You cooking Today ?',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(
                  height: h * .023,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'categories',
                        style: TextStyle(
                          fontSize: w * .045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Padding(
                      padding: EdgeInsets.only(right: 25.0),
                      child: Text(
                        'see all',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * .022,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const TabBarWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
