import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_todo_online_c11/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.fromFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  /// addTask
  static Future<void> addTaskToFireStore(Task task) {
    var taskCollection = getTasksCollection();

    /// collection
    DocumentReference<Task> taskDocRef = taskCollection.doc();

    /// document
    task.id = taskDocRef.id;

    /// auto id
    return taskDocRef.set(task);
  }
}
