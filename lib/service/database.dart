import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future tambahPenyewa(Map<String, dynamic> penyewaInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Penyewa")
        .doc(id)
        .set(penyewaInfoMap);
  }

  Future<Stream<QuerySnapshot>> getPenyewa() async {
    return await FirebaseFirestore.instance.collection("Penyewa").snapshots();
  }

  Future editPenyewa(String id, Map<String, dynamic> editInfoMap) async{
    return await FirebaseFirestore.instance.collection("Penyewa").doc(id).update(editInfoMap);
  }

  Future deletePenyewa(String id) async{
    return await FirebaseFirestore.instance.collection("Penyewa").doc(id).delete();
  }
}
