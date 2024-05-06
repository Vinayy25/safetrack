import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:provider/provider.dart';
import 'package:safetrack/data_provider.dart';
import 'package:safetrack/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TransformerPageController controller = TransformerPageController();
  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<DataProvider>(context);

    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: we,
        height: he,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/trainwall.jpeg"), fit: BoxFit.cover)),
        child: Stack(alignment: Alignment.center, children: [
          TransformerPageView(
              physics: const BouncingScrollPhysics(),
              transformer: ScaleAndFadeTransformer(),
              pageController: controller,
              itemBuilder: (c, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: he * 0.12,
                    ),
                    Text("Keeping Tracks Clear\nKeeping Journeys Safe",
                        style: GoogleFonts.lato(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: Colors.white)),
                    SizedBox(height: he * 0.5),
                    const Text(
                      "On Track for Safety\nYour Eyes on the Rails",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                );
              },
              itemCount: 3),
          Positioned(
            left: we * 0.42,
            top: he * .84,
            child: SmoothPageIndicator(
              count: 3,
              effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.orangeAccent,
                  dotHeight: 9.5,
                  dotWidth: 9.5,
                  dotColor: Colors.white),
              controller: controller,
            ),
          ),
          SizedBox(
            height: he * 0.01,
          ),
          Positioned(
            left: we * 0.12,
            top: he * 0.89,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const CoffeePage(),
                          type: PageTransitionType.fade));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: EdgeInsets.symmetric(
                        horizontal: we * 0.3, vertical: 25),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40))),
                child: const Text("Let's monitor",
                    style: TextStyle(fontSize: 15, color: Colors.white))),
          ),
        ]),
      ),
    );
  }
}

class ScaleAndFadeTransformer extends PageTransformer {
  final double _scale;
  final double _fade;

  ScaleAndFadeTransformer({double fade = 0.2, double scale = 0.8})
      : _fade = fade,
        _scale = scale;

  @override
  Widget transform(Widget item, TransformInfo info) {
    double? position = info.position;
    // double scaleFactor = (1 - position!.abs()) * (1 - _scale);
    // double fadeFactor = (1 - position!.abs()) * (1 - _fade);
    double opacity = (1 - position!.abs()) * 1;
    // double scale = _scale + scaleFactor;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      opacity: opacity,
      child: item,
    );
  }
}
