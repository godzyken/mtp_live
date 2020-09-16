import 'package:flutter/material.dart';
import 'package:mtp_live/core/services/auth_services.dart';
import 'package:mtp_live/ui-old/auth-old/login_page.dart';
import 'package:mtp_live/ui/pages/home_page.dart';
import 'package:provider/provider.dart';


class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'SplashScreen',
      home: FutureBuilder(
        future: Provider.of<AuthService>(context).currentUser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.hasData ? MyHomePage() : LoginPage();
          } else {
            return Container(
                color: Colors.blue,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.blue[100], Colors.blue[400]],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          imageUrl,
                        ),
                        radius: 60,
                        backgroundColor: Colors.transparent,
                      ),
                      SizedBox(height: 40),
                      Text(
                        'NAME',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'EMAIL',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      Text(
                        email,
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 40),
                      RaisedButton(
                        onPressed: () {
                          _signOutGoogle();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) {
                            return LoginPage();
                          }), ModalRoute.withName('/'));
                        },
                        color: Colors.deepPurple,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Sign Out',
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                      )
                    ],
                  ),
                ));
          }
        },
      ),
    );
  }
}
