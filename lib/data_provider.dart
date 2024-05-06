import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataProvider extends ChangeNotifier {
  DataProvider() {
    print("init...");
    checkNewValues();
  }

  void checkNewValues() async {
    FirebaseFirestore.instance
        .collection('notifications')
        .doc(
            'alert@gmail.com') // Replace 'sourceDocument' with your source document ID
        .snapshots()
        .listen((DocumentSnapshot snapshot) async {
      print('running..');
      // Check if the source document exists and has data
      if (snapshot.exists) {
        // Get the data from the source document
        Map<String, String> sourceData = {};
        sourceData['latitude'] = snapshot['latitude'];
        sourceData['longitude'] = snapshot['longitude'];
        sourceData['type'] = snapshot['type'];
        
        print(sourceData);
        // Update the target document using the data from the source document
        await updateTargetDocument(sourceData).then((value) {
          print('done shifting data');
        });
      } else {  
        print('snapshot doesnt exist');
      }

      FirebaseFirestore.instance
          .collection('notifications')
          .doc('alerts@gmail.com')
          .delete();
    });
  }

  Future<void> updateTargetDocument(Map<String, dynamic> sourceData) async {
    // Fetch the existing data from the target document
    DocumentSnapshot targetSnapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .doc('test@gmail.com') // Replace with your target document ID
        .get();

    if (targetSnapshot.exists) {
      // Get the existing data from the target document
      Map<String, dynamic> targetData =
          targetSnapshot.data() as Map<String, dynamic>;

      // Check if the 'alerts' array already exists in the target data
      List<dynamic> alerts = targetData['alert'] ?? [];

      // Add the new values from the source data to the 'alerts' array
      alerts.add(sourceData);

      // Update the 'alerts' array in the target data
      targetData['alert'] = alerts;

      // Update the target document with the modified data
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc('test@gmail.com') // Replace with your target document ID
          .set(targetData) // Update the target document with the modified data
          .then((_) {
        print("Target document updated successfully");
      }).catchError((error) {
        print("Failed to update target document: $error");
      });
    } else {
      print("Target document does not exist");
    }
  }
}
