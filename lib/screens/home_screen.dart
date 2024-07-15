import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news_channel_headline_model.dart';
import 'package:news_app/screens/category_screen.dart';
import 'package:news_app/screens/news_details_screen.dart';
import 'package:news_app/model/categories_news_model.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, indNews, independent, usa }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  FilterList? selectedMenu;

  final format = DateFormat('MMMM dd yyyy');
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height * 1;
    final w = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        // backgroundColor: Color.fromARGB(188, 255, 206, 58),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 10, 207, 125),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CategoryScreen()),
              );
            },
            icon: Image.asset(
              'assets/images/category_icon.png',
              height: 30,
              width: 30,
            ),
          ),
          title: Text(
            'Akhbar',
            style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 0, 0, 0)),
          ),
          actions: [
            PopupMenuButton<FilterList>(
              initialValue: selectedMenu,
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }
                if (FilterList.usa.name == item.name) {
                  name = 'new-york-magazine';
                }

                if (FilterList.indNews.name == item.name) {
                  name = 'google-news-in';
                }
                if (FilterList.independent.name == item.name) {
                  name = 'google-news';
                }
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<FilterList>>[
                const PopupMenuItem<FilterList>(
                    value: FilterList.bbcNews, child: Text('BBC News')),
                // const PopupMenuItem<FilterList>(
                //     value: FilterList.indNews, child: Text('India')),
                const PopupMenuItem<FilterList>(
                    value: FilterList.usa, child: Text('USA')),
                const PopupMenuItem<FilterList>(
                    value: FilterList.independent, child: Text('GLOBAL')),
              ],
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Top Headlines',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchScreen()),
                        );
                      },
                      icon: const Icon(CupertinoIcons.search_circle),
                      color: Colors.blue,
                      iconSize: 40.0,
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: h * .25,
                          width: w,
                          child: FutureBuilder<NewsChannelHeadlineModel>(
                            future:
                                newsViewModel.fetchNewsChannelHeadlineApi(name),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: SpinKitFadingCircle(
                                    size: 50,
                                    color: Colors.blue,
                                  ),
                                );
                              } else {
                                return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.articles!.length,
                                    itemBuilder: (context, index) {
                                      DateTime dateTime = DateTime.parse(
                                          snapshot.data!.articles![index]
                                              .publishedAt
                                              .toString());
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => NewsDetailsScreen(
                                                      newsImage: snapshot
                                                          .data!
                                                          .articles![index]
                                                          .urlToImage
                                                          .toString(),
                                                      newsTitle: snapshot
                                                          .data!
                                                          .articles![index]
                                                          .title
                                                          .toString(),
                                                      author: snapshot
                                                          .data!
                                                          .articles![index]
                                                          .author
                                                          .toString(),
                                                      newsDate:
                                                          dateTime.toString(),
                                                      description: snapshot
                                                          .data!
                                                          .articles![index]
                                                          .description
                                                          .toString(),
                                                      content: snapshot
                                                          .data!
                                                          .articles![index]
                                                          .content
                                                          .toString(),
                                                      source: snapshot.data!.articles![index].source!.name.toString())));
                                        },
                                        child: SizedBox(
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                height: h * .6,
                                                width: w * .9,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: h * .02),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: CachedNetworkImage(
                                                    imageUrl: snapshot
                                                        .data!
                                                        .articles![index]
                                                        .urlToImage
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            Container(
                                                      child: spinkit2,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                      Icons
                                                          .error_outline_outlined,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                child: Card(
                                                  elevation: 5,
                                                  color: const Color.fromARGB(
                                                      255, 228, 231, 233),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    height: h * .098,
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: w * .7,
                                                          child: Text(
                                                            snapshot
                                                                .data!
                                                                .articles![
                                                                    index]
                                                                .title
                                                                .toString(),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        SizedBox(
                                                          width: w * .7,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                snapshot
                                                                    .data!
                                                                    .articles![
                                                                        index]
                                                                    .source!
                                                                    .name
                                                                    .toString(),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                              Text(
                                                                format.format(
                                                                    dateTime),
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: h * .5,
                          width: w * 1.0,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: FutureBuilder<CategoriesNewsModel>(
                              future: newsViewModel
                                  .fetchCategoriesNewsApi('General'),
                              builder: (BuildContext context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: SpinKitFadingCircle(
                                      size: 50,
                                      color: Colors.blue,
                                    ),
                                  );
                                } else {
                                  return InkWell(
                                    child: SizedBox(
                                      height: h * .3,
                                      width: w * .3,
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemCount:
                                              snapshot.data!.articles!.length,
                                          itemBuilder: (context, index) {
                                            DateTime dateTime = DateTime.parse(
                                                snapshot.data!.articles![index]
                                                    .publishedAt
                                                    .toString());
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => NewsDetailsScreen(
                                                        newsImage: snapshot
                                                            .data!
                                                            .articles![index]
                                                            .urlToImage
                                                            .toString(),
                                                        newsTitle: snapshot
                                                            .data!
                                                            .articles![index]
                                                            .title
                                                            .toString(),
                                                        author: snapshot.data!.articles![index].author
                                                            .toString(),
                                                        newsDate:
                                                            dateTime.toString(),
                                                        description: snapshot
                                                            .data!
                                                            .articles![index]
                                                            .description
                                                            .toString(),
                                                        content: snapshot
                                                            .data!
                                                            .articles![index]
                                                            .content
                                                            .toString(),
                                                        source: snapshot
                                                            .data!
                                                            .articles![index]
                                                            .source!
                                                            .name
                                                            .toString()),
                                                  ),
                                                );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 15.0),
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: CachedNetworkImage(
                                                        height: h * .13,
                                                        width: w * .3,
                                                        imageUrl: snapshot
                                                            .data!
                                                            .articles![index]
                                                            .urlToImage
                                                            .toString(),
                                                        fit: BoxFit.cover,
                                                        placeholder:
                                                            (context, url) =>
                                                                Container(
                                                          child: spinkit2,
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                          Icons
                                                              .error_outline_outlined,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: w * .05,
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        height: h * .1,
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 12),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              snapshot
                                                                  .data!
                                                                  .articles![
                                                                      index]
                                                                  .title
                                                                  .toString(),
                                                              maxLines: 3,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  snapshot
                                                                      .data!
                                                                      .articles![
                                                                          index]
                                                                      .source!
                                                                      .name
                                                                      .toString(),
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  format.format(
                                                                      dateTime),
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black54,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
