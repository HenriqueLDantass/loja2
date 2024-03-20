import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trocapc/modules/home/stores/home_stores.dart';
import 'package:trocapc/modules/produtos/models/produto_model.dart';

class ProdutosPage extends StatelessWidget {
  final ProdutoModel produtos;
  const ProdutosPage({Key? key, required this.produtos}) : super(key: key);

  Future<void> _showDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Item adicionado ao carrinho",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Column(
            children: const [
              SizedBox(
                height: 50,
              ),
              Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text("Seu item foi adiciona no carrinho com sucesso")),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("ver carrinho"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Fechar"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<HomeStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            CircleAvatar(),
            SizedBox(
              width: 10,
            ),
            Text("henrique.dantas")
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: produtos.isLiked ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              store.toggleFavorite(produtos, store);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9, // Relação de aspecto para a imagem
            child: Image.network(
              produtos.image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produtos.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'ID: ${produtos.id}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Categoria: ${produtos.category}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Preço: \$${produtos.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Descrição:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  produtos.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      store.produtoAddCarrinho(produtos);
                      _showDialog(context);
                    },
                    child: const Text("Adicionar no carrinho"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
