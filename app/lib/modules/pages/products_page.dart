import 'package:app/modules/models/devnology.dart';
import 'package:app/modules/models/in8.dart';
import 'package:app/modules/pages/login_page.dart';
import 'package:app/modules/services/auth_service.dart';
import 'package:app/modules/services/products_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     print("🔵 ENTROU NO BUILD DA PRODUCTSPAGE");
    final auth = context.watch<AuthService>();
    print("🔴 VOU CHAMAR O FUTUREBUILDER");
    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
                (route) => false,
              );
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: ProductsService.fetchProducts(auth.currentDomain!),
        builder: (_, snapshot) {
            print("DOMÍNIO ATUAL: ${auth.currentDomain}");
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final products = snapshot.data!;

          // ------------------------------------------------------------------
          // DEVNOLOGY (grid de 2 colunas)
          // ------------------------------------------------------------------
          if (auth.currentDomain == "devnology.local") {
            return Padding(
              padding: EdgeInsets.all(10),
              child: GridView.count(
                crossAxisCount: 2,        // <-- DUAS COLUNAS
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.70,  // Ajuste da altura do card
                children: products.map((p) {
                  final item = p as DevnologyProduct;
                    print(item.imagem);
                  return Card(
                    color: Theme.of(context).cardColor,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                            item.imagem, // ou gallery.first
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                Icon(Icons.broken_image, size: 80, color: Colors.grey),
                            ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                item.nome, // ou item.name
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Theme.of(context).primaryColor,
                                ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                item.descricao, // ou item.description
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                ),
                            ],
                            ),
                        ),
                        ],
                    ),
                    );
                }).toList(),
              ),
            );
          }

          // ------------------------------------------------------------------
          // IN8 (grid de 2 colunas)
          // ------------------------------------------------------------------
          if (auth.currentDomain == "in8.local") {
            return Padding(
              padding: EdgeInsets.all(10),
              child: GridView.count(
                crossAxisCount: 2, 
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.70,
                children: products.map((p) {
                  final item = p as In8Product;

                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            item.gallery.first,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                                return Image.network(
                                    "https://picsum.photos/400/300",
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                item.description,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }

          return Center(child: Text("Cliente desconhecido"));
        },
      ),
    );
  }
}
