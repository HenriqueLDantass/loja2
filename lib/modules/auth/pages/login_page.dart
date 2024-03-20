import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trocapc/modules/base/pages/base_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isloading = false;

  void naegacaoLogin(BuildContext context) {
    setState(() {
      isloading = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const BaseScreen()));

      setState(() {
        isloading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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

                          naegacaoLogin(context);
                        },
                        child: const Text("Login"),
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text("Não tem conta? Clique aqui e crie!"))
                  ],
                ),
              ]),
            ))
          ],
        ));
  }
}
