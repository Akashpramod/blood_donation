import 'package:blood_donation_app/details%20_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserData {
  final String name;
  final int age;
  final int phone;
  final String bloodGroup;

  UserData({
    required this.name,
    required this.age,
    required this.phone,
    required this.bloodGroup,
  });
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();

  final CollectionReference donarsCollection =
      FirebaseFirestore.instance.collection('donar');
      
      
addDoners(){
  final data={"name":nameController.text,
   "age":ageController.text,
    "phone": phoneController.text, 
    "bloodgroup": selectedGroup
    
     };
     
  donarsCollection.add(data);
 

}

  final bloodGroup = ["A+", "A-", 'B-', 'B+', 'O+', 'O-', 'AB-', "AB+"];
  String? selectedGroup;

  List<UserData> userList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 193, 14, 14),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              height: 200,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20),
                child: Image.network(
                    'https://media.istockphoto.com/id/1175327257/vector/blood-design-health-care-icon-colorful-illustration.jpg?s=612x612&w=0&k=20&c=uA4ytSvvjq7-IU__cutWmVPiOadPmdhbxINDeCrtRT4='),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: nameController,
                decoration: InputDecoration(
                  // filled: true,
                  // fillColor: Color.fromARGB(255, 193, 14, 14),
                  hintText: 'Name',
                  hintStyle: TextStyle(color: Colors.black),
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                // style: TextStyle(color: Colors.white),
                controller: ageController,
                decoration: InputDecoration(
                  // filled: true,
                  // fillColor: Color.fromARGB(255, 193, 14, 14),
                  hintText: 'Age',
                  hintStyle: TextStyle(color: Colors.black),
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
              //  style: TextStyle(color: Colors.white),
                controller: phoneController,
                decoration: InputDecoration(
                  // filled: true,
                  // fillColor: Color.fromARGB(255, 193, 14, 14),
                  hintText: 'Phone',
                  hintStyle: TextStyle(color: Colors.black),
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                ),
              ),
            ),
            
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownButtonFormField(
                items: bloodGroup
                    .map((e) => DropdownMenuItem(child: Text(e), value: e))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedGroup = val as String?;
                  });
                },
                decoration: InputDecoration(
                  // fillColor: Color.fromARGB(255, 193, 14, 14),
                  hintText: 'Blood group',
                  hintStyle: TextStyle(color: Colors.black),
                  
                ),
                style: TextStyle(color: const Color.fromARGB(255, 214, 9, 9)),
                value: selectedGroup,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsPage(userList: userList)));
                addDoners();
                addUser();
              },
              child: Text(
                'Register',
                style: TextStyle(color:Colors.white),
                
              ),
              style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 193, 14, 14), 
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            ),
          ],
        ),
        
      ),
    );
  }

void addUser() {
  if (nameController.text.isNotEmpty &&
      ageController.text.isNotEmpty &&
      phoneController.text.isNotEmpty &&
      selectedGroup != null) {
    setState(() {
      userList.add(UserData(
        name: nameController.text,
        age: int.parse(ageController.text),
        phone: int.parse(phoneController.text),
        bloodGroup: selectedGroup!,
      ));
      nameController.clear();
      ageController.clear();
      phoneController.clear();
      selectedGroup = null;
    });
  }
}
}

