class ItemCoffee {
  String image;
  String name;
  double star;
  String currentlyAt;
  String nextStation;

  ItemCoffee({required this.image, required this.name,required this.currentlyAt, required this.nextStation, required this.star});
}

List<ItemCoffee> items = [
  ItemCoffee(image: "images/trainmain.png", name: "Matsyagandha Exp", star: 4.5,currentlyAt: 'Mangaluru', nextStation: '30 mins'),
  ItemCoffee(image: "images/train2.png", name: "MANGALURU EXP", star: 5, currentlyAt: 'Bombay', nextStation: '1 hour'),
  ItemCoffee(image: "images/train3.png", name: "KAWR YPR EXP", star: 4.8, currentlyAt: 'Kawr', nextStation: '10 mins'),
];

class Notification {
  bool isCrack;
  double latitude;
  double longitude;
  Notification(
      {required this.isCrack, required this.latitude, required this.longitude});
}

class NotificationsData {
  List<Notification> alerts;
  NotificationsData({required this.alerts});
//notificatons to json
  Map<String, dynamic> toJson() {
    return {
      'alerts': alerts
          .map((e) => {
                'isCrack': e.isCrack,
                'latitude': e.latitude,
                'longitude': e.longitude
              })
          .toList()
    };
  }
}
