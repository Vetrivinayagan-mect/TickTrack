import 'package:flutter/material.dart';
import 'package:ticktrack/data/auth_data.dart';
import '../const/colors.dart';

class SignUp_Screen extends StatefulWidget {
  final VoidCallback show;
  const SignUp_Screen(this.show, {super.key});

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final name = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
    _focusNode3.addListener(() {
      setState(() {});
    });
    _focusNode4.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    name.dispose();
    super.dispose();
  }

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;
  String? nameError;

  void validateForm() {
    setState(() {
      emailError = null;
      passwordError = null;
      confirmPasswordError = null;
      nameError = null;

      if (email.text.isEmpty ||
          !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
              .hasMatch(email.text)) {
        emailError = "Enter a valid email";
      }
      if (name.text.length < 3) {
        nameError = "Name must be at least 3 characters";
      }
      if (password.text.length < 6) {
        passwordError = "Password must be at least 6 characters";
      }
      if (confirmPassword.text != password.text) {
        confirmPasswordError = "Passwords do not match";
      }
    });

    if (emailError == null &&
        passwordError == null &&
        confirmPasswordError == null &&
        nameError == null) {
      AuthenticationRemote().register(context, email.text, password.text,
          confirmPassword.text, widget.show, name.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                        name, _focusNode4, Icons.person, "Enter FullName"),
                    if (nameError != null) errorMessage(nameError!),
                    SizedBox(height: 20),
                    textfield(password, _focusNode2, Icons.password,
                        "Enter Password"),
                    if (passwordError != null) errorMessage(passwordError!),
                    SizedBox(height: 20),
                    textfield(confirmPassword, _focusNode3, Icons.password,
                        "Confirm Password"),
                    if (confirmPasswordError != null)
                      errorMessage(confirmPasswordError!),
                  ],
                ),
              ),
              SizedBox(height: 20),
              account(),
              SizedBox(height: 20),
              SignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget SignUpButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: validateForm,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: custom_green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              "Sign Up",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget errorMessage(String message) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          message,
          style: TextStyle(color: Colors.red, fontSize: 14),
        ),
      ),
    );
  }

  Widget account() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Already have an Account?",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 13,
            ),
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              "  Login",
              style: TextStyle(color: Colors.green, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }

  Widget textfield(TextEditingController _controller, FocusNode _focusNode,
      IconData iconss, String typeName) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: typeName.contains("Email")
                ? TextInputType.emailAddress
                : TextInputType.text,
            obscureText: typeName.contains("Password"),
            decoration: InputDecoration(
                prefixIcon: Icon(
                  iconss,
                  color: _focusNode.hasFocus ? custom_green : Color(0xffc5c5c5),
                ),
                hintText: typeName,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: custom_green, width: 2.0)))),
      ),
    );
  }

  Widget image() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: background,
          image: DecorationImage(
            image: AssetImage("images/7.png"),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
