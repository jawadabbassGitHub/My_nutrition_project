import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sculptress",
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const MyHomePage(),
    );
  }
}

var bannerItems = ["Homos", "avocado salad", "naye", "roz_3a_jej", "taboule"];
var bannerImages = <String>[
  "images/homos.jpg",
  "images/images.jpeg",
  "images/naye.jpg",
  "images/roz_wjej.jpg",
  "images/taboule.jpg",
];

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    Future<List<Widget>> createList() async {
      List<Widget> items = [];
      String dataString = await rootBundle.loadString("assets/data.json"); // Use rootBundle to load assets
      List<dynamic> dataJson = jsonDecode(dataString);

      dataJson.forEach((object) {
        dynamic placeNameData = object["placeName"];
        String finalString = "";

        if (placeNameData is List<dynamic>) {
          finalString = placeNameData.join("  |  ");
        } else if (placeNameData is String) {
          finalString = placeNameData;
        }

        items.add(
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2.0,
                    blurRadius: 5.0,
                  ),
                ],
              ),
              margin: EdgeInsets.all(5.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(object["placeImage"], width: 80, fit: BoxFit.cover),
                  ),
                  SizedBox(
                    width: 250,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                           Text(object["placeName"]),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(finalString, overflow:TextOverflow.ellipsis ,style: TextStyle(fontSize: 12.0, color: Colors.black54), maxLines: 1),
                          ),
                          Text("Min. Order: ${object["minOrder"]}", style: TextStyle(fontSize: 12.0, color: Colors.black54)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
      return items;
    }


    return Scaffold(
      body: SizedBox(
        height: screenHeight,
        width: screenWidth,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.menu), onPressed: () {}),
                      Text(
                        "Sculptress Foodies",
                        style: GoogleFonts.italianno(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.person),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                BannerWidgetArea(),
                Container(
                  child: FutureBuilder(
                    initialData: <Widget>[Text("")],
                    future: createList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ListView(
                            primary: false,
                            shrinkWrap: true,
                            children: snapshot.data!,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},
        backgroundColor: Colors.green,
      child: Icon(MdiIcons.food,color: Colors.white,)),
    );
  }
}

class BannerWidgetArea extends StatelessWidget {
  BannerWidgetArea({Key? key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    PageController controller = PageController(initialPage: 1, viewportFraction: 0.8);
    List<Widget> banners = [];

    for (int x = 0; x < bannerItems.length; x++) {
      var bannerView = Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),
                child: Image.asset(bannerImages[x], fit: BoxFit.cover),
              ),
              Column(
                children: <Widget>[
                  Text(bannerItems[x]),
                  Text("more than 40% off", style: TextStyle(fontSize: 12.0, color: Colors.black54)),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      bannerItems[x],
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    Text(
                      "more than 40% off",
                      style: TextStyle(fontSize: 12.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      banners.add(bannerView);
    }

    return Container(
      width: screenWidth,
      height: screenHeight * 9 / 16,
      child: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: banners,
      ),
    );
  }
}
