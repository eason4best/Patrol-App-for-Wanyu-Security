class Customer {
  final int? customerId;
  final String? customerName;
  final double? lat;
  final double? lng;
  Customer({
    this.customerId,
    this.customerName,
    this.lat,
    this.lng,
  });

  Map<String, dynamic> toMap() => {
        'customer_id': customerId,
        'firstname': customerName,
        'lat': lat,
        'lng': lng,
      };

  factory Customer.fromMap(data) {
    if (data == null) {
      return Customer();
    }
    final int? customerId = data['customer_id'] is String
        ? int.parse(data['customer_id'])
        : data['customer_id'];
    final String? customerName = data['firstname'];
    final double? lat =
        data['lat'] is String ? double.parse(data['lat']) : data['lat'];
    final double? lng =
        data['lng'] is String ? double.parse(data['lng']) : data['lng'];
    return Customer(
      customerId: customerId,
      customerName: customerName,
      lat: lat,
      lng: lng,
    );
  }
}
