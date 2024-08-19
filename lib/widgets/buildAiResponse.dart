import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildAiResponse(List<dynamic> aiResponseContent) {
  List<InlineSpan> inlineSpans = [];

  for (var contentItem in aiResponseContent) {
    // if it is a normal text data
    if (contentItem['type'] == 'text') {
      for (var textItem in contentItem['content']) {
        inlineSpans.add(TextSpan(
          text: textItem['text'],
          style: const TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
        ));
        if (textItem['attribution'] != null) {
          inlineSpans.add(_buildAttribution(textItem['attribution']));
        }
      }
    }
    // if it is an image data
    else if (contentItem['type'] == 'image') {
      try {
        inlineSpans.add(WidgetSpan(
            child: InkWell(
          onTap: () async {
            final Uri _url = Uri.parse(contentItem['content']);
            if (!await launchUrl(_url)) {
              throw Exception('Could not launch $_url');
            }
          },
          child: Text(
            '[Image: ${contentItem['alt_text'] ?? 'No description'}]',
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 14,
            ),
          ),
        )));
        if (contentItem['attribution'] != null) {
          inlineSpans.add(_buildAttribution(contentItem['attribution']));
        }
      } catch (e) {
        inlineSpans.add(const TextSpan(
          text: 'Error loading image',
          style: TextStyle(color: Colors.red),
        ));
      }
    }
  }

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Container(
      decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.grey),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(2),
            bottomRight: Radius.circular(20),
          )),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 15),
            children: inlineSpans,
          ),
        ),
      ),
    ),
  );
}

InlineSpan _buildAttribution(Map<String, dynamic> attribution) {
  return WidgetSpan(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Source: ${attribution['source']}",
          style:
              const TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
        ),
        InkWell(
          onTap: () async {
            final Uri _url = Uri.parse(attribution['url']);
            if (!await launchUrl(_url)) {
              throw Exception('Could not launch $_url');
            }
          },
          child: Padding(
            padding: EdgeInsets.only(right: 5),
            child: Text(
              attribution['url'],
              style: const TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
            ),
          ),
        ),
      ],
    ),
  );
}


