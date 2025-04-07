import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../contrller/services/datacontroller.dart';
import '../../contrller/services/image_controller.dart';
import '../../modles/user_modle.dart';
import '../widgets/custom_buttons.dart';
import '../widgets/custom_textfields.dart';

class UpdateData extends StatefulWidget {
  final UserModles userModles;
  final int index;

  const UpdateData({super.key, required this.userModles, required this.index});

  @override
  State<UpdateData> createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;
  final DataController dataController = Get.put(DataController());

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userModles.username);
    addressController = TextEditingController(text: widget.userModles.address);
    emailController = TextEditingController(text: widget.userModles.email);
    passwordController = TextEditingController(text: widget.userModles.password);
    phoneController = TextEditingController(text: widget.userModles.phone);
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ImageController imageController = Get.put(ImageController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Data"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
                child: Obx(
                      () => CircleAvatar(
                    radius: 50,
                    backgroundImage: imageController.imagePath.value.isNotEmpty
                        ? FileImage(File(imageController.imagePath.value))
                        : (widget.userModles.image != null && widget.userModles.image!.isNotEmpty
                        ? FileImage(File(widget.userModles.image!))
                        : const AssetImage("assets/default_avatar.png")) as ImageProvider,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFieldWidget(
                hintText: "Enter Your Name",
                iconData: Icons.person,
                keyboardType: TextInputType.text,
                controller: nameController,
              ),
              const SizedBox(height: 10),
              CustomTextFieldWidget(
                hintText: "Enter Your Address",
                iconData: Icons.home,
                keyboardType: TextInputType.text,
                controller: addressController,
              ),
              const SizedBox(height: 10),
              CustomTextFieldWidget(
                hintText: "Enter Your Email",
                iconData: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
              ),
              const SizedBox(height: 10),
              CustomTextFieldWidget(
                hintText: "Enter Your Password",
                iconData: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              CustomTextFieldWidget(
                hintText: "Enter Your Phone",
                iconData: Icons.phone,
                keyboardType: TextInputType.phone,
                controller: phoneController,
              ),
              const SizedBox(height: 20),
              CustomButtons(
                onPress: () async {
                  if (nameController.text.isEmpty ||
                      addressController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      phoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("All fields are required")),
                    );
                    return;
                  }

                  bool success = await dataController.updateData(
                    userModles: UserModles(
                      username: nameController.text,
                      address: addressController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      phone: phoneController.text,
                      image: imageController.imagePath.value.isNotEmpty
                          ? imageController.imagePath.value
                          : widget.userModles.image, // Update the image if available
                    ),
                    index: widget.index,
                  );

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Data Updated Successfully")),
                    );
                    dataController.getAllData();
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to Update Data")),
                    );
                  }
                },
                text: "Update Data",
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
