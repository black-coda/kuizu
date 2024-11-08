import 'dart:convert'; // To parse JSON
import 'package:flutter/services.dart' show rootBundle; // To load assets
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore package

// Method to upload questions to Firestore
Future<void> uploadQuestionsToFirestore() async {
  // Load the JSON file from assets
  final String jsonContent =
      await rootBundle.loadString('assets/new_question.json');

  // Parse the JSON content into a list of questions
  final List<dynamic> questionsList = json.decode(jsonContent);

  // Reference to the Firestore collection
  final CollectionReference questionsCollection =
      FirebaseFirestore.instance.collection('questions');

  // Loop through each question and upload to Firestore
  for (var questionData in questionsList) {
    try {
      // Add the question document to Firestore
      await questionsCollection.add(questionData);
      print("Question added successfully");
    } catch (e) {
      print("Error uploading question: $e");
    }
  }
}
