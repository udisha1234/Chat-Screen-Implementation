import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class ChatController extends GetxController {
  var chatHistory = <dynamic>[].obs;
  TextEditingController searchbaritem = TextEditingController() ;
  var currentSuggestions =
      Rxn<List<dynamic>>(); // Use List<dynamic> for suggestions

  @override
  void onInit() {
    super.onInit();
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    try {
      // Load JSON file from assets
      String jsonString = await rootBundle.loadString('assets/chat_data.json');

      // Decode JSON data
      final Map<String, dynamic> decodedData = json.decode(jsonString);
      chatHistory.value = decodedData['chat_history'];

      // Update current suggestions if any
      if (chatHistory.isNotEmpty) {
        for (int i = 0; i < 3; i++) {
          final firstChatContent = chatHistory[i]['ai_response']['content'];

          // Manually iterate over firstChatContent
          for (var element in firstChatContent) {
            print("Element type: ${element['type']}");
            if (element['type'] == 'suggestions') {
              currentSuggestions.value = element['content'];
              print("Suggestions found: ${element['content']}");
              break;
            }
          }
        }
      }
    } catch (e) {
      print("Error loading chat data: $e");
    }
  }
}
