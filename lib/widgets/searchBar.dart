import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/data_controller.dart';

class SearchBarWidget extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SearchBar(
        textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 14 , color: Colors.grey)),
        controller: chatController.searchbaritem,
        elevation: WidgetStatePropertyAll(1),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: 0.5, color: Colors.grey)),
        ),
        leading: Icon(Icons.search_rounded , color: Colors.grey,),
        hintText: "ask Storki!!",
        hintStyle: WidgetStatePropertyAll(TextStyle(color: Colors.grey)),
        trailing: [
          Icon(Icons.attachment_rounded),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
            child: Icon(Icons.call),
          )
        ],
      ),
    );
  }
}
