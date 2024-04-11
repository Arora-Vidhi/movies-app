import 'package:flutter/material.dart';

class DescriptionPage extends StatefulWidget {

  const DescriptionPage({super.key, required this.clickedMovie});

  final Map<String, String> clickedMovie;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {

  @override
  Widget build(BuildContext context) {

    print("${widget.clickedMovie['title']}");
    String url = widget.clickedMovie["image_url"].toString();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.purple),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://image.tmdb.org/t/p/w500$url",
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                "${widget.clickedMovie['title']}",
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 22,
                  fontWeight:  FontWeight.bold,
                ),
              ),
            ),
            Text(
              "${widget.clickedMovie['description']}",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 17
                ),
            )
          ]
        ),
      ),
    );
  }
}