class GiftModel {
  final String id;
  final String title;
  final String tier;
  final double price;
  final String date;

  GiftModel({
    required this.id,
    required this.title,
    required this.tier,
    required this.price,
    required this.date,
  });

  // Firestore'a göndermek için Map'e dönüştürür
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'tier': tier,
      'price': price,
      'date': date,
    };
  }

  // Firestore'dan gelen veriyi modele dönüştürür
  factory GiftModel.fromMap(Map<String, dynamic> map) {
    return GiftModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      tier: map['tier'] ?? '',
      price: (map['price'] as num).toDouble(),
      date: map['date'] ?? '',
    );
  }
}