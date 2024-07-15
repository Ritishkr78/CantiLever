import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:home_made/items/ingredient_item.dart';
import 'package:home_made/items/start_cooking.dart';
import 'package:home_made/model/share_recipe.dart';
import 'package:home_made/model/show_detail_dialog.dart';
import 'package:home_made/model/show_table.dart';
import 'package:home_made/widgets/circle_button.dart';
import 'package:home_made/model/custom_clip_path.dart';
import 'package:home_made/items/ingredient_list.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({required this.item, super.key});
  final Map<String, dynamic> item;
  @override
  State<DetailsScreen> createState() {
    return _DetailsScreenState();
  }
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var myBox = Hive.box('saved');
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    String time = widget.item['totalTime'].toString();
    String items = widget.item['ingredients'].length.toString();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: h * .44,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.item['image']),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: h * .04,
                  left: w * .05,
                  child: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 160, 75, 14),
                    child: BackButton(color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * .04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.item['label'],
                    style: TextStyle(
                      fontSize: w * .05,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Text('$time min'),
                  SizedBox(
                    height: h * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            ShareRecipe.share(widget.item['url']);
                          },
                          child: const CircleButton(
                              color: Colors.white,
                              icon: Icons.share,
                              label: 'Share')),
                      ValueListenableBuilder(
                          valueListenable: myBox.listenable(),
                          builder: (context, box, _) {
                            String key = widget.item['label'];
                            bool saved = myBox.containsKey(key);
                            if (saved) {
                              return GestureDetector(
                                onTap: () {
                                  myBox.delete(key);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text('Recipe Deleted')),
                                  );
                                },
                                child: const CircleButton(
                                    color: Color.fromARGB(255, 233, 10, 10),
                                    icon: Icons.favorite,
                                    label: 'Saved'),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  myBox.put(key, key);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        duration: Duration(seconds: 1),
                                        content:
                                            Text('Recipe added to favourites')),
                                  );
                                },
                                child: const CircleButton(
                                    color: Colors.white,
                                    icon: Icons.favorite_border,
                                    label: 'love this'),
                              );
                            }
                          }),
                      GestureDetector(
                        onTap: () {
                          ShowDetailDialog.showCalories(
                              widget.item['totalNutrients'], context);
                        },
                        child: const CircleButton(
                            color: Colors.white,
                            icon: Icons.monitor_heart_outlined,
                            label: 'Calories'),
                      ),
                      GestureDetector(
                        onTap: () {
                          ShowTable.showTable(context);
                        },
                        child: const CircleButton(
                            color: Colors.white,
                            icon: Icons.table_chart_outlined,
                            label: 'unit chart'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Direction',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: w * .06,
                        ),
                      ),
                      SizedBox(
                        width: w * .34,
                        child: ElevatedButton(
                            onPressed: () {
                              StartCooking.startCooking(widget.item['url']);
                            },
                            child: const Text('Start')),
                      )
                    ],
                  ),
                  SizedBox(
                    height: h * .02,
                  ),
                  Container(
                    height: h * .07,
                    width: w,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: ClipPath(
                            clipper: CustomClipPath(),
                            child: Container(
                              color: Colors.redAccent,
                              child: Center(
                                child: Text(
                                  'Ingredients Required',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: w * .05,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  '$items items required',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * 1.8,
                    child: IngredientList(
                      ingredients: widget.item['ingredients'],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
