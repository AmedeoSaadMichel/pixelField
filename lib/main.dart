import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelfield/sign_in.dart';
import 'constants.dart';
import 'package:bloc/bloc.dart';
import 'myblockobserver.dart';

void main() {

  Bloc.observer = MyBlocObserver();

  //during this app i used many widget like Flexible ,
  // Spacer and Align,I prefered in this way in order
  //to make the app responsive as more as i can, in some case i used
  //padding or i gave a certain width height to an Container, in those
  //cases i used Mediaquery
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    //i used MediaQuery because is a good tool to make the display responsive
    //with that you can calculate very easy the positions of the objects on the screen

    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Stack(
      children: [
        Image.asset(
          "assets/images/background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,

          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 3),
                Flexible(
                  child: Container(
                    width: width * 0.90,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(18, 35, 41, 1),
                        shape: BoxShape.rectangle),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Welcome
                        Flexible(
                            flex: 3,
                            child: Text(
                              'Welcome!',
                              style: TextStyle(
                                  fontFamily: 'EBGaramond',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            )),
                        Spacer(),
                        //TODO: json textnameUSER

                        Flexible(
                          child: Text(
                            'text text text',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Spacer(),
                        //button
                        Flexible(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: height * 0.20,
                              width: width * 0.80,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Scan bottle',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(5),
                                color: c_yellow,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Flexible(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                'Have an account?',
                                style: TextStyle(color: Colors.white),
                              ),
                              flex: 5,
                            ),
                            Spacer(flex: 1),
                            Flexible(
                              flex: 5,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signin()),
                                  );
                                },
                                child: Text(
                                  'Sign in first',
                                  style: (TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'EBGaramond',
                                      color: c_yellow2,
                                      fontWeight: FontWeight.bold)),
                                ),
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                  flex: 2,
                ),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
