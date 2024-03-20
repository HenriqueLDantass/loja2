import 'package:flutter/material.dart';
import 'package:trocapc/modules/produtos/models/produto_model.dart';

class ModalProdutcs extends StatelessWidget {
  final List<ProdutoModel> produtos;

  const ModalProdutcs({super.key, required this.produtos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Image.network(produtos[index].image)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(produtos[index].title),
                      Text("Preço: ${produtos[index].price} "),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
