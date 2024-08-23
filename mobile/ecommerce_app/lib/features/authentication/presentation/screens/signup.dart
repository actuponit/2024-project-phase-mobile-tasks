import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/presentation/widgets/snack_bar.dart';
import '../blocs/auth/auth_bloc.dart';
import '../widgets/custom_button.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  final TextEditingController emailField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();
  final TextEditingController nameField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoggedInState) {
          Navigator.of(context).pushReplacementNamed('login');
          showSnackBar(context, Colors.blueGrey, 'Successfully Signed in');
        } else if (state is AuthErrorState) {
          showSnackBar(context, Colors.redAccent, state.message);
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 70),
                Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    borderOnForeground: true,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text('ECOM',
                          style: TextStyle(
                              fontSize: 48,
                              fontFamily: 'Caveat',
                              color: Theme.of(context).primaryColor),
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                const Center(
                  child: Text(
                    'Create a new account',
                    style: TextStyle(
                        fontSize: 27,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        height: 1.5),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Email', style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 7),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(243, 243, 243, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: emailField,
                    decoration: InputDecoration(
                        hintText: 'ex: jon.smith@email.com',
                        hintStyle: Theme.of(context).textTheme.labelSmall,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 10),
                Text('Name', style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 7),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(243, 243, 243, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: nameField,
                    decoration: InputDecoration(
                        hintText: 'ex: Imran Mohammed',
                        hintStyle: Theme.of(context).textTheme.labelSmall,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 10),
                Text('Password',
                    style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 7),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(243, 243, 243, 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    obscureText: true,
                    controller: passwordField,
                    decoration: InputDecoration(
                        hintText: '********',
                        hintStyle: Theme.of(context).textTheme.labelSmall,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(onPressed: () {
                  String email = emailField.text;
                  String password= passwordField.text;
                  String name = nameField.text;

                  if (email == '' || password == '' || name == '') {
                    return showSnackBar(context, Colors.redAccent, 'Please fill all the fields');
                  }
                  BlocProvider.of<AuthBloc>(context).add(SignUpEvent(email, password, name));
                }, text: 'SIGN UP'),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Have an account? ',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: const Color.fromRGBO(136, 136, 136, 1))),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('login');
                      },
                      child: const Text('Sign in',
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(63, 81, 243, 1))),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
