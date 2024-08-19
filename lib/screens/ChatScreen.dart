import 'package:chat_app/widgets/searchBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/data_controller.dart';
import '../widgets/buildAiResponse.dart';
import '../widgets/suggestions.dart';
import '../widgets/userText.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          title: const Text(
            'CHAT SCREEN SAMPLE',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.01),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: chatController.chatHistory.length,
                    itemBuilder: (context, index) {
                      final chatItem = chatController.chatHistory[index];
                      final userQuestion = chatItem['user']['question'];
                      final aiResponseContent =
                          chatItem['ai_response']['content'];
                      print(
                          "Building chat item at index $index with question: $userQuestion");

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          userText("$userQuestion", h, w),
                          const SizedBox(height: 10),
                          buildAiResponse(aiResponseContent),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // Suggestions section
              Obx(() {
                print("Checking suggestions...");
                if (chatController.currentSuggestions.value != null) {
                  print(
                      'Suggestions found: ${chatController.currentSuggestions.value}');

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ask Follow Up:",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      ...buildSuggestions(
                          chatController.currentSuggestions.value!),
                    ],
                  );
                } else {
                  print("No suggestions available.");
                  return const SizedBox.shrink();
                }
              }),

              // Search bar
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SearchBarWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
