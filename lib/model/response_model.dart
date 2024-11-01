class APIResponse {
  bool? success;
  int code;
  String message;
  dynamic data;

  APIResponse({
    this.success,
    required this.code,
    required this.message,
    this.data,
  });

  APIResponse.fromJson(Map<dynamic, dynamic> json)
      : success = json["success"],
        code = json["code"] as int,
        message = json["message"] as String,
        data = json["data"];
}
