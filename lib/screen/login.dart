import 'package:flutter/material.dart';
import 'package:ticktrack/const/colors.dart';
import 'package:ticktrack/data/auth_data.dart';

class LogIn_Screen extends StatefulWidget {
  final VoidCallback show;
  const LogIn_Screen(this.show, {super.key});

  @override
  State<LogIn_Screen> createState() => _LogIn_ScreenState();
}

class _LogIn_ScreenState extends State<LogIn_Screen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? emailError;
  String? passwordError;

  void validateForm() {
    setState(() {
      emailError = null;
      passwordError = null;

      if (email.text.isEmpty ||
          !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
              .hasMatch(email.text)) {
        emailError = "Enter a valid email";
      }

      if (password.text.length < 6) {
        passwordError = "Password must be at least 6 characters";
      }
    });

    if (emailError == null && passwordError == null) {
      AuthenticationRemote()
          .login(context, email.text, password.text, widget.show);
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              image(),
              SizedBox(height: 50),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    textfield(email, _focusNode1, Icons.email, "Enter Email"),
                    if (emailError != null) errorMessage(emailError!),
                    SizedBox(height: 20),
                    textfield(
                        password, _focusNode2, Icons.lock, "Enter Password",
                        obscureText: true),
                    if (passwordError != null) errorMessage(passwordError!),
                  ],
                ),
              ),
              SizedBox(height: 20),
              account(),
              SizedBox(height: 20),
              Login(),
            ],
          ),
        ),
      ),
    );
  }

  Widget errorMessage(String message) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          message,
          style: TextStyle(color: Colors.red, fontSize: 14),
        ),
      ),
    );
  }

  Widget Login() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: validateForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: custom_green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget account() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an Account?",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        TextButton(
          onPressed: widget.show,
          child: Text(
            "Sign Up",
            style: TextStyle(color: custom_green, fontSize: 14),
          ),
        )
      ],
    );
  }

  Widget textfield(
    TextEditingController _controller,
    FocusNode _focusNode,
    IconData iconss,
    String typeName, {
    bool obscureText = false,
  }) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      obscureText: obscureText,
      keyboardType: typeName.contains("Email")
          ? TextInputType.emailAddress
          : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(
          iconss,
          color: _focusNode.hasFocus ? custom_green : Color(0xffc5c5c5),
        ),
        hintText: typeName,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: custom_green, width: 2.0),
        ),
      ),
    );
  }

  Widget image() {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/7.png"),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
