class Product {
  final int id;
  final String name;
  final String sku;
  final int stock;
  final double price;
  final String? imageUrl; // Opsional jika nanti ada foto produk

  Product({
    required this.id, 
    required this.name, 
    required this.sku, 
    required this.stock, 
    required this.price,
    this.imageUrl,
  });

  // Method ini akan sangat berguna saat kita ambil data dari API Laravel nanti
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      sku: json['sku'] ?? '',
      stock: json['stock'] ?? 0,
      // Mengantisipasi jika API mengirim angka dalam bentuk String atau Int
      price: double.parse(json['price'].toString()), 
      imageUrl: json['image_url'],
    );
  }

  // Method untuk mengubah objek kembali ke Map (jika butuh kirim data ke API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'stock': stock,
      'price': price,
    };
  }
}