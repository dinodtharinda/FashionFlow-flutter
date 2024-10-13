import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_flow/core/common/entities/user.dart';
import 'package:fashion_flow/core/error/exception.dart';

class FirebaseFirestoreAPI {
  final firestore = FirebaseFirestore.instance;

  void initFirestore() {
    firestore.settings = const Settings(persistenceEnabled: true);
  }

  Future<void> saveUser(String uid, User user) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid) // Use the uid as the document ID
          .set(
              {
            'user': user.toJson(),
            'updatedAt': FieldValue
                .serverTimestamp(), // Optional: Track when the token was updated
          },
              SetOptions(
                  merge:
                      true)); // SetOptions(merge: true) ensures that the document is updated instead of overwritten
    } catch (e) {
     throw ServerException('token upload fail! $e');
    }
  }
}
