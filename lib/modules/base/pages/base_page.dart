import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trocapc/modules/base/widgets/modal_products_widget.dart';
import 'package:trocapc/modules/home/pages/home_page.dart';
import 'package:trocapc/modules/home/stores/home_stores.dart';
import 'package:trocapc/modules/profile/pages/profile_page.dart';
import 'package:trocapc/modules/searchProducts/pages/seacrh_products.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showModal(BuildContext context) {
    final store = Provider.of<HomeStore>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ModalProdutcs(produtos: store.produtosCarrinho);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<HomeStore>(context);

    final List<Widget> _screens = [
      HomePage(),
      FiltroTela(
        produtos: store.listaProdutos,
      ),
      ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => _showModal,
              child: Stack(children: [
                IconButton(
                    onPressed: () {
                      _showModal(context);
                    },
                    icon: const Icon(Icons.shopping_cart_outlined)),
                store.produtosCarrinho.isEmpty
                    ? Container()
                    : Positioned(
                        right: 5,
                        child: Container(
                          alignment: Alignment.center,
                          width: 15,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(50)),
                          child: Text(store.produtosCarrinho.length.toString()),
                        ))
              ]),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(),
          )
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Abre o Drawer
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Produtos",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              ),
              ListTile(
                title: const Text('Placa de vídeo'),
                onTap: () {
                  // Implemente a lógica desejada para o item 1
                },
              ),
              ListTile(
                title: const Text('Processadores'),
                onTap: () {
                  // Implemente a lógica desejada para o item 1
                },
              ),
              ListTile(
                title: const Text('Computadores'),
                onTap: () {
                  // Implemente a lógica desejada para o item 1
                },
              ),
              ListTile(
                title: const Text('Notebook'),
                onTap: () {
                  // Implemente a lógica desejada para o item 1
                },
              ),
              ListTile(
                title: const Text('Peças'),
                onTap: () {
                  // Implemente a lógica desejada para o item 2
                },
              ),
              const Divider(
                height: 3,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Conta",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              ),
              ListTile(
                title: const Text('Opções'),
                onTap: () {
                  // Implemente a lógica desejada para o item 1
                },
              ),
              ListTile(
                title: const Text('Compras'),
                onTap: () {
                  // Implemente a lógica desejada para o item 1
                },
              ),
              ListTile(
                title: const Text('Sair'),
                onTap: () {
                  // Implemente a lógica desejada para o item 2
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
