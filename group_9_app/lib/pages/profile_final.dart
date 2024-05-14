import 'package:flutter/material.dart';
import 'package:group_9_app/pages/profile_complete.dart';

class ParentInfoPage extends StatefulWidget {
  const ParentInfoPage({Key? key}) : super(key: key);

  @override
  _ParentInfoPageState createState() => _ParentInfoPageState();
}

class _ParentInfoPageState extends State<ParentInfoPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _fieldsFilled = false;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isEmailValid(String email) {
    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    return password.length >= 8;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background/blue background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Maak jouw account af',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'E-mail van de ouder',
                        labelStyle: const TextStyle(color: Colors.white),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        errorText: _emailError,
                      ),
                      style: const TextStyle(color: Colors.white),
                      onChanged: (_) {
                        setState(() {
                          _fieldsFilled = _emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty;
                          _emailError = null; // Reset the error message when typing
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Kies een wachtwoord (8 tekens lang)',
                        labelStyle: const TextStyle(color: Colors.white),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        errorText: _passwordError,
                      ),
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      onChanged: (_) {
                        setState(() {
                          _fieldsFilled = _emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty;
                          _passwordError = null; // Reset the error message when typing
                        });
                      },
                    ),
                    const SizedBox(height: 150),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              size: 30,
                              color: _fieldsFilled
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                            ),
                            onPressed: _fieldsFilled
                                ? () {
                                    bool valid = true;
                                    if (!_isEmailValid(_emailController.text)) {
                                      setState(() {
                                        _emailError = 'Voer een geldig e-mailadres in.';
                                      });
                                      valid = false;
                                    }
                                    if (!_isPasswordValid(_passwordController.text)) {
                                      setState(() {
                                        _passwordError = 'Het wachtwoord moet minimaal 8 tekens lang zijn.';
                                      });
                                      valid = false;
                                    }
                                    if (valid) {
                                      // Navigate to the next page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const CompletePage()),
                                      );
                                    }
                                  }
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
