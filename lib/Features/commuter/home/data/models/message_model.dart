// import 'package:wheel_n_deal/Features/commuter/home/domain/entities/message_entity.dart';

// class MessageModel extends MessageEntity {
//   String? senderName;
//   String? mesasge;
//   String? receiverName;
//   DateTime? sentAt;
//   bool? read;

//   MessageModel({
//     this.senderName,
//     this.mesasge,
//     this.receiverName,
//     this.sentAt,
//     this.read,
//   }) : super(
//           senderName: senderName!,
//           message: mesasge!,
//           receiverName: receiverName!,
//           sentAt: DateTime.parse(sentAt as String),
//           read: read!,
//         );

//   factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
//         senderName: json['senderName'] as String?,
//         mesasge: json['receiverName'] as String?,
//         receiverName: json['message'] as String?,
//         sentAt: json['sentAt'] as DateTime?,
//         read: json['read'] as bool?,
//       );

//   Map<String, dynamic> toJson() => {
//         'senderName': senderName,
//         'receiverName': receiverName,
//         'message': mesasge,
//         'sentAt': sentAt,
//         'read': read,
//       };
// }
