import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  final SupabaseClient supabase = Supabase.instance.client;
  bool _signInLoading = false;
  bool _signUpLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _googleSignInLoading = false;

  // Sign up supabase function
  // supabase.auth.signup(email: '', password: '')
  // This function will return User and Session
  // --------------------------------------------
  // Sign in supabase function
  // supabase.auth.signInWithPassword(email: '', password: '')
  // This function will return User and Session

  @override
  void dispose() {
    supabase.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo
                  Image.network(
                    'https://seeklogo.com/images/S/supabase-logo-DCC676FFE2-seeklogo.com.png',
                    height: 150,
                  ),
                  const SizedBox(height: 25),

                  // Email field
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    controller: _emailController,
                    decoration: const InputDecoration(label: Text('Email')),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 25),

                  // Password field
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is required';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    decoration: const InputDecoration(label: Text('Password')),
                    obscureText: true,
                  ),
                  const SizedBox(height: 25),

                  _signInLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () async {
                            final isValid = _formKey.currentState?.validate();
                            print('isValid: $isValid');
                            if (isValid != true) {
                              return;
                            }
                            setState(() {
                              _signInLoading = true;
                            });
                            try {
                              await supabase.auth.signInWithPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            } catch (e) {
                              print('e: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Sign in Failed'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              setState(() {
                                _signInLoading = false;
                              });
                            }
                          },
                          child: const Text('Sign In')),
                  //const Divider(),
                  _signUpLoading
                      ? const Center(child: CircularProgressIndicator())
                      : OutlinedButton(
                          onPressed: () async {
                            final isValid = _formKey.currentState?.validate();
                            print('isValid: $isValid');
                            if (isValid != true) {
                              return;
                            }
                            setState(() {
                              _signUpLoading = true;
                            });
                            try {
                              await supabase.auth.signUp(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Success! Confirmation Email Sent"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              setState(
                                () {
                                  _signUpLoading = false;
                                },
                              );
                            } catch (e) {
                              print('e: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Sign up Failed'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              setState(() {
                                _signUpLoading = false;
                              });
                            }
                          },
                          child: const Text('Sign Up')),

                  Row(
                    children: const [
                      Expanded(
                          child: Divider(
                        thickness: 0.01,
                      )),
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Text('OR'),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.01,
                      )),
                    ],
                  ),
                  _googleSignInLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : OutlinedButton.icon(
                          onPressed: () async {
                            setState(() {
                              _googleSignInLoading = true;
                            });

                            try {
                              // syntax for Google Sign in
                              await supabase.auth.signInWithOAuth(
                                  Provider.google,
                                  redirectTo: kIsWeb
                                      ? null
                                      : 'io.supabase.myflutterapp://login-callback');
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Sign Up Failed'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              setState(() {
                                _googleSignInLoading = false;
                              });
                            }
                          },
                          icon: Image.network(
                              'https://cdn-icons-png.flaticon.com/512/2504/2504739.png',
                              height: 20),
                          label: const Text('Continue with Google'),
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
