class ErrorModel {
  final int statusCode;
  final String statusMsg;
  final bool isSuccess;

  ErrorModel({
    required this.statusCode,
    required this.statusMsg,
    required this.isSuccess,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      statusCode: json['status_code'],
      statusMsg: json['status_message'],
      isSuccess: json['success'],
    );
  }

  factory ErrorModel.baseError(String errorMsg) {
    return ErrorModel(
      statusCode: -1,
      statusMsg: errorMsg,
      isSuccess: false,
    );
  }
}
