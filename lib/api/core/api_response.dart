class ApiResponse<T> {
  Status status;
  T? data;
  String? message;

  ApiResponse.initial() : status = Status.initial;

  ApiResponse.loading() : status = Status.loading;

  ApiResponse.completed(this.data) : status = Status.completed;

  ApiResponse.error(this.message) : status = Status.error;

  @override
  String toString() => "Status : $status \n Message : $message \n Data : $data";

  /// 是否完成
  bool get isCompleted => status == Status.completed;
}

enum Status { initial, loading, completed, error }
