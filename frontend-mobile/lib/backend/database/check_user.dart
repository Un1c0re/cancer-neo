// import 'package:firebase_database/firebase_database.dart';

// class CheckUser {
//   DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('/users');
  
//   Future<bool> ifUserExist(String phone) async {
 
//     DatabaseEvent event = await usersRef.orderByChild('phone').equalTo(phone).once();
//     DataSnapshot snapshot = event.snapshot;

//     return snapshot.value != null;
//   }
// }