import 'package:flutter/material.dart';
import 'package:food/home.dart';
import 'package:food/login.dart';
import 'package:food/persistdb.dart';
import 'package:food/statemanagement.dart';
import 'package:get/get.dart';

class JoinForm extends StatefulWidget {
  const JoinForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JoinFormState createState() => _JoinFormState();
}

class _JoinFormState extends State<JoinForm> {
  final TextEditingController _usernameController = TextEditingController();

  String _selectedRole = 'Donor'; // Default value

  ManageState manageState = Get.put(ManageState());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Insert a new journal to the database
  Future<void> _addUser(username, role) async {
    await SQLHelper.createuser(username, role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Community'),
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
                const SizedBox(height: 10),
                const Text('Select Role(donor or receipent or volunteer)'),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  items: ['Donor', 'Recipient'].map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value ?? 'Donor';
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      _addUser(_usernameController.text, _selectedRole);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ));

                      manageState.setBasic(
                          _usernameController.text, _selectedRole);
                    }
                  },
                  child: const Text('Join(Regsiter)'),
                ),
                const Center(child: Text('or')),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginForm(),
                    ));
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
