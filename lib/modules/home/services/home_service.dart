import 'package:dio/dio.dart';
import 'package:trocapc/modules/produtos/models/produto_model.dart';

class HomeService {
  final Dio dio = Dio();

  Future<List<ProdutoModel>> fetchProducts() async {
    try {
      final response = await dio.get('https://fakestoreapi.com/products');
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        final List<ProdutoModel> products =
            responseData.map((json) => ProdutoModel.fromJson(json)).toList();

        return products;
      } else {
        throw Exception('Erro ao carregar produtos: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao carregar produtos: $e');
      return [];
    }
  }
}
