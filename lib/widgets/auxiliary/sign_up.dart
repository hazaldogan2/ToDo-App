import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:todo/controller/sign_up_controller.dart';
import 'package:todo/widgets/auxiliary/login.dart';

import '../../controller/home_controller.dart';
import '../../gui_kit/template.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController controller = Get.put(SignUpController());
    HomeController passwordController = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 900,
                  alignment: Alignment.centerLeft,
                  child: const Text("Sign up with email", style: TextStyle(color: Colors.black, fontSize: 20),),
                ),
                const Text("Enter yoru email and password", style: TextStyle(color: Colors.grey, fontSize: 15),),
              ],
            ),
             Column(
              children: [
                SizedBox(height: 20,),
                TextField(
                  controller: controller.email,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Color(0xffa2a3a3), fontSize: 15, fontFamily: 'Barlow'),
                    hintText: "Email",
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    isDense: true,
                    errorMaxLines: 3,
                    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                SizedBox(height: 30,),
                Obx(()=>TextField(
                  obscureText: passwordController.isPasswordHidden.value,
                  controller: controller.password,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Color(0xffa2a3a3), fontSize: 15, fontFamily: 'Barlow'),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    suffix: InkWell(
                      child: Icon(passwordController.isPasswordHidden.value ? Icons.visibility : Icons.visibility_off, color: Colors.grey, size: 20,),
                      onTap: (){
                        passwordController.isPasswordHidden.value = !passwordController.isPasswordHidden.value;
                      },
                    ),
                    isDense: true,
                    errorMaxLines: 3,
                    border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  ),
                )),
              ],
            ),
            const SizedBox(height: 60.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center, // mainAxisAlignment: MainAxisAlignment.space,
              children: [
                Obx(()=> TextElevatedButtonTemplate(
                  height: 60,
                  width: 900,
                  text: "Create Account",
                  textStyle: TextStyle(color: Colors.white, fontSize: 15),
                  boxShadowColor: Colors.white,
                  color: controller.enableButton.value ? Colors.black : Color(0xffcdcdcd),
                  onPressed: () {
                    controller.enableButton.value ? () {} : null;
                    controller.onSignUp();
                  },
                  elevation: 0, ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("By continuing, you agree to our", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Privacy Policy",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        )),
                  ],
                ),
                TextButton(
                    onPressed: () { Get.to(Login());},
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    )),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}


// class SignUp extends StatefulWidget with WidgetMixin {
//   const SignUp({Key? key, required this.path, this.onSuccess}) : super(key: key);
//   final String path;
//   final VoidCallback? onSuccess;
//
//   @override
//   State<SignUp> createState() => SignUpState();
// }
//
// class SignUpState extends State<SignUp> with StateMixin {
//   late final EmailTextFormFieldTemplate emailTextFormFieldTemplate;
//   late final PasswordTextFormFieldTemplate passwordTextFormFieldTemplate;
//   late final Widget header;
//
//   late final List checkBoxTileMapList;
//   late final List<CheckBoxTemplate> checkBoxTileList;
//
//   late final FormFieldValidator<String?> validator;
//   late Widget numberErrorText;
//   late Widget lengthErrorText;
//   late Widget lowerCaseUpperCaseNumberErrorText;
//   late Widget specialCharacterErrorText;
//   late Widget warnings;
//   late Widget errorIcon;
//   late Widget approveIcon;
//
//   @override
//   void initState() {
//     header = Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: Style.vh0050,
//           width: Style.vw0900,
//           alignment: Alignment.centerLeft,
//           child: Text(managerService.config["SIGN_UP"]["HEADER_TITLE"], style: TextStyleTemplate.font18Black10AlterW600NormalExo),
//         ),
//         Padding(
//           padding: EdgeInsets.only(bottom: Style.vh0010),
//           child: Text(managerService.config["SIGN_UP"]["DESCRIPTION"], style: TextStyleTemplate.font14Grey500W400NormalBarlow),
//         ),
//       ],
//     );
//     emailTextFormFieldTemplate = EmailTextFormFieldTemplate(
//         visibility: true,
//         headerStyle: TextStyleTemplate.font13Black20AlterW500NormalBarlow,
//         labelText: managerService.config["HINT_TEXT"]["EMAIL"],
//         focusBorderColor: ColorTemplate.purple40,
//         errorTextStyle: TextStyleTemplate.font11Red20W400NormalPoppins);
//     passwordTextFormFieldTemplate = PasswordTextFormFieldTemplate(
//         hintText: managerService.config["HINT_TEXT"]["PASSWORD"],
//         visibility: true,
//         height: Style.vh0150,
//         complexPassword: false,
//         signUpPassword: true,
//         headerStyle: TextStyleTemplate.font13Black20AlterW500NormalBarlow,
//         focusBorderColor: ColorTemplate.purple40,
//         errorTextStyle: TextStyleTemplate.font11Red20W400NormalPoppins);
//
//     errorIcon = Padding(
//         padding: EdgeInsets.only(right: Style.vw0020, top: Style.vh0005),
//         child: SVGTemplate(
//           height: Style.vh0030,
//           width: Style.vw0030,
//           color: ColorTemplate.red30Const,
//           path: managerService.config["GENERAL_ICON_PATH"]["ERROR_ICON"],
//         ));
//     approveIcon = Padding(
//         padding: EdgeInsets.only(right: Style.vw0020, top: Style.vh0005),
//         child: SVGTemplate(
//           height: Style.vh0030,
//           width: Style.vw0030,
//           color: ColorTemplate.green30Const,
//           path: managerService.config["GENERAL_ICON_PATH"]["APPROVE_ICON"],
//         ));
//
//     checkBoxTileMapList = managerService.config["SIGN_UP"]["CHECKBOX_LIST"];
//     checkBoxTileList = [];
//
//     for (int index = 0; index < checkBoxTileMapList.length; index++) {
//       checkBoxTileList.add(CheckBoxTemplate(
//         text: checkBoxTileMapList[index]["TEXT_SPANS"],
//         must: checkBoxTileMapList[index]["MUST"],
//         visibility: true,
//         newDesign: true,
//         longText: true,
//       ));
//     }
//
//     refreshWarnings();
//     refreshVisibility();
//
//     addSubscriptable(PasswordTextFormFieldTemplate.lengthValidator.valueNotifier, [refreshWarnings, setStateIfMounted]);
//     addSubscriptable(PasswordTextFormFieldTemplate.numberValidator.valueNotifier, [refreshWarnings, setStateIfMounted]);
//     addSubscriptable(PasswordTextFormFieldTemplate.lowercaseValidator.valueNotifier, [refreshWarnings, setStateIfMounted]);
//     addSubscriptable(PasswordTextFormFieldTemplate.uppercaseValidator.valueNotifier, [refreshWarnings, setStateIfMounted]);
//     addSubscriptable(PasswordTextFormFieldTemplate.specialCharacterValidator.valueNotifier, [refreshWarnings, setStateIfMounted]);
//
//     addSubscriptable(PasswordTextFormFieldTemplate.focusDetector.valueNotifier, [refreshVisibility, setStateIfMounted]);
//
//     super.initState();
//   }
//
//   refreshVisibility() {
//     warnings = Padding(
//       padding: EdgeInsets.only(top: Style.vh0010, bottom: Style.vh0010),
//       child: Visibility(
//         visible: PasswordTextFormFieldTemplate.focusDetector.value,
//         child: SizedBox(
//           height: Style.vh0020,
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               lengthErrorText,
//               Padding(
//                 padding: EdgeInsets.only(left: Style.vh0010, right: Style.vh0010),
//                 child: lowerCaseUpperCaseNumberErrorText,
//               ),
//               specialCharacterErrorText,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   refreshWarnings() {
//     lengthErrorText = Row(
//       children: [
//         PasswordTextFormFieldTemplate.lengthValidator.check(true) ? approveIcon : errorIcon,
//         PasswordTextFormFieldTemplate.lengthValidator.check(true)
//             ? Text(managerService.config["SIGN_UP"]["PASSWORD_ERROR_LIST"]["LENGTH"], style: TextStyleTemplate.font10Green30ConstW400NormalBarlow)
//             : Text(managerService.config["SIGN_UP"]["PASSWORD_ERROR_LIST"]["LENGTH"], style: TextStyleTemplate.font10Red30ConstW400NormalBarlow)
//       ],
//     );
//     lowerCaseUpperCaseNumberErrorText = Row(
//       children: [
//         (PasswordTextFormFieldTemplate.lowercaseValidator.check(true) && PasswordTextFormFieldTemplate.numberValidator.check(true) && PasswordTextFormFieldTemplate.uppercaseValidator.check(true))
//             ? approveIcon
//             : errorIcon,
//         (PasswordTextFormFieldTemplate.lowercaseValidator.check(true) && PasswordTextFormFieldTemplate.numberValidator.check(true) && PasswordTextFormFieldTemplate.uppercaseValidator.check(true))
//             ? Text(managerService.config["SIGN_UP"]["PASSWORD_ERROR_LIST"]["LETTER_AND_NUMBER"], style: TextStyleTemplate.font10Green30ConstW400NormalBarlow)
//             : Text(managerService.config["SIGN_UP"]["PASSWORD_ERROR_LIST"]["LETTER_AND_NUMBER"], style: TextStyleTemplate.font10Red30ConstW400NormalBarlow)
//       ],
//     );
//     specialCharacterErrorText = Row(
//       children: [
//         PasswordTextFormFieldTemplate.specialCharacterValidator.check(true) ? approveIcon : errorIcon,
//         PasswordTextFormFieldTemplate.specialCharacterValidator.check(true)
//             ? Text(managerService.config["SIGN_UP"]["PASSWORD_ERROR_LIST"]["SPECIAL_CHARACTER"], style: TextStyleTemplate.font10Green30ConstW400NormalBarlow)
//             : Text(managerService.config["SIGN_UP"]["PASSWORD_ERROR_LIST"]["SPECIAL_CHARACTER"], style: TextStyleTemplate.font10Red30ConstW400NormalBarlow)
//       ],
//     );
//     refreshVisibility();
//   }
//
//   void signUp() {
//     emailTextFormFieldTemplate.state.focusNode.unfocus();
//     passwordTextFormFieldTemplate.state.focusNode.unfocus();
//
//     bool checkBoxValidation = true;
//     for (int index = 0; index < checkBoxTileList.length; index++) {
//       checkBoxValidation &= checkBoxTileList[index].state.validate();
//     }
//
//     if ((emailTextFormFieldTemplate.state.visibility && !emailTextFormFieldTemplate.state.formKey.currentState!.validate()) &&
//             (passwordTextFormFieldTemplate.state.visibility && !passwordTextFormFieldTemplate.state.formKey.currentState!.validate()) ||
//         (!PasswordTextFormFieldTemplate.lengthValidator.value) ||
//         (!PasswordTextFormFieldTemplate.lowercaseValidator.value) ||
//         (!PasswordTextFormFieldTemplate.uppercaseValidator.value) ||
//         (!PasswordTextFormFieldTemplate.specialCharacterValidator.value) ||
//         (!PasswordTextFormFieldTemplate.numberValidator.value)) {
//       var value = managerService.config["RESPONSE_TABLE"]["2003"];
//       managerService.snackbarService.openBlockingSnackBar(value["is_okay"], managerService.codeHandler(value));
//       return;
//     }
//
//     if (!checkBoxValidation) {
//       var value = managerService.config["RESPONSE_TABLE"]["2003"];
//       managerService.snackbarService.openBlockingSnackBar(value["is_okay"], managerService.codeHandler(value));
//       return;
//     }
//
//     Map data = {
//       "user_email": emailTextFormFieldTemplate.state.controller.text,
//       "password": passwordTextFormFieldTemplate.state.controller.text,
//       "kvkk_accepted": checkBoxTileList[0].state.checked.value,
//       "consent_text_accepted": checkBoxTileList[1].state.checked.value,
//       "user_agreement_accepted": checkBoxTileList[0].state.checked.value,
//       "auction_rules_accepted": checkBoxTileList[2].state.checked.value,
//       "commercials_accepted": checkBoxTileList[0].state.checked.value,
//       "data_processing_accepted": checkBoxTileList[0].state.checked.value,
//     };
//     managerService.userService.userSignUp(data).then((value) {
//       AccountVerification.isAccountVerificationRequired = true;
//       managerService.sharedPreferencesService.setSecureStorage<String>("user_email", emailTextFormFieldTemplate.state.controller.text);
//       managerService.sharedPreferencesService.setSecureStorage<String>("password", passwordTextFormFieldTemplate.state.controller.text);
//       managerService.sharedPreferencesService.set<String>("account_verification_email", emailTextFormFieldTemplate.state.controller.text);
//       managerService.sharedPreferencesService.set<String>("account_verification_code", "");
//       managerService.marketingService.logEvent("sign_up");
//       managerService.marketingService.setInsiderEvent("signUpConfirmation");
//       managerService.drawerService.close("OnBoardingPage");
//       //managerService.drawerService.switchTop("AccountVerification");
//       widget.onSuccess?.call(); // todo procedural
//     }).catchError((value) {
//       if ([201].contains(value["code"])) {
//         emailTextFormFieldTemplate.state.setError();
//       }
//       managerService.snackbarService.openBlockingSnackBar(value["is_okay"], managerService.codeHandler(value));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ExpandedSingleChildScrollTemplate(
//       physics: const BouncingScrollPhysics(),
//       padding: EdgeInsets.only(top: Style.vh0030),
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: Style.vh0030),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Column(
//                 children: [
//                   header,
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       emailTextFormFieldTemplate,
//                       passwordTextFormFieldTemplate,
//                       warnings,
//                       Column(children: checkBoxTileList),
//                     ],
//                   ),
//                   // const Spacer(),
//                   Padding(
//                     padding: EdgeInsets.only(top: Style.vh0070),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         TextElevatedButtonTemplate(
//                           height: Style.vh0060,
//                           width: Style.vw0900,
//                           text: managerService.config["SIGN_UP"]["TEXT_BUTTON_TITLE"]["SIGN_UP"],
//                           textStyle: TextStyleTemplate.font15White00AlterW500NormalPoppins,
//                           color: ColorTemplate.purple40Const,
//                           boxShadowColor: ColorTemplate.black00op21,
//                           onPressed: () {
//                             signUp();
//                           },
//                           elevation: 0,
//                         ),
//                         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                           AutoSizeTextTemplate(
//                             verticalPadding: Style.vh0010,
//                             horizontalPadding: Style.vw0010,
//                             text: managerService.config["SIGN_UP"]["TEXT_BUTTON_TITLE"]["IF_HAVE_ACCOUNT"],
//                             textStyle: TextStyleTemplate.font11Grey05W400NormalBarlow,
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               managerService.drawerService.switchTop("Login");
//                             },
//                             style: TextButton.styleFrom(
//                                 foregroundColor: ColorTemplate.blue10op15, minimumSize: Size.zero, padding: EdgeInsets.only(bottom: Style.vh0006), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
//                             child: Text(managerService.config["HOME"]["TEXT_BUTTON_TITLE"]["LOGIN"], style: TextStyleTemplate.font12Purple70W600NormalBarlow),
//                           )
//                         ])
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
