import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:test_app/user.dart';

Future<User> fetchUser() async {
  final response =
      await http.get('http://192.168.1.33:3002/user/1');
      //await http.get(Uri.http(' 192.168.1.33:60625', '/user/1'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    
    print("ok");
    print(response.body);
    print(User.fromJson(jsonDecode(response.body)));
    return User.fromJson(jsonDecode(response.body));
    //return users;
  } else {
    print("error");
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load users');
  }
}

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
 }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: //UsersPage()
      Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        
        body: Center(
          child: FutureBuilder<User>(
           future: futureUser,

            builder: (context, snapshot) {
              //List<User> users=snapshot.data;
              if (snapshot.hasData) {
                print(snapshot.data);
                //List<User> users=snapshot.data;
                return
                // ListView(
                //  children: futureUser.map (User user) =>ListTitle(title : Text(snapshot.data.name)).toList() ,
                //) ;
                Container (
                 
                    child:Text(snapshot.data.name),
                    );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
             }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
class User{
  final String name;
  final int id;
  

  User({this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      
    );
  }
}