import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/screens/Destination.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference _attractions =
      FirebaseFirestore.instance.collection("attraction");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Travel App'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent),
      body: StreamBuilder(
        stream: _attractions.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasError) {
            print(streamSnapshot.error);
          }
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 900),
                      pageBuilder: (_, __, ___) => Destination(documentSnapshot['title'], documentSnapshot['image'], documentSnapshot['description']),
                      settings: RouteSettings(arguments: documentSnapshot)
                    ));
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Image.network(documentSnapshot['image'],fit: BoxFit.cover,),
                            height: 250.0,
                            width: 600.0,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            documentSnapshot['title'],
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 10.0),
                          Text(documentSnapshot['short_detail'])
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
