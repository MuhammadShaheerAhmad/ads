import 'package:flutter/foundation.dart';

class CardSelectionModel extends ChangeNotifier {
  String _selectedCardDescription = '';
  String _selectedCardImageUrl = "";

  String get selectedCardDescription => _selectedCardDescription;

  void setSelectedCardDescription(String description) {
    _selectedCardDescription = description;
    notifyListeners();
  }

  String get selectedCardImageUrl => _selectedCardImageUrl; // Add this getter

  void setSelectedCardImageUrl(String imageUrl) {
    _selectedCardImageUrl = imageUrl;
    notifyListeners();
  }
}
