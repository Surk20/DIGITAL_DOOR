

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:josm/resources/storage_methods.dart';

import 'package:uuid/uuid.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;
FirebaseStorage  _storage = FirebaseStorage.instance;
class FireStoreMethods {
     Future<String> addDetail({
       required String address,
       required String email,
       required String pincode,
       required String Latitude,
       required String Longitude,
       required String ward,
       required String name,
       required String adhaar,
       required String phone,
       required String area,
       required String house_type,
       required Uint8List file

})async{
       String res = "some error occured";
       try {
         String uid = Uuid().v1();
         String photoUrl = await StorageMethods().storeprofile(file,uid);
        if(name.isNotEmpty && email.isNotEmpty && address.isNotEmpty
            && pincode.isNotEmpty && Latitude.isNotEmpty && Longitude.isNotEmpty
            && ward.isNotEmpty && adhaar.isNotEmpty && phone.isNotEmpty && area.isNotEmpty && house_type.isNotEmpty && file.isNotEmpty ) {
          await _firestore.collection('pid').doc(uid).set({
            'name': name,
            'email':email,
            'address': address,
            'pincode': pincode,
            'latitude': Latitude,
            'logitude': Longitude,
            'ward': ward,
            'adhar': adhaar,
            'phone': phone,
            'area': area,
            'type': house_type,
            'photo': photoUrl
          }).onError((error, stackTrace) => res = 'error occured');
          res = 's';
          return res;
        }
        else{
          res='empty';
          Fluttertoast.showToast(msg: 'Fields can\'t be empty');
        }
       }
       catch(e){
         res = 'Error occured';
       }
       return res;
     }
}