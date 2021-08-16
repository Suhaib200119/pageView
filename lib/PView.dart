import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view/main.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data {
  final String? title;
  final String? description;
  final String? imageUrl;
  final IconData? iconData;

  Data(
      {required this.title,
      required this.description,
      required this.imageUrl,
      required this.iconData});
}

class PView extends StatefulWidget {
  @override
  _PViewState createState() => _PViewState();
}

class _PViewState extends State<PView> {
  List<Data> myData = [
    Data(
        title: "title 1",
        description: "Information > My Name is Suhiab , Programmer",
        imageUrl: "assets/images/q1.jpg",
        iconData: Icons.add),
    Data(
        title: "title 2",
        description: "Information > My Name is Suhiab , Programmer",
        imageUrl: "assets/images/q2.jpg",
        iconData: Icons.star),
    Data(
        title: "title 3",
        description: "Information > My Name is Suhiab , Programmer",
        imageUrl: "assets/images/q3.jpg",
        iconData: Icons.category),
    Data(
        title: "title 4",
        description: "Information > My Name is Suhiab , Programmer",
        imageUrl: "assets/images/q4.jpg",
        iconData: Icons.map),
  ];
  int indexPage = 0;
  PageController controller = new PageController(
    initialPage: 0,
  );
  final pageIndexNotifier = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/HomeScreen': (ctx) => MyHomePage(),
      },
      home: Scaffold(
        body: Stack(
          alignment: Alignment(0, 0.7),
          children: [
            Builder(builder: (ctxPageView) {
              return PageView(
                controller: controller,
                children: myData.map((item) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(item.imageUrl.toString()),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.iconData,
                          size: 130,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          item.title.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          item.description.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onPageChanged: (val) {
                  pageIndexNotifier.value = val;
                  setState(() {
                    indexPage = val;
                    // Future.delayed(Duration(seconds: 7), () {
                    //   if (indexPage == 3) {
                    //     Navigator.of(ctxPageView)
                    //         .pushReplacementNamed("/HomeScreen");
                    //   }
                    // });
                  });
                },
              );
            }),
            PageViewIndicator(
              pageIndexNotifier: pageIndexNotifier,
              length: myData.length,
              normalBuilder: (_, index) => Circle(
                size: 8.0,
                color: Colors.black87,
              ),
              highlightedBuilder: (animationController, _) =>
                  ScaleTransition(
                scale: CurvedAnimation(
                  parent: animationController,
                  curve: Curves.ease,
                ),
                child: Circle(
                  size: 12.0,
                  color: Colors.white,
                ),
              ),
            ),
            Builder(
              builder: (ctx) {
                return Align(
                  alignment: Alignment(0, 0.8),
                  child: RaisedButton(
                    color: Colors.orange,
                    textColor: Colors.white,
                    child: Text(
                      "Get Started",
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: ()async {
                      SharedPreferences shpr=await SharedPreferences.getInstance();
                      shpr.setBool('getStarted', true);
                      Navigator.of(ctx).pushReplacementNamed("/HomeScreen");
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
