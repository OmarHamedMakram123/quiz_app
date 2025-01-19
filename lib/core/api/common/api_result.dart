sealed class Result<T>{}
class Success<T> extends Result<T>{
  final T  date;
  Success({required this.date});
}
class Failures<T> extends Result<T>{
  final Exception exception;
  Failures({required this.exception});
}