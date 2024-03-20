import 'package:flutter/material.dart';

class CardCustom extends StatelessWidget {
  final Color? color;
  final IconData? icon;
  final String title;

  const CardCustom({super.key, this.color, this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: SizedBox(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: color,
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                    )),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
