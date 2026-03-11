import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  // Map untuk menyimpan ID Produk dan jumlahnya
  final Map<int, int> _items = {};

  Map<int, int> get items => _items;

  void addToCart(int productId) {
    if (_items.containsKey(productId)) {
      _items[productId] = _items[productId]! + 1;
    } else {
      _items[productId] = 1;
    }
    notifyListeners(); // Memberitahu UI untuk update tampilan
  }

  int get totalItems => _items.values.fold(0, (sum, item) => sum + item);
  
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
  // Tambahkan ini di dalam class CartProvider
double getTotalPrice(List<Product> allProducts) {
  double total = 0.0;
  _items.forEach((productId, quantity) {
    final product = allProducts.firstWhere((p) => p.id == productId);
    total += product.price * quantity;
  });
  return total;
}

void removeItem(int productId) {
  _items.remove(productId);
  notifyListeners();
}

void decreaseQuantity(int productId) {
  if (_items.containsKey(productId)) {
    if (_items[productId]! > 1) {
      _items[productId] = _items[productId]! - 1;
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
}