import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../controller/login_controller.dart';
import '../../gui_kit/template.dart';
import '../../view/todo_screen.dart';

class Login extends StatelessWidget {
   Login({super.key});

  late Widget forgetPassword;
  late Widget header;
  late Widget box;
  late Widget button;
  late Widget sizeBox;



  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    HomeController passwordController = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
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
                  child: const Text("Sign in with email", style: TextStyle(color: Colors.black, fontSize: 20),),
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
                    errorBorder:  UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, top: 5.0),
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Forget password?",
                        style: TextStyle(color: Colors.blueAccent, fontSize: 13.0),
                      )),
                )
              ],
            ),
            const SizedBox(height: 60.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center, // mainAxisAlignment: MainAxisAlignment.space,
              children: [
               Obx(() => TextElevatedButtonTemplate(
                  height: 60,
                  width: 900,
                  text: "Sign In",
                  textStyle: TextStyle(color: Colors.white, fontSize: 15),
                  boxShadowColor: Colors.white,
                  color: controller.enableButton.value ? Colors.black : Color(0xffcdcdcd),
                  onPressed: () {
                    controller.enableButton.value ? () {} : null;
                    controller.onLogin();
                    Get.to(const ToDoScreen());
                  },
                  elevation: 0, ),),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Row(
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
                ),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}
