import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:home_made/model/constant.dart';
import 'package:home_made/screens/deails_screen.dart';
// import 'package:home_made/widgets/custom_app_bar.dart';

class AllRecipe extends StatelessWidget {
  const AllRecipe({required this.recipe, super.key});
  final String recipe;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 233, 44, 44),
        title: Text(
          recipe,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: w * .06,
              letterSpacing: 2,
              color: Colors.white),
        ),
      ),
      body: FutureBuilder(
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
            return Padding(
              padding: EdgeInsets.only(
                right: w * .034,
                left: w * .034,
                top: h * .03,
              ),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 10,
                      childAspectRatio: .6 / 1),
                  itemBuilder: (context, index) {
                    Map<String, dynamic> snap = snapshot.data![index];
                    int time = snap['totalTime'].toInt();
                    return Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Stack(
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
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              snap['image'],
                                            ),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 7,
                                    left: 15,
                                    child: Container(
                                      height: 20,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          '${time.toString()}min',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, left: 6),
                              child: Text(
                                snap['label'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: w * .03),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            );
          }),
    );
  }
}
