import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final fireStore = FirebaseFirestore.instance;

final userRef = fireStore.collection('users');
final questionGroupsRef = fireStore.collection('questionGroups');
final multipleChoicesRef = fireStore.collection('multipleChoices');

Reference get firebaseStorage => FirebaseStorage.instance.ref();
