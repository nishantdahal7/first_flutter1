import 'package:flutter/material.dart';

void main() {
  runApp(const FeeManagementApp());
}

class FeeManagementApp extends StatelessWidget {
  const FeeManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fee Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  void dispose() {
    _studentIdController.dispose();
    _fnameController.dispose();
    _lnameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  void _registerUser() {
    if (_formKey.currentState!.validate()) {
      // Perform user registration and add due amount to the database
      final String studentId = _studentIdController.text;
      final String fname = _fnameController.text;
      final String lname = _lnameController.text;
      final int age = int.tryParse(_ageController.text) ?? 0;
      final String gender = _genderController.text;

      // Add user registration logic here, such as sending data to a server or storing in a local database

      // Add due amount to the user
      const int dueAmount = 20000;

      // Display success message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Registration Successful'),
            content: const Text(
                'Congratulations, you have been successfully registered!'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _studentIdController,
                decoration: const InputDecoration(
                  labelText: 'Student ID',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid student ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _fnameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lnameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: _registerUser,
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _studentIdController = TextEditingController();

  @override
  void dispose() {
    _studentIdController.dispose();
    super.dispose();
  }

  void _loginUser() {
    if (_formKey.currentState!.validate()) {
      final String studentId = _studentIdController.text;

      // Perform user login validation
      // Check if the student ID exists in the database and authenticate the user

      // Assuming the user is authenticated successfully, navigate to the Dashboard
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(studentId: studentId),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _studentIdController,
                decoration: const InputDecoration(
                  labelText: 'Student ID',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your student ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: _loginUser,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  final String studentId;

  const DashboardPage({super.key, required this.studentId});

  // Fetch the current due amount for the given student ID from the database
  int getCurrentDueAmount() {
    // Perform database query and return the current due amount
    // Replace this dummy implementation with your actual database logic

    return 20000; // Dummy value, replace it with your implementation
  }

  @override
  Widget build(BuildContext context) {
    final int dueAmount = getCurrentDueAmount();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Student ID: $studentId',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Due Amount: $dueAmount',
              style: const TextStyle(fontSize: 24.0),
            ),
          ],
        ),
      ),
    );
  }
}
