import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

FirebaseStorage _storage = FirebaseStorage.instance;
FirebaseAuth _auth = FirebaseAuth.instance;
class StorageMethods{
  Future<String> storeprofile(Uint8List file,String uid)async{
    Reference ref =   _storage.ref().child('profile').child(uid);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String url = await snapshot.ref.getDownloadURL();
    return url;

  }
}