import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'description_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scrollBehavior: ScrollBehavior().copyWith(dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.touch,
        }),
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api = "f9524ed4891601ac7538bf32a9867367";
  List<Map<String, String>> movies = [];
  List<Map<String, String>> movies2 = [];
  List<Map<String, String>> movies3 = [];
  var result;

  void getMovies() async {
    final uri = Uri(
        scheme: "http",
        host: "api.themoviedb.org",
        path: "/3/movie/now_playing",
        queryParameters: {
          "api_key": api,
        });
    final uri2 = Uri(
        scheme: "http",
        host: "api.themoviedb.org",
        path: "/3/movie/popular",
        queryParameters: {
          "api_key": api,
        });
    final uri3 = Uri(
        scheme: "http",
        host: "api.themoviedb.org",
        path: "/3/movie/top_rated",
        queryParameters: {
          "api_key": api,
        });
    late final res, res2, res3;
    try {
      res = await http.get(uri);
      res2 = await http.get(uri2);
      res3 = await http.get(uri3);
    } catch (_) {
      print(_);
      final snackBar = SnackBar(
        content: Text('Could not connect to wifi'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    final body = jsonDecode(res.body);
    final body2 = jsonDecode(res2.body);
    final body3 = jsonDecode(res3.body);
    print(uri);
    print((body["results"] as List).length);
    print(uri2);
    print((body2["results"] as List).length);
    print(uri3);
    print((body3["results"] as List).length);
    final newMovies = body["results"] as List;
    final newMovies2 = body2["results"] as List;
    final newMovies3 = body3["results"] as List;
    for (int i = 0; i < newMovies.length; i++) {
      final movie = newMovies[i];
      Map<String, String> movieMap = {
        "title": movie["title"],
        "image_url": movie['backdrop_path'],
        "description": movie['overview'],
      };
      movies.add(movieMap);
      setState(() {});
    }
    for (int i = 0; i < newMovies2.length; i++) {
      final movie2 = newMovies2[i];
      Map<String, String> movieMap2 = {
        "title": movie2["title"],
        "image_url": movie2['backdrop_path'],
        "description": movie2['overview'],
      };
      movies2.add(movieMap2);
      setState(() {});
    }
    for (int i = 0; i < newMovies3.length; i++) {
      final movie3 = newMovies3[i];
      Map<String, String> movieMap3 = {
        "title": movie3["title"],
        "image_url": movie3['backdrop_path'],
        "description": movie3['overview'],
      };
      movies3.add(movieMap3);
      setState(() {});
    }
  }

  @override
  void initState() {
    getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Movie App",
          style: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Now Playing",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18,
                  ),
                ),
                Container(
                  height: 140,
                  child: ListView.builder(
                    itemCount: movies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Map<String, String> movie = movies[index];
                      String url = movie["image_url"].toString();
                      if (movies.length == 0)
                        return Container(child: Text("No movies to display"));
                      return GestureDetector(
                        onTap: () {
                          print("Tapped ${movie['title']}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DescriptionPage(
                                      clickedMovie: movie,
                                    )),
                          );
                        },
                        child: Column(children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.all(10),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w500$url",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                              width: 100,
                              alignment: Alignment.center,
                              child: Text(
                                "${movie['title']}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ]),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Trending",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18,
                  ),
                ),
                Container(
                  height: 140,
                  child: ListView.builder(
                    itemCount: movies2.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Map<String, String> movie = movies2[index];
                      String url = movie["image_url"].toString();
                      return GestureDetector(
                        onTap: () {
                          print("Tapped ${movie['title']}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DescriptionPage(
                                      clickedMovie: movie,
                                    )),
                          );
                        },
                        child: Column(children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.all(10),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w500$url",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                              width: 100,
                              alignment: Alignment.center,
                              child: Text(
                                "${movie['title']}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ]),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Top Rated",
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18,
                  ),
                ),
                Container(
                  height: 140,
                  child: ListView.builder(
                    itemCount: movies3.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Map<String, String> movie = movies3[index];
                      String url = movie["image_url"].toString();
                      return GestureDetector(
                        onTap: () {
                          print("Tapped ${movie['title']}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DescriptionPage(
                                      clickedMovie: movie,
                                    )),
                          );
                        },
                        child: Column(children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.all(10),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w500$url",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                              width: 100,
                              alignment: Alignment.center,
                              child: Text(
                                "${movie['title']}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                        ]),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// api key
// f9524ed4891601ac7538bf32a9867367import 'dart:convert';
