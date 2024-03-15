import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation_app/signIn.dart';

class UserDetailsPage extends StatefulWidget {
  final List<UserData> userList;

  UserDetailsPage({required this.userList});

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final CollectionReference donorsCollection =
      FirebaseFirestore.instance.collection('donar');

  void donarsdelete(String docId) {
    donorsCollection.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        backgroundColor: Color.fromARGB(255, 193, 14, 14),
      ),
      body: ListView.builder(
        itemCount: widget.userList.length,
        itemBuilder: (context, index) {
          UserData user = widget.userList[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(
                'Name: ${user.name}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Age: ${user.age}'),
                  Text('Phone: ${user.phone}'),
                  Text('Blood Group: ${user.bloodGroup}'),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    widget.userList.removeAt(index);
                  });
                  // Delete the document from Firestore
                  donarsdelete(user.name); // Assuming name is unique
                },
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 193, 14, 14),
      ),
    );
  }
}
