import 'package:flutter/material.dart';
import 'package:trocapc/modules/auth/pages/login_page.dart';
import 'package:trocapc/modules/profile/widgets/card_custom.dart';
import 'package:trocapc/modules/profile/widgets/header_person_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderPersonWidget(),
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
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => LoginPage()));
                },
                child: const Text(
                  "Sair da conta",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }
}
