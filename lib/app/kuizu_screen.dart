import 'package:flutter/material.dart';
import 'package:kuizu/app/views/answer_view.dart';
import 'package:kuizu/app/views/question_view.dart';
import 'package:kuizu/model/answer_model.dart';
import 'package:kuizu/model/question_model.dart';

class KuizuScreen extends StatefulWidget {

  const KuizuScreen({ super.key });

  @override
  State<KuizuScreen> createState() => _KuizuScreenState();
}

class _KuizuScreenState extends State<KuizuScreen> {

  (QuestionWidget, AnswerWidget) questionAnswerView ({
    required Question question,
    required Answer answer,
  }){
    return switch(question){

      TextQuestion(:MultipleChoiceAnswer answer) => (
        TextQuestionWidget(textQuestion: question),
        MultipleChoiceWidget(answer)
      ),
    
      TextQuestion(:OpenTextAnswer answer) => (
        TextQuestionWidget(textQuestion: question),
        TextAnswerWidget(answer)
      ),
      
      TextQuestion(:BooleanAnswer answer) => (
        TextQuestionWidget(textQuestion: question),
        BooleanAnswerWidget(answer)
      ),

      ImageQuestion(:MultipleChoiceAnswer answer) => (
        ImageQuestionWidget(imageQuestion: question),
        MultipleChoiceWidget(answer)
      ),

      ImageQuestion(:OpenTextAnswer answer) => (
        ImageQuestionWidget(imageQuestion: question),
        TextAnswerWidget(answer)
      ),

      ImageQuestion(:BooleanAnswer answer) => (
        ImageQuestionWidget(imageQuestion: question),
        BooleanAnswerWidget(answer)
      ),

    };
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Kuizu'),),
           body: Container(),
       );
  }
}