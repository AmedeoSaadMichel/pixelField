import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixelfield/auth/auth_repository.dart';
import 'package:pixelfield/auth/form_submission_status.dart';
import 'package:pixelfield/auth/login/login_bloc.dart';
import 'package:pixelfield/auth/login/login_event.dart';
import 'package:pixelfield/auth/login/login_state.dart';
import 'constants.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  var size, height, width;


  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;



  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      backgroundColor: backgroundcolor,
      body: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
          create: (context) =>
              LoginBloc(authRepo: context.read<AuthRepository>()),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: height * 0.08)),
              //ARROW BUTTON
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Padding(padding: EdgeInsets.only(left: height * 0.04)),
                    Spacer(),

                    Flexible(
                        flex: 40,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: height * 0.03,
                            ),
                            height: height * 0.05,
                            width: height * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              //border: Border.all(color: Colors.white, width: 1),
                              // shape: BoxShape.rectangle
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Spacer(),
              //SIGN IN TEXT
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: 38,
                          fontFamily: "EBGaramond",
                          color: Colors.white),
                    ),
                  ),
                ),
              ),

              _signForm(),
            ],
          ),
        ),
      ),
    );
  }

//I SPLIT THE CODE IN VARIOUS WIDGET IN ORDER TO MAKES UNDERSTANDABLE THE READING
  Widget _signForm() {
    //BLOCK LISTENER TO DISPLAY THE ERROR
    return BlocListener<LoginBloc,LoginState>(
      listener: (context,state){
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
        if (formStatus is SubmissionSuccess) {
          _showSnackBar(context, formStatus.result);
        }
      },
      child: Flexible(
          flex: 20,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //Email
                _emailField(),
                Spacer(),
                //Password
                _passwordField(),
                Spacer(
                  flex: 2,
                ),
                _loginButton(),
                Spacer(
                  flex: 2,
                ),
                //cant sign in , recover password
                Flexible(
                    flex: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Can't sign in?",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text("Recover Password",
                            style: TextStyle(
                                color: c_yellow2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold))
                      ],
                    ))
              ],
            ),
          )),
    );
  }

  //EMAIL WIDGET
  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Flexible(
        flex: 6,
        child: Container(
          padding: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
          child: TextFormField(
            controller: _email,
            autocorrect: true,
            enableSuggestions: true,
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) {},
            decoration: InputDecoration(
              filled: true,

              alignLabelWithHint: true,
              floatingLabelStyle: TextStyle(color: c_yellow),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: c_yellow),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: c_yellow),
              ),

              focusedBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: c_yellow)),
              labelText: 'Email',
              labelStyle: TextStyle(color: c_yellow),
              //hintText: 'Email address',
              hintStyle: TextStyle(color: c_yellow),
            ),
            style: TextStyle(color: Colors.white),
            validator: (value) => state.isValidEmail ? null : 'Invalid Email',
            //passing values to the bloc
            onChanged: (value) =>
                context.read<LoginBloc>().add(LoginEmailChanged(email: value)),
          ),
        ),
      );
    });
  }
 //PASSWORD WIDGET
  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Flexible(
        flex: 6,
        child: Container(
          padding: EdgeInsets.only(left: width * 0.04, right: width * 0.04),
          child: TextFormField(
            controller: _password,
            //This will obscure text dynamically
            obscureText: !_passwordVisible,

            validator: (value) =>
                state.isValidPassword ? null : 'Password Requires 8 characters',
            /*{
              if (value!.isEmpty || value.length < 8) {
                return 'Password Requires';
              }
              return null;
            },*/
            onChanged: (value) => context
                .read<LoginBloc>()
                .add(LoginPasswordChanged(password: value)),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: c_yellow,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              filled: true,
              alignLabelWithHint: true,
              floatingLabelStyle: TextStyle(color: c_yellow),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: c_yellow),
              ),
              focusedBorder:
                  UnderlineInputBorder(borderSide: BorderSide(color: c_yellow)),
              labelText: 'Password',
              labelStyle: TextStyle(color: c_yellow),
              hintStyle: TextStyle(color: c_yellow),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    });
  }
 //LOGIN WIDGET
  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? CircularProgressIndicator()
            : Flexible(
                flex: 5,
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<LoginBloc>().add(LoginSubmitted());
                    }
                  },
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.90,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Continue',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5),
                      color: c_yellow,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ),
              );
      },
    );
  }
  //DISPLAY ERROR
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
