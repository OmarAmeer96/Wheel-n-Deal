class Datum {
  String? orderName;
  int? countOfOrders;
  int? weight;
  bool? breakable;
  String? expiryDate;
  int? expectedPrice;
  String? orderPhotoUrl;
  String? from;
  String? to;
  String? orderStatus;
  dynamic senderCode;
  dynamic receiverCode;
  int? negotiationPrice;
  dynamic cancellerId;
  int? id;
  String? senderName;
  String? senderPhoneNumber;
  String? receiverName;
  String? receiverPhoneNumber;

  Datum({
    this.orderName,
    this.countOfOrders,
    this.weight,
    this.breakable,
    this.expiryDate,
    this.expectedPrice,
    this.orderPhotoUrl,
    this.from,
    this.to,
    this.orderStatus,
    this.senderCode,
    this.receiverCode,
    this.negotiationPrice,
    this.cancellerId,
    this.id,
    this.senderName,
    this.senderPhoneNumber,
    this.receiverName,
    this.receiverPhoneNumber,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderName: json['orderName'] as String?,
        countOfOrders: json['countOfOrders'] as int?,
        weight: json['weight'] as int?,
        breakable: json['breakable'] as bool?,
        expiryDate: json['expiryDate'] as String?,
        expectedPrice: json['expectedPrice'] as int?,
        orderPhotoUrl: json['orderPhotoUrl'] as String?,
        from: json['from'] as String?,
        to: json['to'] as String?,
        orderStatus: json['orderStatus'] as String?,
        senderCode: json['senderCode'] as dynamic,
        receiverCode: json['receiverCode'] as dynamic,
        negotiationPrice: json['negotiationPrice'] as int?,
        cancellerId: json['cancellerId'] as dynamic,
        id: json['id'] as int?,
        senderName: json['senderName'] as String?,
        senderPhoneNumber: json['senderPhoneNumber'] as String?,
        receiverName: json['receiverName'] as String?,
        receiverPhoneNumber: json['receiverPhoneNumber'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'orderName': orderName,
        'countOfOrders': countOfOrders,
        'weight': weight,
        'breakable': breakable,
        'expiryDate': expiryDate,
        'expectedPrice': expectedPrice,
        'orderPhotoUrl': orderPhotoUrl,
        'from': from,
        'to': to,
        'orderStatus': orderStatus,
        'senderCode': senderCode,
        'receiverCode': receiverCode,
        'negotiationPrice': negotiationPrice,
        'cancellerId': cancellerId,
        'id': id,
        'senderName': senderName,
        'senderPhoneNumber': senderPhoneNumber,
        'receiverName': receiverName,
        'receiverPhoneNumber': receiverPhoneNumber,
      };
}
