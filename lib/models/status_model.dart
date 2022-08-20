class Status {
  Status({
    required this.success,
    required this.errorCode,
    required this.errorDescription,
  });

  bool success;
  int errorCode;
  String errorDescription;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        success: json["success"],
        errorCode: json["error_code"],
        errorDescription: json["error_description"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "error_code": errorCode,
        "error_description": errorDescription,
      };
}