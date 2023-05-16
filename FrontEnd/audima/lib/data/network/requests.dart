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

class UploadVideoRequest {
  File file;
  String caption;
  UploadVideoRequest(this.file, this.caption);
}

class EditVideoRequest {
  String command;
  EditVideoRequest(this.command);
}

class PreEditVideoRequest {
  String command;
  PreEditVideoRequest(this.command);
}
