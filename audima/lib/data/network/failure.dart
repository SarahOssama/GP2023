class Failure {
  int code; //code come from backend like 200, 400 and so on
  String message; //message come from backend like "success", "failed"
  Failure(this.code, this.message);
}
