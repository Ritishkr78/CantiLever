import 'package:flutter/material.dart';
import 'package:home_made/model/constant.dart';
import 'package:home_made/screens/deails_screen.dart';

class HomeTabBarView extends StatelessWidget {
  const HomeTabBarView({required this.recipe, super.key});
  final String recipe;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: ConstantFunction.getResponse(recipe),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text('no data'),
          );
        }
        return ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            Map<String, dynamic> snap = snapshot.data![index];
            int time = snap['totalTime'].toInt();
            int calories = snap['calories'].toInt();
            return Container(
              margin: EdgeInsets.only(right: w * .02),
              width: w * .5,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(item: snap)),
                          );
                        },
                        child: Container(
                          width: w,
                          height: h * .17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(snap['image']),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * .01,
                      ),
                      Text(
                        snap['label'],
                        style: TextStyle(
                          fontSize: w * .035,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: h * .002,
                      ),
                      Text(
                        "cal-${calories.toString()}  time-${time.toString()},",
                        style: TextStyle(
                          fontSize: w * .03,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 110, 47, 15),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            width: 15,
          ),
          itemCount: snapshot.data!.length,
        );
      },
    );
  }
}

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: const Color.fromARGB(0, 255, 255, 255),
            height: h * .05,
            child: TabBar(
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w800,
              ),
              unselectedLabelColor: const Color.fromARGB(255, 51, 18, 6),
              labelColor: const Color.fromARGB(255, 62, 28, 10),
              dividerColor: const Color.fromARGB(0, 255, 255, 255),
              indicator: BoxDecoration(
                color: const Color.fromARGB(255, 200, 123, 71),
                borderRadius: BorderRadius.circular(20),
              ),
              tabs: const [
                TabItem(title: 'Breakfast'),
                TabItem(title: 'Lunch'),
                TabItem(title: 'Dinner'),
                TabItem(title: 'Quick'),
              ],
            ),
          ),
          SizedBox(
            height: h * .02,
          ),
          SizedBox(
            height: h * .5,
            child: const TabBarView(
              children: [
                HomeTabBarView(recipe: 'breakfast'),
                HomeTabBarView(recipe: 'lunch'),
                HomeTabBarView(recipe: 'dinner'),
                HomeTabBarView(recipe: 'quick'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 175, 65, 10),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 9.5,
            ),
          ),
        ),
      ),
    );
  }
}
