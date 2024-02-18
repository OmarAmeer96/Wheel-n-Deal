import 'package:flutter/material.dart';
import 'package:flutter_easy_faq/flutter_easy_faq.dart';

class AppFaqViewBody extends StatelessWidget {
  const AppFaqViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyFaq(
          question: "question?",
          answer: "answer.",
        ),
      ],
    );
  }
}
