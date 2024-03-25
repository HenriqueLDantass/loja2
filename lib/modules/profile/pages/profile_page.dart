import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trocapc/modules/auth/pages/login_page.dart';
import 'package:trocapc/modules/profile/widgets/card_custom.dart';
import 'package:trocapc/modules/profile/widgets/header_person_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool? hastoken;

  @override
  void initState() {
    super.initState();
    _checkToken().then((token) {
      setState(() {
        hastoken = token != null;
      });
    });
  }

  Future<void> removeToken(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginPage()),
    );
  }

  Future<String?> _checkToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    return token;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: hastoken != null
              ? !hastoken!
                  ? [
                      Center(
                        child: SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => LoginPage()));
                            },
                            child: Text(
                                'Faca o login'), // Corrigido: 'child' definido como um widget de texto
                          ),
                        ),
                      )
                    ]
                  : [
                      const HeaderPersonWidget(),
                      Divider(),
                      CardCustom(
                        title: "Acompanhar pedidos",
                        icon: Icons.cottage_outlined,
                        color: Colors.amber,
                      ),
                      CardCustom(
                        title: "Ver os itens do seu carrinho",
                        icon: Icons.shopping_cart_rounded,
                        color: Colors.green,
                      ),
                      CardCustom(
                        title: "Ver os itens curtido",
                        icon: Icons.favorite,
                        color: Colors.red,
                      ),
                      CardCustom(
                        title: "Seus itens anunciados",
                        icon: Icons.cottage_outlined,
                        color: Colors.purple,
                      ),
                      CardCustom(
                        title: "Se torne um vendedor",
                        icon: Icons.attach_money_rounded,
                        color: Colors.deepOrangeAccent,
                      ),
                      CardCustom(
                        title: "Acessar na web",
                        icon: Icons.web_asset,
                        color: Colors.grey,
                      ),
                      TextButton(
                          onPressed: () {
                            removeToken(context);
                          },
                          child: const Text(
                            "Sair da conta",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ))
                    ]
              : [Container()],
        ),
      ),
    );
  }
}
