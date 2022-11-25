import 'dart:convert';
import 'package:flutter/services.dart';
import '../jsonClasses/accounts.dart';

class AuthRepository {
  List<dynamic> accountsList = [];
  Future<void> login(username,password) async {
    var usernameJson, passwordJson;
    //attempting login
    await  readJson();
    //just for the animation loading
    await Future.delayed(Duration(seconds: 2));
    for(var element in accountsList){
      usernameJson=element.email;
      passwordJson=element.password;
      if (username==usernameJson && password==passwordJson){
        print('logged in');
      }else{
        //exception thrown to see the message on the main screen
        throw Exception('Failed Log In');
      }
    }




  }

  Future<void> readJson() async {
    //reading json File in order to see if one of the account is present at db or not,
    //i know that is a sign in so it's not supposed to have any checks regarding the account
    // i used this way in order to use it Bloc library and Json Files
    final String response = await rootBundle.loadString('assets/accounts.json');
    final data = await jsonDecode(response);


      accountsList = data['accounts'].map((data) => Account.fromJson(data)).toList();

  }
}