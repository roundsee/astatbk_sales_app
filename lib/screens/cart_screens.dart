import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  final List<Product> products; // Kirim data produk dummy ke sini sementara

  const CartScreen({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final cartItems = cart.items;

    return Scaffold(
      appBar: AppBar(title: const Text("Detail Order")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Keranjang masih kosong"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      int productId = cartItems.keys.elementAt(index);
                      int quantity = cartItems.values.elementAt(index);
                      final product = products.firstWhere((p) => p.id == productId);

                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text("Rp ${product.price} x $quantity"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => cart.decreaseQuantity(productId),
                            ),
                            Text('$quantity'),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => cart.addToCart(productId),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 10)],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total Bayar:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("Rp ${cart.getTotalPrice(products)}", 
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          onPressed: () {
                            // NANTINYA: Kirim ke API Laravel
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Order berhasil disimpan!")),
                            );
                            cart.clearCart();
                            Navigator.pop(context);
                          },
                          child: const Text("SIMPAN ORDER", style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}