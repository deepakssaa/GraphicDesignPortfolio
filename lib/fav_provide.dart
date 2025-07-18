import 'package:flutter/material.dart';

class FavProvider extends ChangeNotifier {
  // Duplicate list named 'favourites'
  List<Map<String, dynamic>> favourites = [];

  // Add to favourites list
  void addfav(Map<String, dynamic> addThing) {
    bool isAlreadyAdded = favourites.any(
      (element) => element['title'] == addThing['title'],
    );

    if (!isAlreadyAdded) {
      favourites.add(addThing);
      notifyListeners();
    }
  }

  // Remove from favourites list
  void removefav(Map<String, dynamic> removeThing) {
    favourites.removeWhere(
      (element) => element['title'] == removeThing['title'],
    );
    notifyListeners();
  }
}
