import 'dart:async';

import 'package:chatview/chatview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hypertrip/domain/models/chat/firestore_message.dart';

class FirestoreRepository {
  final FirebaseFirestore _db;

  FirestoreRepository() : _db = FirebaseFirestore.instanceFor(app: Firebase.app());

  final String COLLECTION_GROUP = 'groups';
  final String COLLECTION_MESSAGES = 'messages';

  /// Lấy danh sách tin nhắn từ một nhóm dựa trên groupId từ Firestore
  Stream<List<FirestoreMessage>> fetchMessagesByGroupId(String groupId) {
    return _db
        .collection(COLLECTION_GROUP)
        .doc(groupId.trim())
        .collection(COLLECTION_MESSAGES)
        .orderBy('Timestamp')
        .snapshots()
        .map((querySnapshot) {
      List<FirestoreMessage> messages = [];
      querySnapshot.docs.forEach((doc) {
        FirestoreMessage message = FirestoreMessage.fromJson(doc.data());
        messages.add(message);
      });
      return messages;
    });
  }

  Stream<FirestoreMessage> fetchLastedMessage(String groupId) {
    return _db
        .collection(COLLECTION_GROUP)
        .doc(groupId.trim())
        .collection(COLLECTION_MESSAGES)
        .orderBy('Timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((querySnapshot) {
      final lastedMessage = querySnapshot.docs.first;
      final message = FirestoreMessage.fromJson(lastedMessage.data());
      return message;
    });
  }

  /// Send message lên Firestore
  Future<FirestoreMessage?> saveMessage(String uid, MessageType type, String messageText,
      DateTime sentAt, String currentGroupId) async {
    if (messageText.trim().isNotEmpty) {
      final data =
          FirestoreMessage(senderId: uid, type: type, content: messageText, timestamp: sentAt);

      try {
        CollectionReference messageCollection =
            _db.collection(COLLECTION_GROUP).doc(currentGroupId).collection(COLLECTION_MESSAGES);

        DocumentReference docRef = await messageCollection.add(data.toJson());

        return data;
      } catch (error) {
        print("error saveMessage ${error.toString()}");
        return null;
      }
    } else {
      return null;
    }
  }
}
