import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile_page_bloc.dart';
import 'dart:html' as html;
import 'dart:typed_data';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  html.File? imageFile;
  Uint8List? imageBytes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProfilePageBloc>().add(
          GetMyUserInfo(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfilePageBloc, ProfilePageState>(
      listenWhen: (lastState, state) {
        return lastState is! ProfilePageLoadedState;
      },
      listener: (context, state) {
        if (state is ProfilePageLoadedState) {
          _nameController.text = state.userInfo?.name ?? '';
          _emailController.text = state.userInfo?.email ?? '';
          _passwordController.text = '';
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is ProfilePageLoadedState
              ? Center(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.pinkAccent, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: 350,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          const Center(
                            child: Text(
                              'ЛИЧНЫЙ КАБИНЕТ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Center(child: _buildProfilePicture(state.image)),
                          const SizedBox(height: 20),
                          _buildTextField('Имя', _nameController),
                          _buildTextField('Email', _emailController),
                          _buildTextField('Пароль', _passwordController,
                              isPassword: true),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: _buildActionButton(
                                  text: 'Сохранить',
                                  isPrimary: true,
                                  onPressed: () {
                                    context.read<ProfilePageBloc>().add(
                                          ChangeUserInfo(
                                            name: _nameController.text,
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                            image: imageFile,
                                          ),
                                        );
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Text('Загрузка'),
                ),
        );
      },
    );
  }

  void pickImageFromFileSystem() {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/jpeg'; // Ограничиваем выбор до jpg
    uploadInput.click(); // Открывает проводник

    uploadInput.onChange.listen((event) {
      final file = uploadInput.files?.first;
      if (file != null) {
        imageFile = file;
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        reader.onLoad.listen((_) {
          setState(() {
            imageBytes = reader.result as Uint8List;
          });
        });
        //uploadImage(file: file);
      }
    });
  }

  Widget _buildActionButton({
    required String text,
    required bool isPrimary,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? Colors.pinkAccent : Colors.white,
        foregroundColor: isPrimary ? Colors.white : Colors.pinkAccent,
        side: isPrimary ? null : const BorderSide(color: Colors.pinkAccent),
        padding: const EdgeInsets.symmetric(vertical: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }

  Widget _buildProfilePicture(Uint8List? image) {
    return GestureDetector(
      onTap: () {
        pickImageFromFileSystem();
      },
      child: Stack(
        children: [
          if (imageBytes != null)
            ClipOval(
              child: Image.memory(
                imageBytes!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          if (imageBytes == null && image != null)
            ClipOval(
              child: Image.memory(
                image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          if (imageBytes == null && image == null)
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.pinkAccent,
              child: Icon(Icons.camera_alt, color: Colors.white, size: 30),
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: const Icon(Icons.edit, size: 16, color: Colors.pinkAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.pinkAccent),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.pinkAccent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.pinkAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.deepPurple),
          ),
        ),
      ),
    );
  }
}
