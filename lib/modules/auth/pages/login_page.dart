// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trocapc/modules/auth/pages/register_page.dart';
import 'package:trocapc/modules/auth/stores/registro_store.dart';
import 'package:trocapc/modules/base/pages/base_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _clearToken();
  }

  Future<void> _clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    print("limpando token");
  }

  bool isloading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _checkToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const BaseScreen()),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<RegistroStore>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Image.asset("assets/logo.jpg"),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                ),
              ),
              child: ListView(children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Digite seu login...',
                          labelText: 'Login',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          hintText: 'Digite sua senha...',
                          labelText: 'Senha',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            shape: const OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45),
                                topRight: Radius.circular(45),
                              ),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                  child: SizedBox(
                                    width:
                                        200, // Ajuste o tamanho conforme necessário
                                    height:
                                        200, // Ajuste o tamanho conforme necessário
                                    child: Lottie.asset("assets/animacao.json"),
                                  ),
                                ),
                              );
                            },
                          );
                          store
                              .login(
                                  email: _emailController.text,
                                  password: _passwordController.text)
                              .then((value) => _checkToken());
                        },
                        child: const Text("Login"),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const RegisterPage()));
                        },
                        child: const Text("Não tem conta? Clique aqui e crie!"))
                  ],
                ),
              ]),
            ))
          ],
        ));
  }
}
