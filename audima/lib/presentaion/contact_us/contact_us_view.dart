import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:audima/presentaion/contact_us/contact_us_view_widgets.dart';
import 'package:audima/presentaion/contact_us/email.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:audima/presentaion/presentation_widgets.dart';
import 'package:audima/presentaion/resources/styles_manager.dart';
import 'package:audima/responsive.dart';
import '../resources/assets_manager.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({Key? key}) : super(key: key);

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  @override
  void initState() {
    super.initState();
  }

  bool _isLoaderVisible = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 5,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomizedText(
                text: "Sending Your Email",
                textStyle: ResponsiveTextStyles.mainTabsStyle(context))
          ],
        ),
      ),
      overlayColor: Colors.black,
      overlayOpacity: 0.8,
      child: ScrollingWidget(
        scrollController: scrollController,
        child: ListView(
          controller: scrollController,
          children: [
            ResponsiveRowColumn(
              rowMainAxisSize: MainAxisSize.min,
              columnMainAxisSize: MainAxisSize.min,
              layout:
                  ResponsiveWrapper.of(context).isSmallerThan("LARGERTABLET")
                      ? ResponsiveRowColumnType.COLUMN
                      : ResponsiveRowColumnType.ROW,
              children: [
                ResponsiveRowColumnItem(
                  rowFlex: 1,
                  columnFlex: 2,
                  child: ResponsiveVisibility(
                    hiddenWhen: const [
                      Condition.smallerThan(name: "LARGERTABLET")
                    ],
                    replacement: SizedBox(
                      width: double.infinity,
                      child: Image.network(
                        OtherImages.contactUsImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SizedBox(
                      height: 600,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(550),
                          bottomRight: Radius.circular(550),
                        ),
                        child: Image.network(
                          OtherImages.contactUsImage,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                ResponsiveRowColumnItem(
                  columnFlex: 1,
                  rowFlex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 40,
                        left: ResponsiveValues.contactUsTextFieldsLeftPadding(
                            context),
                        right: ResponsiveValues.contactUsTextFieldsLeftPadding(
                            context)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: CustomizedTextNotCentered(
                            text: "Get in touch",
                            textStyle:
                                ResponsiveTextStyles.getInTouchStyle(context),
                          ),
                        ),
                        //
                        const SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: TextField(
                            controller: nameController,
                            decoration:
                                contactUsInputDecoration("Name", "Name"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Flexible(
                          fit: FlexFit.loose,
                          child: TextField(
                            controller: companyController,
                            decoration:
                                contactUsInputDecoration("Company", "Company"),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        Flexible(
                          fit: FlexFit.loose,
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (input) =>
                                input!.isValidEmail(emailController.text)
                                    ? null
                                    : "Check your email",
                            controller: emailController,
                            decoration:
                                contactUsInputDecoration("Email", "Email"),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: TextField(
                            controller: mobileController,
                            decoration:
                                contactUsInputDecoration("Mobile", "Mobile"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 2,
                          child: TextField(
                            maxLines: 5,
                            controller: messageController,
                            decoration:
                                contactUsInputDecoration("Message", "Message"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Center(
                            child: Container(
                              height: 40,
                              width: ResponsiveValues.submitWidth(context),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 156, 178, 188),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: InkWell(
                                child: CustomizedText(
                                    text: "Submit",
                                    textStyle: StylesManager.contactUsSubmit),
                                onTap: () async {
                                  context.loaderOverlay.show();
                                  setState(() {
                                    _isLoaderVisible =
                                        context.loaderOverlay.visible;
                                  });

                                  await sendEmail(
                                      name: nameController,
                                      company: companyController,
                                      email: emailController,
                                      mobile: mobileController,
                                      message: messageController,
                                      context: context);
                                  if (_isLoaderVisible) {
                                    context.loaderOverlay.hide();
                                  }
                                  setState(() {
                                    _isLoaderVisible =
                                        context.loaderOverlay.visible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        //
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 50,
                  bottom: 50,
                  left: ResponsiveValues.contactUsServicesLeftRightPadding(
                      context),
                  right: ResponsiveValues.contactUsServicesLeftRightPadding(
                      context)),
              child: ResponsiveRowColumn(
                columnMainAxisSize: MainAxisSize.min,
                layout:
                    ResponsiveWrapper.of(context).isSmallerThan("LARGERTABLET")
                        ? ResponsiveRowColumnType.COLUMN
                        : ResponsiveRowColumnType.ROW,
                children: [
                  ResponsiveRowColumnItem(
                    rowFit: FlexFit.loose,
                    columnFit: FlexFit.loose,
                    rowFlex: 1,
                    columnFlex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: ResponsiveValues.desktopContactContainerPadding(
                            context),
                        right: ResponsiveValues.desktopContactContainerPadding(
                            context),
                      ),
                      child: Column(
                        children: const [
                          ResponsiveVisibility(
                            hiddenWhen: [
                              Condition.largerThan(name: "LARGERTABLET")
                            ],
                            child: SizedBox(
                              height: 50,
                            ),
                          ),
                          DesktopContactContainer(
                              icon: FontAwesomeIcons.phone,
                              text1: "Call Us",
                              text2: "+20 010 66 515 611"),
                        ],
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFit: FlexFit.loose,
                    columnFit: FlexFit.loose,
                    rowFlex: 1,
                    columnFlex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: ResponsiveValues.desktopContactContainerPadding(
                            context),
                        right: ResponsiveValues.desktopContactContainerPadding(
                            context),
                      ),
                      child: Column(
                        children: const [
                          ResponsiveVisibility(
                            hiddenWhen: [
                              Condition.largerThan(name: "LARGERTABLET")
                            ],
                            child: SizedBox(
                              height: 50,
                            ),
                          ),
                          DesktopContactContainer(
                              icon: FontAwesomeIcons.locationDot,
                              text1: "Location",
                              text2:
                                  "56 El-Manial St. El-manial, Cairo - Egypt"),
                        ],
                      ),
                    ),
                  ),
                  ResponsiveRowColumnItem(
                    rowFit: FlexFit.loose,
                    columnFit: FlexFit.loose,
                    rowFlex: 1,
                    columnFlex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: ResponsiveValues.desktopContactContainerPadding(
                            context),
                        right: ResponsiveValues.desktopContactContainerPadding(
                            context),
                      ),
                      child: Column(
                        children: const [
                          ResponsiveVisibility(
                            hiddenWhen: [
                              Condition.largerThan(name: "LARGERTABLET")
                            ],
                            child: SizedBox(
                              height: 50,
                            ),
                          ),
                          DesktopContactContainer(
                              icon: FontAwesomeIcons.message,
                              text1: "Email Us",
                              text2: " info@tmico.com.eg"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
