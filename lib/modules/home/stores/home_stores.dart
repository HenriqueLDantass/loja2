import 'package:flutter/material.dart';

import 'package:trocapc/modules/home/services/home_service.dart';
import 'package:trocapc/modules/produtos/models/produto_model.dart';

class HomeStore extends ChangeNotifier {
  final HomeService homeService = HomeService();

  List<ProdutoModel> listaProdutos = [];
  List<ProdutoModel> produtosCurtidos = [];

  List<ProdutoModel> produtosCarrinho = [];

  bool _isLoading = false;
  final bool _isModal = false;

  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
  }

  void produtoAddCarrinho(ProdutoModel product) {
    // product.productCar = !product.productCar;
    // if (product.productCar) {
    produtosCarrinho.add(product);
    print(produtosCarrinho);
    notifyListeners();
    // } else {
    //   store.produtosCarrinho.remove(product);
    //   notifyListeners();
  }

//curtida
  void toggleFavorite(ProdutoModel product, HomeStore store) {
    product.isLiked = !product.isLiked;
    if (product.isLiked) {
      store.produtosCurtidos.add(product);
      notifyListeners();
    } else {
      store.produtosCurtidos.remove(product);
      notifyListeners();
    }
  }

//api
  Future<List<ProdutoModel>> fetchProducts() async {
    try {
      setLoading(true);
      final produto = await homeService.fetchProducts();
      listaProdutos = produto;
      notifyListeners();
      return produto;
    } catch (e) {
      return [];
    } finally {
      setLoading(false);
    }
  }
}
