class ApiResponse {

  bool? success;
  int? statusCode;
  String? message;
  dynamic data;
  int? limit;
  int? page;

  ApiResponse({
    this.statusCode,
    this.success,
    this.message,
    this.data,
    this.page,
    this.limit
  });

  ApiResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'] ?? false;
    message = json['message'];
    data = json['data'];
    limit = json['limit'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data;
    data['limit'] = limit;
    data['page'] = page;
    return data;
  }
}