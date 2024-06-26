import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:safetrack/model/itemscoffee.dart';
import 'package:safetrack/pages/payment.dart';
import 'package:safetrack/utils.dart';

enum Size {
  Small,
  Medium,
  Large,
}

class SellingPage extends StatefulWidget {
  ItemCoffee itemCoffee;
  SellingPage({Key? key, required this.itemCoffee}) : super(key: key);

  @override
  _SellingPageState createState() => _SellingPageState();
}

class _SellingPageState extends State<SellingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _priceofcoffee;

  Size selectedSize = Size.Small;
  int number = 40;
  double price = 0.5;
  int numercount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _priceofcoffee = Tween(begin: 0.0, end: price).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    Timer(const Duration(milliseconds: 850), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: we,
          height: he + 200,
          child: Stack(
            children: [
              Container(
                width: we * 12,
                height: he * 0.38,
                padding: EdgeInsets.only(bottom: we * 0.4),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(65)),
                  gradient: LinearGradient(
                      colors: [Color(0xFF613502), Color(0xFF3C1F0A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                      width: we * 0.65,
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: he * 0.47),
                child: Column(
                  children: [
                    FadeIn(
                      delay: const Duration(milliseconds: 400),
                      child: Container(
                        width: 70,
                        height: 40,
                        margin: EdgeInsets.only(right: we * 0.75),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(25)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(
                              width: we * 0.02,
                            ),
                            Text(
                              widget.itemCoffee.star.toString(),
                              style: const TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: we * 0.04),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: he * 0.07,
                          ),
                          FadeIn(
                            delay: const Duration(milliseconds: 700),
                            child: Text(
                              widget.itemCoffee.name,
                              style: GoogleFonts.lato(
                                  color: Colors.black,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: we * 0.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: he * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: we * .7),
                      child: FadeIn(
                        delay: const Duration(milliseconds: 950),
                        child: const Text(
                          "Emergency",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: he * 0.012,
                    ),
                    FadeInRight(
                      delay: const Duration(seconds: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = Size.Small;
                                  numercount = 1;
                                  number = 40;
                                });
                                _controller.reset();
                                _controller.forward();
                              },
                              child: _buildsized(
                                  "Today",
                                  selectedSize == Size.Small
                                      ? const Color(0xFFD59B6B)
                                      : Colors.grey.withOpacity(0.1),
                                  selectedSize == Size.Small
                                      ? Colors.white
                                      : Colors.black)),
                          SizedBox(
                            width: we * 0.04,
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = Size.Medium;
                                  numercount = 1;
                                  number = 50;
                                });
                                _controller.reset();
                                _controller.forward();
                              },
                              child: _buildsized(
                                  "Yesterday",
                                  selectedSize == Size.Medium
                                      ? const Color(0xFFD59B6B)
                                      : Colors.grey.withOpacity(0.1),
                                  selectedSize == Size.Medium
                                      ? Colors.white
                                      : Colors.black)),
                          SizedBox(
                            width: we * 0.04,
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedSize = Size.Large;
                                  numercount = 1;
                                  number = 60;
                                });
                                _controller.reset();
                                _controller.forward();
                              },
                              child: _buildsized(
                                  "Day before",
                                  selectedSize == Size.Large
                                      ? const Color(0xFFD59B6B)
                                      : Colors.grey.withOpacity(0.1),
                                  selectedSize == Size.Large
                                      ? Colors.white
                                      : Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: he * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: we * .77),
                      child: FadeIn(
                        delay: const Duration(milliseconds: 1500),
                        child: const Text(
                          "Alerts",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: he * 0.01,
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: we * .27),
                        child: FadeIn(
                            delay: const Duration(milliseconds: 2000),
                            child: Container(
                              height: 300,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child:
                                    widget.itemCoffee.name != 'Matsyagandha Exp'
                                        ? const Text('Train not configured')
                                        : StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('notifications')
                                                .doc('test@gmail.com')
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  color: Colors.brown,
                                                ));
                                              } else {
                                                var data =
                                                    snapshot.data?.data();

                                                var alerts = data?['alert'];

                                                return ListView.builder(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    itemCount: alerts.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var alert = alerts[index];
                                                      var latitude =
                                                          alert['latitude'];
                                                      var longitude =
                                                          alert['longitude'];
                                                      var type = alert['type'];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: AppCard(
                                                            color: Colors.brown,
                                                            height: 150,
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                    'Train stopped due to $type',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                                Text(
                                                                    'Latitude: $latitude',
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                                Text(
                                                                  'Longitude: $longitude',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {},
                                                                        icon: const Icon(
                                                                            Icons.call)),
                                                                    IconButton(
                                                                        color: Colors
                                                                            .black,
                                                                        onPressed:
                                                                            () async {
                                                                          await FirebaseFirestore
                                                                              .instance
                                                                              .collection('notifications')
                                                                              .doc('test@gmail.com')
                                                                              .update({
                                                                            'alert':
                                                                                FieldValue.arrayRemove([
                                                                              alert
                                                                            ])
                                                                          });
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .check,
                                                                        ))
                                                                  ],
                                                                )
                                                              ],
                                                            )),
                                                      );
                                                    });
                                              }
                                            }),
                              ),
                            ))),
                    SizedBox(
                      height: he * 0.02,
                    ),
                    Expanded(child: SizedBox(height: he * 0.04)),
                  ],
                ),
              ),
              Positioned(
                left: 50,
                top: 90,
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      spreadRadius: 3,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(2, 10),
                      blurRadius: 60,
                    )
                  ]),
                  child: Hero(
                    tag: widget.itemCoffee.image,
                    child: Image.asset(
                      widget.itemCoffee.image,
                      width: 300,
                      height: 300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildsized(String text, Color coloricon, Color colortxt) {
    return Container(
      width: 105,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: coloricon, borderRadius: BorderRadius.circular(40)),
      child: Text(
        text,
        style: TextStyle(color: colortxt),
      ),
    );
  }
} //