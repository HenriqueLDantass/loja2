import 'package:flutter/material.dart';

class HeaderPersonWidget extends StatelessWidget {
  const HeaderPersonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 150,
          child: const CircleAvatar(
            //alterar para network
            backgroundImage: AssetImage("assets/person.jpg"),
          ),
        ),
        const Column(
          children: [
            Text(
              "Henrique Dantas",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Sao Paulo",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ],
        ),
        SizedBox(
          width: 50,
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.edit))
      ],
    );
  }
}
