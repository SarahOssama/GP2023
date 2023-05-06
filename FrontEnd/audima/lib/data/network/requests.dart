import 'dart:io';

class LoginRequest {
  String email;
  String password;
  LoginRequest(this.email, this.password);
}

class BusinessInfoRequest {
  String bussinesInfoTextElements;
  BusinessInfoRequest(this.bussinesInfoTextElements);
}
class VideoRequest {
  File file;
  String caption;
  VideoRequest(this.file, this.caption);
}
