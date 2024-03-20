import 'package:flutter/material.dart';
import 'package:trocapc/modules/produtos/models/produto_model.dart';

class FiltroTela extends StatefulWidget {
  final List<ProdutoModel> produtos;

  FiltroTela({required this.produtos});

  @override
  _FiltroTelaState createState() => _FiltroTelaState();
}

class _FiltroTelaState extends State<FiltroTela> {
  late List<String> categorias;
  String? categoriaSelecionada;
  bool ordemCrescente =
      true; // Variável para controlar a ordem de classificação

  @override
  void initState() {
    super.initState();
    categorias = _obterCategorias();
    categoriaSelecionada = categorias.isNotEmpty ? categorias[0] : null;
  }

  List<String> _obterCategorias() {
    Set<String> categorias = Set();
    for (var produto in widget.produtos) {
      categorias.add(produto.category);
    }
    return categorias.toList();
  }

  List<ProdutoModel> _filtrarPorCategoria(String categoria) {
    return widget.produtos
        .where((produto) => produto.category == categoria)
        .toList();
  }

  List<ProdutoModel> _ordenarProdutos(List<ProdutoModel> produtos) {
    if (ordemCrescente) {
      return produtos..sort((a, b) => a.price.compareTo(b.price));
    } else {
      return produtos..sort((a, b) => b.price.compareTo(a.price));
    }
  }

  void _limparFiltros() {
    setState(() {
      categoriaSelecionada = null;
      ordemCrescente = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    ordemCrescente = !ordemCrescente;
                  });
                },
                child: Text(
                  ordemCrescente
                      ? 'Menor para Maior Preço'
                      : 'Maior para Menor Preço',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: _limparFiltros,
                child: Text('Limpar Filtros'),
              ),
            ],
          ),
          DropdownButton<String>(
            value: categoriaSelecionada,
            onChanged: (String? novaCategoria) {
              setState(() {
                categoriaSelecionada = novaCategoria;
              });
            },
            items: categorias.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: categoriaSelecionada != null
                  ? _filtrarPorCategoria(categoriaSelecionada!).length
                  : widget.produtos.length,
              itemBuilder: (BuildContext context, int index) {
                final produtosFiltrados = categoriaSelecionada != null
                    ? _filtrarPorCategoria(categoriaSelecionada!)
                    : widget.produtos;

                final produtoOrdenado = _ordenarProdutos(produtosFiltrados);

                final produto = produtoOrdenado[index];
                return ListTile(
                  title: Text(produto.title),
                  subtitle: Text(produto.description),
                  trailing: Text('${produto.price}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
