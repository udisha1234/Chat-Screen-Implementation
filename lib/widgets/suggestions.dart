import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/data_controller.dart';

List<Widget> buildSuggestions(List<dynamic> suggestions) {
  final ChatController chatController = Get.put(ChatController());
  return suggestions.map((suggestion) {
    return GestureDetector(
      onTap: () {
        // Handle suggestion tap
        chatController.searchbaritem.text = suggestion.toString();
      },
      child: Text(
        "- "+suggestion,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey,
        ),
      ),
    );
  }).toList();
}
