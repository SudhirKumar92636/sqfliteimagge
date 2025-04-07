import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../contrller/services/datacontroller.dart';
import '../../contrller/services/image_controller.dart';
import '../../modles/user_modle.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/custom_textfields.dart';



class SignupScreens extends StatefulWidget {
  const SignupScreens({super.key});
  @override
  State<SignupScreens> createState() => _SignupScreensState();
}

class _SignupScreensState extends State<SignupScreens> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  DataController dataController = Get.put(DataController());
  ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp Screens"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text("Camera"),
                            onTap: () {
                              imageController.pickImage(ImageSource.camera);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.image_outlined),
                            title: Text("Gallery"),
                            onTap: () {
                              imageController.pickImage(ImageSource.gallery);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                // child: Obx(() => CircleAvatar(
                //   radius: 70,
                //   backgroundImage: imageController.imagePath.value.isNotEmpty
                //       ? FileImage(File(imageController.imagePath.value))
                //       : null,
                //   child: imageController.imagePath.value.isEmpty
                //       ? const Icon(Icons.person, size: 50)
                //       : null,
                // )),

                child: Obx(() => CircleAvatar(
                    radius: 70,
                    child: imageController.imagePath.value.isEmpty
                        ? const Icon(Icons.person, size: 50)
                        : Image.file(
                      File(imageController.imagePath.value),
                      fit: BoxFit.cover,
                    ),
                  )),
              ),
              SizedBox(height: 10),
              CustomTextFieldWidget(
                hintText: "Enter Your Name",
                iconData: Icons.person,
                keyboardType: TextInputType.text,
                controller: nameController,
              ),
              SizedBox(height: 10),

              CustomTextFieldWidget(
                hintText: "Enter Your Address",
                iconData: Icons.home,
                keyboardType: TextInputType.text,
                controller: addressController,
              ),
              SizedBox(height: 10),

              CustomTextFieldWidget(
                hintText: "Enter Your Email",
                iconData: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              SizedBox(height: 10),

              CustomTextFieldWidget(
                hintText: "Enter Your Password",
                iconData: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
              ),
              SizedBox(height: 10),

              CustomTextFieldWidget(
                hintText: "Enter Your Phone",
                iconData: Icons.phone,
                keyboardType: TextInputType.phone,
                controller: phoneController,
              ),
              CustomButtons(
                onPress: () async {
                  try {
                    UserModles userData = UserModles(
                      username: nameController.text.toString(),
                      address: addressController.text.toString(),
                      email: emailController.text.toString(),
                      password: passwordController.text.toString(),
                      phone: phoneController.text.toString(),
                      image: imageController.imagePath.value,
                    );
                    await dataController.insertData(userData);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Sign Up Successful",
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 3),
                      ),
                    );
                    dataController.getAllData();
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error: $e")));
                  }
                },
                text: "Sign Up",
                color: Colors.blue,
                radius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
