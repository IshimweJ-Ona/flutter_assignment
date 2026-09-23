import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscure = true;
  String _sex = 'Male';
  final Map<String, bool> _courses = {
    'Machine Learning': true,
    'Full stack': true,
    'Mobile application': false,
  };
  double _tuition = 10;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitted successful')),
      );
    }
  }

  void _clear() {
    _formKey.currentState!.reset();
    _usernameController.clear();
    _passwordController.clear();
    setState(() {
      _obscure = true;
      _sex = 'Male';
      _courses.updateAll((key, value) => false);
      _tuition = 0;
    });
  }

  Widget _label(String text) => SizedBox(
        width: 100,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );

  InputDecoration _inputDecoration({Widget? suffix}) => InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        border: InputBorder.none,
        isDense: true,
        suffixIcon: suffix,
        errorStyle: const TextStyle(color: Colors.red, fontSize: 11),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 110,
                  color: Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: const Text(
                    'Welcome Back!!!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: _label('Username'),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _usernameController,
                              decoration: _inputDecoration(),
                              validator: (v) => (v == null || v.length < 10)
                                  ? 'Username must be 10 char long'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: _label('Password'),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obscure,
                              decoration: _inputDecoration(
                                suffix: IconButton(
                                  icon: Icon(_obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () =>
                                      setState(() => _obscure = !_obscure),
                                ),
                              ),
                              validator: (v) => (v == null || v.length < 8)
                                  ? 'password must be 8 char long'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      RadioGroup<String>(
                        groupValue: _sex,
                        onChanged: (v) => setState(() => _sex = v!),
                        child: Row(
                          children: [
                            _label('Sex'),
                            const Radio<String>(value: 'Male'),
                            const Text('Male'),
                            const Radio<String>(value: 'Female'),
                            const Text('Female'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: _label('Courses'),
                          ),
                          Expanded(
                            child: Column(
                              children: _courses.keys.map((course) {
                                return Row(
                                  children: [
                                    Checkbox(
                                      value: _courses[course],
                                      activeColor: Colors.deepPurple,
                                      onChanged: (v) => setState(
                                          () => _courses[course] = v!),
                                    ),
                                    Text(course),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _label('Tuition'),
                      Slider(
                        value: _tuition,
                        min: 0,
                        max: 100,
                        activeColor: Colors.lightGreenAccent.shade700,
                        thumbColor: Colors.grey.shade700,
                        label: _tuition.round().toString(),
                        divisions: 100,
                        onChanged: (v) => setState(() => _tuition = v),
                      ),
                      const Divider(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightGreen.shade50,
                              foregroundColor: Colors.black87,
                              side: const BorderSide(color: Colors.lightGreen),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Submit'),
                          ),
                          ElevatedButton(
                            onPressed: _clear,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}