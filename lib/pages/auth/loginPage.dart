import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'cadastroPage.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 2000;

    return Container(
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 80,
                  left: 80,
                  right: 80,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20), // Bordas arredondadas
                        side: BorderSide(
                          color: Color.fromARGB(255, 117, 3, 3), // Cor da borda
                          width: 2, // Largura da borda
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  'https://conceito.de/wp-content/uploads/2012/01/banknotes-159085_1280.png',
                                  height: !isSmallScreen ? 300 : 150,
                                  width: !isSmallScreen ? 300 : 150,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(15), //apply padding to all four sides
                              child: Text(
                                "Email",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 117, 3, 3),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TextFormField(
                              key: const ValueKey('email'),
                              controller: _emailController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 15,
                                ),
                                filled: true,
                                fillColor: Colors.black12,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              validator: (localEmail) {
                                final email = localEmail ?? '';
                                if (!email.contains('@')) {
                                  return 'E-mail informado não é válido.';
                                }
                                return null;
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.all(15), //apply padding to all four sides
                              child: Text(
                                "Senha",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 117, 3, 3),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            TextFormField(
                              key: const ValueKey('password'),
                              controller: _passwordController,
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 15,
                                ),
                                filled: true,
                                fillColor: Colors.black12,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              validator: (localPassword) {
                                final password = localPassword ?? '';
                                if (password.length < 6) {
                                  return 'Senha deve ter no mínimo 6 caracteres.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                login();
                              },
                              child: Text('Login', style: TextStyle(color: Colors.white),),
                              style: ElevatedButton.styleFrom(
                                elevation: 10.0,
                                backgroundColor: Color.fromARGB(255, 117, 3, 3),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 20.0,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  login() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (userCredential != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Usuário não encontrado"),
            backgroundColor: Colors.redAccent,
          ),
        );
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Senha incorreta"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
