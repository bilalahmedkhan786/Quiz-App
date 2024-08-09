import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addQuiz(String title, String description, List<String> questions) async {
    await FirebaseFirestore.instance.collection('quizzes').add({
        'title': title,
        'description': description,
        'questions': questions,
    });
}

Stream<QuerySnapshot> getQuizzes() {
    return FirebaseFirestore.instance.collection('quizzes').snapshots();
}

Future<void> updateQuiz(String quizId, String title, String description, List<String> questions) async {
    await FirebaseFirestore.instance.collection('quizzes').doc(quizId).update({
        'title': title,
        'description': description,
        'questions': questions,
    });
}


Future<void> deleteQuiz(String quizId) async {
    await FirebaseFirestore.instance.collection('quizzes').doc(quizId).delete();
}
