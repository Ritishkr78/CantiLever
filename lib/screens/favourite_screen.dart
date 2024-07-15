// import 'package:flutter/cupertino.dart;'
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
// import 'package:home_made/model/constant.dart';
import 'package:home_made/model/share_recipe.dart';
// import 'package:home_made/screens/deails_screen.dart';
import 'package:home_made/widgets/custom_app_bar.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({required this.recipe, super.key});
  final String recipe;

  @override
  Widget build(BuildContext context) {
    var myBox = Hive.box('saved');
    final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const CustomAppBar(title: 'Favourites', back: false),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 8, left: 8),
        child: ValueListenableBuilder(
            valueListenable: myBox.listenable(),
            builder: (context, box, _) {
              return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    var data = box.values.toList();
                    return ListTile(
                      title: Container(
                        height: h * .085,
                        color: Colors.grey[100],
                        child: Row(
                          children: [
                            Expanded(flex: 3, child: Text(data[index])),
                            PopupMenuButton(
                              itemBuilder: (context) {
                                return const [
                                  PopupMenuItem(
                                    value: 'share',
                                    child: Text('share'),
                                  ),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Text('delete'),
                                  ),
                                  PopupMenuItem(
                                    value: 'view',
                                    child: Text('view'),
                                  ),
                                ];
                              },
                              onSelected: (String value) async {
                                if (value == 'delete') {
                                  deleteItem(index);
                                } else if (value == 'share') {
                                  ShareRecipe.share(data[index]);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }

  Future<void> deleteItem(int index) async {
    var myBox = Hive.box('saved');
    await myBox.deleteAt(index);
  }
}
