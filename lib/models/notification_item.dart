class NotificationItem {
  String? messageId;
  String? messageTitle;
  String? messageContent;
  String? messageAdsId;
  int? messageView;
  String? messageIsViewed;
  String? messageSender;
  String? messageSenderId;
  String? messageSenderType;
  String? messageDate;
  String? delete;

  NotificationItem({
    this.messageId,
    this.messageTitle,
    this.messageContent,
    this.messageAdsId,
    this.messageView,
    this.messageIsViewed,
    this.messageSender,
    this.messageSenderId,
    this.messageSenderType,
    this.messageDate,
    this.delete,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      NotificationItem(
        messageId: json["message_id"],
        messageTitle: json["message_title"],
        messageContent: json["message_content"],
        messageAdsId: json["message_ads_id"],
        messageView: json["message_view"],
        messageIsViewed: json["message_is_viewed"],
        messageSender: json["message_sender"],
        messageSenderId: json["message_sender_id"],
        messageSenderType: json["message_sender_type"],
        messageDate: json["message_date"],
        delete: json["delete"],
      );

  Map<String, dynamic> toJson() => {
    "message_id": messageId,
    "message_title": messageTitle,
    "message_content": messageContent,
    "message_ads_id": messageAdsId,
    "message_view": messageView,
    "message_is_viewed": messageIsViewed,
    "message_sender": messageSender,
    "message_sender_id": messageSenderId,
    "message_sender_type": messageSenderType,
    "message_date": messageDate,
    "delete": delete,
  };
}
