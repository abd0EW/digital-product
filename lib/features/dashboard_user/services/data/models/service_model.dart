class ServiceModel {
  final String id;
  final String nameAr;
  final String? descriptionAr;
  final String currency;
  final String category;
  final double price;
  final String pricingUnit;
  final String paymentTiming;
  final bool isActive;
  final int sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ServiceModel({
    required this.id,
    required this.nameAr,
    required this.descriptionAr,
    required this.category,
    required this.currency,
    required this.price,
    required this.pricingUnit,
    required this.paymentTiming,
    required this.isActive,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String,
      nameAr: json['name_ar'] as String,
      descriptionAr: json['description_ar'] as String?,
      category: json['category'] as String,
      currency: json["currency"],
      price: (json['price'] as num).toDouble(),
      pricingUnit: json['pricing_unit'] as String,
      paymentTiming: json['payment_timing'] as String,
      isActive: json['is_active'] as bool,
      sortOrder: (json['sort_order'] as num).toInt(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'description_ar': descriptionAr,
      'category': category,
      'price': price,
      "currency": currency,
      'pricing_unit': pricingUnit,
      'payment_timing': paymentTiming,
      'is_active': isActive,
      'sort_order': sortOrder,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
