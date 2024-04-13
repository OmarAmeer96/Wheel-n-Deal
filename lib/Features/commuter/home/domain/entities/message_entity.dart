import 'package:hive/hive.dart';
part 'message_entity.g.dart';

@HiveType(typeId: 0)
class MessageEntity {
  @HiveField(0)
  final String senderName;
  @HiveField(1)
  final String? message;
  @HiveField(2)
  final String receiverName;
  @HiveField(3)
  final DateTime? sentAt;
  @HiveField(4)
  final bool? read;

  MessageEntity({
    required this.senderName,
    required this.message,
    required this.receiverName,
    required this.sentAt,
    required this.read,
  });
}
