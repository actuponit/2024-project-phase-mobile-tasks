import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../product/presentation/widgets/snack_bar.dart';
import '../blocs/auth/auth_bloc.dart';
import '../widgets/custom_button.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController emailField = TextEditingController();
  final TextEditingController passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoggedInState) {
          BlocProvider.of<AuthBloc>(context).add(GetUserEvent());
          Navigator.of(context).pushReplacementNamed('home');
          showSnackBar(context, Colors.blueGrey, 'Successfully Logged in');
        } else if (state is AuthErrorState) {
          showSnackBar(context, Colors.redAccent, state.message);
        } if (state is LoadedUserState) {
          Navigator.of(context).pushReplacementNamed('home');
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
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
                      'Sign into your account',
                      style: TextStyle(
                          fontSize: 25,
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
              
                    if (email == '' || password == '') {
                      return showSnackBar(context, Colors.redAccent, 'Please fill all the fields');
                    }
                    BlocProvider.of<AuthBloc>(context).add(LoginEvent(email, password));
                  }, text: 'SIGN IN'),
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account? ',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: const Color.fromRGBO(136, 136, 136, 1))),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed('register');
                        },
                        child: const Text('Sign up',
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
      ),
    );
  }
}
