import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trocapc/modules/auth/stores/registro_store.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController senha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<RegistroStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Registro'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: nome,
              decoration: InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu nome';
                }
                return null;
              },
            ),
            TextFormField(
              controller: email,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira seu e-mail';
                } else if (!value.contains('@')) {
                  return 'Por favor, insira um e-mail válido';
                }
                return null;
              },
            ),
            TextFormField(
              controller: senha,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira sua senha';
                } else if (value.length < 6) {
                  return 'A senha deve ter pelo menos 6 caracteres';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () async {
                  await store.registerUser(
                      name: nome.text, email: email.text, password: senha.text);
                },
                child: Text('Registrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
