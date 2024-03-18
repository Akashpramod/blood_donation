import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  
  late List<UserData> filteredUserList;
  late TextEditingController searchController;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    filteredUserList = List.from(widget.userList);
    searchController = TextEditingController();
    initializeSharedPreferences();
  }

  void initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    String? savedQuery = prefs.getString('bloodGroupQuery');
    if (savedQuery != null && savedQuery.isNotEmpty) {
      filterUsers(savedQuery);
      searchController.text = savedQuery;
    }
  }

  void donarsdelete(docId){
    donorsCollection.doc(docId).delete();
  }

  void filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredUserList = List.from(widget.userList);
      } else {
        filteredUserList = widget.userList
            .where((user) => user.bloodGroup.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
    // Save the query to shared preferences
    prefs.setString('bloodGroupQuery', query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donors Details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: filterUsers,
              decoration: InputDecoration(
                labelText: 'Search Blood Group',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUserList.length,
              itemBuilder: (context, index) {
                UserData user = filteredUserList[index];
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
                          filteredUserList.removeAt(index);
                        });
                        donarsdelete(UserData);
                      },
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
    );
  }
}
