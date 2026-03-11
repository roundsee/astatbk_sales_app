import 'package:astatbk_sales_app/models/product.dart';
import 'package:astatbk_sales_app/screens/cart_screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
// import models & screens lainnya...

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk testing UI
final List<Product> dummyProducts = [
  Product(id: 1, name: 'Semen Gresik', sku: 'SG-01', stock: 50, price: 60000),
  Product(id: 2, name: 'Paku Beton', sku: 'PB-05', stock: 100, price: 15000),
  Product(id: 3, name: 'Cat Avitex 5kg', sku: 'CA-01', stock: 20, price: 145000),
];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Katalog Produk"),
        actions: [
          // Icon Keranjang dengan Badge jumlah barang
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
               // Update bagian onPressed di Icon Keranjang
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartScreen(products: dummyProducts),
                          ),
                        );
                      },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.red,
                  child: Consumer<CartProvider>(
                    builder: (context, cart, _) => Text(
                      '${cart.totalItems}',
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: ListView.builder(
        itemCount: dummyProducts.length,
        itemBuilder: (context, index) {
          final p = dummyProducts[index];
          return ListTile(
            title: Text(p.name),
            subtitle: Text("Rp ${p.price}"),
            trailing: ElevatedButton(
              onPressed: () {
                context.read<CartProvider>().addToCart(p.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${p.name} ditambah"), duration: Duration(seconds: 1)),
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}