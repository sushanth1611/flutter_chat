import 'package:flutter/material.dart';
import 'package:flutter_chat/providers/auth_provider.dart';
import 'package:flutter_chat/widgets/loading_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: "Sign in fail");
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: "Sign in cancelled");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: "Sign in success");
        break;
      default:
        break;
    }

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: (authProvider.status != Status.authenticating &&
                      authProvider.status != Status.authenticated)
                  ? TextButton(
                      child: const Text(
                        'Sign in with google',
                      ),
                      onPressed: () async {
                        authProvider.handleSignIn().then((isSuccess) {
                          if (isSuccess) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }
                        }).catchError((error, stackTrace) {
                          Fluttertoast.showToast(msg: error.toString());
                          authProvider.handleException();
                        });
                      },
                    )
                  : const SizedBox.shrink(),
            ),
            Positioned(
              child: authProvider.status == Status.authenticating
                  ? const LoadingView()
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
