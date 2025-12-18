class MessageAnalyticsModel {

  int? total;
  int? unread;

  MessageAnalyticsModel({
    this.total,
    this.unread
  });

  MessageAnalyticsModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    unread = json['unread'];
  }
}