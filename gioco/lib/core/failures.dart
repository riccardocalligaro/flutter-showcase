class Failure {
  final String errorMessage;

  Failure({this.errorMessage});

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Failure && o.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}
