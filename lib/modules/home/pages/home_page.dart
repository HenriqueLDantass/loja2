import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trocapc/modules/home/stores/home_stores.dart';
import 'package:trocapc/modules/home/widgets/shimmer_widget.dart';
import 'package:trocapc/modules/produtos/models/produto_model.dart';
import 'package:trocapc/modules/produtos/pages/produtos_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final store = Provider.of<HomeStore>(context, listen: false);
    store.fetchProducts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAndShowModal();
  }

  Future<void> _checkAndShowModal() async {
    final prefs = await SharedPreferences.getInstance();
    final bool alreadyShown = prefs.getBool('modal_shown') ?? false;

    if (!alreadyShown) {
      await _showDialog();
      prefs.setBool('modal_shown', true);
    }
  }
  //modal

  Future<void> _showDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Compre pelo site!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset("assets/cupom.png"),
              const Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                    "Explore as ofertas exclusivas, descontos especiais e cupons disponíveis apenas para compras online. Não perca tempo, visite nosso site agora e descubra como economizar enquanto faz suas compras favoritas!!"),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Acessar site"),
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
      body: store.isLoading
          ? GridView.count(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              physics: const BouncingScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 9 / 11.5,
              children: List.generate(
                10,
                (index) => CustomShimmer(
                  height: double.infinity,
                  width: double.infinity,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: () {
                return store.fetchProducts();
              },
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                ),
                itemCount: store.listaProdutos.length,
                itemBuilder: (context, index) {
                  final ProdutoModel product = store.listaProdutos[index];
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Stack(
                              children: [
                                Image.network(
                                  product.image,
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 50,
                                    color: Colors.green,
                                    child: const Text(
                                      "Novo",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    product.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Text(product.category),
                                Text('\$${product.price.toStringAsFixed(2)}'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        color: product.isLiked
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                      onPressed: () {
                                        store.toggleFavorite(product, store);
                                      },
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => ProdutosPage(
                                              produtos:
                                                  store.listaProdutos[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text("Ver produto"),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
