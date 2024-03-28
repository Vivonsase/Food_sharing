import 'package:flutter/material.dart';
import 'package:food/home.dart';
import 'package:food/join.dart';
import 'package:food/persistdb.dart';
import 'package:food/statemanagement.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ManageState manageState = Get.put(ManageState());

  // All users
  List users = [];

  //bool _isLoading = true;
  //this function is used to fetch all data from database
  void _refreshusers() async {
    final data = await SQLHelper.getusers();
    setState(() {
      //_isLoading = false;
      for (var i = 0; i < data.length; i++) {
        users.add(data[i]['username']);
      }
      
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshusers(); //Loading users when the app stops
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blueGrey, // Adjust background color as needed
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _usernameController.text = value ?? '';
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();

                      if (users.contains(_usernameController.text)) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ));

                        manageState.setBasic(
                            _usernameController.text, 'receipent');
                      }
                    } else {
                      Get.showSnackbar(const GetSnackBar(
                        message: 'Something went wrong!',
                      ));
                    }
                  },
                  child: const Text('Login'),
                ),
                const Center(child: Text('or')),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const JoinForm(),
                    ));
                  },
                  child: const Text('Join community(Register)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
