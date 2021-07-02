import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Destination extends StatelessWidget {
  final String title;
  final String image;
  final String description;

  const Destination(this.title, this.image, this.description);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Image.network(this.image,fit: BoxFit.fill,),
              height: 250.0,
              width: 600.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              this.title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20.0),
            Text(this.description,textAlign: TextAlign.justify,)
          ],
        ),
      ),
    );
  }
}
