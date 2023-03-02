import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audima/presentaion/contact_us/contact_us_view_widgets.dart';
import 'package:audima/presentaion/resources/assets_manager.dart';
import 'package:audima/presentaion/resources/styles_manager.dart';

Future<void> sendEmail({
  required TextEditingController name,
  required TextEditingController company,
  required TextEditingController email,
  required TextEditingController mobile,
  required TextEditingController message,
  required BuildContext context,
}) async {
  const serviceId = 'service_r193jif';
  const templateId = 'template_tktrfho';
  const userId = 'HkQxpU0Uv5N8PcwTE';
  checkSentData(
      email.text, name.text, company.text, mobile.text, message.text, context);
  if (email.text.isValidEmail(email.text) &&
      email.text != "" &&
      name.text != "" &&
      company.text != "" &&
      mobile.text != "" &&
      message.text != "") {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        "Content-Type": 'application/json'
      },
      body: jsonEncode(
        {
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_message': message.text,
            'user_mobile': mobile.text,
            'user_company': company.text,
            'user_name': name.text,
            'user_email': email.text,
          },
        },
      ),
    );

    if (response.body == "OK") {
      name.clear();
      company.clear();
      email.clear();
      mobile.clear();
      message.clear();
      if (context.mounted) {
        checkSentEmail("true", context);
      }
    } else if (context.mounted) {
      checkSentEmail("false", context);
    }
  }
}

void checkSentData(String email, String name, String company, String mobile,
    String message, BuildContext context) {
  if (!email.isValidEmail(email)) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: CustomizedTextNotCentered(
          text:
              "The email you have entered is invalid please re-enter it correctly",
          textStyle: StylesManager.snackbarErrorMessage),
      duration: const Duration(seconds: 2),
    ));
  } else if (email == "" ||
      name == "" ||
      company == "" ||
      mobile == "" ||
      message == "") {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: CustomizedTextNotCentered(
          text: "Please fill out all the fields",
          textStyle: StylesManager.snackbarErrorMessage),
      duration: const Duration(seconds: 2),
    ));
  }
}

void checkSentEmail(String emailSent, BuildContext context) {
  if (emailSent == "true") {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: CustomizedTextNotCentered(
          text: "Your email has been sent succesfully",
          textStyle: StylesManager.snackbarErrorMessage),
      duration: const Duration(seconds: 2),
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: CustomizedTextNotCentered(
          text: "Error in sending your email",
          textStyle: StylesManager.snackbarErrorMessage),
      duration: const Duration(seconds: 2),
    ));
  }
}
