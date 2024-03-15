import 'package:blood_donation_app/signIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _LoginState();
}

class _LoginState extends State<HomePage> {
  final CollectionReference donarsCollection =
      FirebaseFirestore.instance.collection('donar');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: content(),
    );
  }
   Widget content() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 193, 14, 14),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          height: 250,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Image.network(
          'https://th.bing.com/th/id/OIP.JPC5fFcX6azhQoYTpGuMSQHaHA?w=579&h=548&rs=1&pid=ImgDetMain'  ),
          ),
        ),
        SizedBox(height: 90),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn(),));
            },
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 193, 14, 14), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: SizedBox(
                width: double.infinity,
                child: Center(child: Text('Register', style: TextStyle(color: Colors.white,fontSize: 20),)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}