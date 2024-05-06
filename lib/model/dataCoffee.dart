class Coffees {
  String icocImage;
  String title;
  bool _isRunning;

  bool get isRunning => _isRunning;

  set isRunning(bool value) {
    _isRunning = value;
  }
  Coffees({required bool isRunning, required this.icocImage, required this.title}) : _isRunning = isRunning;
}

List<Coffees> coffess = [
  Coffees(icocImage: "images/trainmain.png", title: "udupi", isRunning: true),
  Coffees(icocImage: "images/train2.png", title: "Mumbai", isRunning: false ),
  Coffees(icocImage: "images/train3.png", title: "Hubli",isRunning: false),
];
