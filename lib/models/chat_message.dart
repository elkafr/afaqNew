class ChatMessage {
  ChatMessage({
    this.messageId,
    this.messageContent,
    this.messageView,
    this.messageSender,
    this.messageSenderImage,
    this.senderUserId,
    this.messageAds,
    this.messageDate,
  });

  String? messageId;
  String? messageContent;
  String? messageView;
  String? messageSender;
  String? messageSenderImage;
  String? senderUserId;
  String? messageAds;
  String? messageDate;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
    messageId: json["message_id"],
    messageContent: json["message_content"],
    messageView: json["message_view"],
    messageSender: json["message_sender"],
    messageSenderImage: json["message_sender_image"],
    senderUserId: json["sender_user_id"],
    messageAds: json["message_ads"],
    messageDate: json["message_date"],
  );

  Map<String, dynamic> toJson() => {
    "message_id": messageId,
    "message_content": messageContent,
    "message_view": messageView,
    "message_sender": messageSender,
    "message_sender_image": messageSenderImage,
    "sender_user_id": senderUserId,
    "message_ads": messageAds,
    "message_date": messageDate,
  };
}
