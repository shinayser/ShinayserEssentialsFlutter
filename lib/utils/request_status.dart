class RequestStatus {
  final String name;

  const RequestStatus._internal(this.name);

  static const RequestStatus IDLE = const RequestStatus._internal("IDLE");
  static const RequestStatus WAITING = const RequestStatus._internal("WAITING");
  static const RequestStatus DONE = const RequestStatus._internal("DONE");
  static const RequestStatus ERROR = const RequestStatus._internal("ERROR");

  @override
  String toString() => name;
}

class RequestObject<T> {
  T result;
  dynamic error;
  RequestStatus status;
  dynamic tag; //A dynamic value to identify this RequestObject

  RequestObject(this.result, this.status);

  RequestObject.done({this.result, this.tag}) {
    this.status = RequestStatus.DONE;
  }

  RequestObject.error({this.error, this.tag, this.result}) {
    this.status = RequestStatus.ERROR;
  }

  RequestObject.waiting({this.result, this.tag}) {
    this.status = RequestStatus.WAITING;
  }

  RequestObject.idle({this.result, this.tag}) {
    this.status = RequestStatus.IDLE;
  }

  @override
  String toString() =>
      "RequestObject {$status} ${result != null ? "{$result}" : ""}";
}
