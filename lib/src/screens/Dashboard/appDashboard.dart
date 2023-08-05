import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kartihk_map/src/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/updateProfile.dart';

final db = FirebaseFirestore.instance;

class AppDashboard extends StatefulWidget {
  late final String documentId;

  // ignore: prefer_const_constructors_in_immutables
  AppDashboard({super.key});

  @override
  State<AppDashboard> createState() => _AppDashboardState();
}

class _AppDashboardState extends State<AppDashboard> {
  late Future<DocumentSnapshot> _futureDocument;
  late String _message = '';
  String? _imageUrl;
  @override
  void initState() {
    super.initState();
    _loadMessage();
  }

  Future<void> _loadMessage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String message = prefs.getString('UID') ?? '';
    setState(() {
      _message = message;
    });
    _futureDocument = _getDocument();
  }

  Future<DocumentSnapshot> _getDocument() async {
    print(_message);

    return await FirebaseFirestore.instance
        .collection('users')
        .doc(_message)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: _futureDocument,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          DocumentSnapshot<Object?>? documentSnapshot = snapshot.data;
          if (documentSnapshot!.exists) {
            Map<String, dynamic>? data =
                documentSnapshot.data() as Map<String, dynamic>?;
            return Scaffold(
                backgroundColor: Colors.black,
                body: Container(
                  child: Column(
                    children: <Widget>[
                      Center(
                        heightFactor: 1.2,
                        child: Container(
                          height: 325,
                          width: 320,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(245, 245, 245, 1),
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(221, 243, 241, 241),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: Offset(0, 3),
                                blurStyle: BlurStyle.normal,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 32,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Icon(
                                    Icons.menu_outlined,
                                    size: 35,
                                  ),
                                  const SizedBox(
                                    width: 122,
                                  ),
                                  Text(
                                    '${data!['FirstName']}',
                                    style: const TextStyle(
                                        color: Color.fromARGB(197, 44, 44, 37),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 13,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 10,
                                          spreadRadius: 6,
                                        ),
                                      ],
                                      color: const Color.fromARGB(
                                          255, 165, 177, 165),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ProfileUpdate(),
                                          ),
                                        );
                                      },
                                      child: Image.network(data['ImageURL']),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: Text(
                                      'Hello ${data['FirstName']}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                hoverColor: Colors.amber.withOpacity(0.3),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (_) => const HomeScreen()),
                                  );
                                },
                                icon: const Icon(
                                  Icons.search_rounded,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                              child: Container(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: 50),
                          color: Colors.black,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Material(
                                elevation: 3,
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: 1.5, vertical: 1.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  tileColor: Color.fromARGB(255, 12, 12, 12),
                                  leading: Icon(
                                    Icons.home_filled,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    'Home',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text('1-2-3, xyz colony....',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Material(
                                elevation: 3,
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: 1.5, vertical: 1.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  tileColor: Color.fromARGB(255, 12, 12, 12),
                                  leading: Icon(
                                    Icons.work,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    'Work',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text('1-2-3, xyz colony....',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Material(
                                elevation: 3,
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: 1.5, vertical: 1.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  tileColor: Color.fromARGB(255, 12, 12, 12),
                                  leading: Icon(
                                    Icons.restaurant,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    'Restaurant',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text('1-2-3, xyz colony....',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Material(
                                elevation: 3,
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: 1.5, vertical: 1.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  tileColor: Color.fromARGB(255, 12, 12, 12),
                                  leading: Icon(
                                    Icons.shop,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    'Shopping',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text('1-2-3, xyz colony....',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Material(
                                elevation: 3,
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: 1.5, vertical: 1.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  tileColor: Color.fromARGB(255, 12, 12, 12),
                                  leading: Icon(
                                    Icons.park,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    'Park',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text('1-2-3, xyz colony....',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Material(
                                elevation: 3,
                                shadowColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: 1.5, vertical: 1.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  tileColor: Color.fromARGB(255, 12, 12, 12),
                                  leading: Icon(
                                    Icons.bakery_dining,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    'Bakery',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text('1-2-3, xyz colony....',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )
                            ],
                          ),
                        ),
                      )))
                    ],
                  ),
                ));
          } else {
            return const Center(
              child: Text('Document does not exist'),
            );
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return Center(
              child: AnimatedContainer(
            duration:
                const Duration(seconds: 2), // Set the duration of the animation
            child: const CircularProgressIndicator(
              strokeWidth: 3.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              backgroundColor: Colors.grey,
              value: 0.5, // current progress
              semanticsLabel: 'Loading',
              semanticsValue: 'Loading',
            ),
          ));
        }
      },
    );
  }
}
