import 'package:carousel_slider/carousel_slider.dart';
import 'package:client_app/main.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createstate() => _MyAppState();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widgetbuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carousel Slider"),
      ),
      body: content(),
    );
  }

  Widget content() {
    return Container(
        child: CarouselSlider(
            items: [1, 2, 3].map((i) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Text $i",
                  style: TextStyle(fontSize: 40),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 300,
            )));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
