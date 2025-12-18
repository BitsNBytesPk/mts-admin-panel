class Message {

  String? id;
  String? name;
  String? email;
  String? message;
  bool? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;

  Message({
    this.id,
    this.name,
    this.email,
    this.message,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  Message.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['sender_name'];
    email = json['sender_email'];
    message = json['message'];
    isRead = json['is_read'] ?? true;
    createdAt = json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null;
    updatedAt = json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null;
  }
}