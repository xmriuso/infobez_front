import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_web_project/core/theme/app_colors.dart';
import 'package:test_web_project/core/theme/typography.dart';
import 'package:test_web_project/feature/app/routing/route_path.dart';

import '../../my_courses_page/page/my_courses_page.dart';
import '../bloc/create_course_page_bloc.dart';
import 'dart:html' as html;
import 'dart:typed_data';

//изн
class CreateCoursePage extends StatefulWidget {
  final int? courseId;

  const CreateCoursePage({
    super.key,
    required this.courseId,
  });

  @override
  State<CreateCoursePage> createState() => _DetailCoursePage();
}

class _DetailCoursePage extends State<CreateCoursePage> {
  @override
  void initState() {
    super.initState();
    context.read<CreateCoursePageBloc>().add(
          LoadDetailCourseEvent(courseId: widget.courseId),
        );
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  html.File? imageFile;
  Uint8List? imageBytes;
  static double itemWidth = 250;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<CreateCoursePageBloc, CreateCoursePageState>(
      listenWhen: (lastState, state) {
        return lastState is! AllCoursesPageLoadedState;
      },
      listener: (context, state) {
        if (state is AllCoursesPageLoadedState) {
          _nameController.text = state.detailCourse?.title ?? '';
          _emailController.text = state.detailCourse?.description ?? '';
          context.read<CreateCoursePageBloc>().add(LoadImagesEvent());
        }
        if (state is SuccessCreateState) {
          context.goNamed(RoutePath.myCoursesPage);
        }
      },
      builder: (context, state) {
        if (state is DetailCourseLoadState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is DetailCourseErrorState) {
          return const Center(child: Text('Ошибка загрузки'));
        }
        if (state is AllCoursesPageLoadedState) {
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 35, horizontal: 35),
                    child: Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.pink,
                          width: 1.2,
                        ),
                      ),
                      child: SizedBox(
                        height: 300,
                        child: _buildProfilePicture(state.courseImage),
                      ),
                    ),
                  ),
                ],
              ),
              _buildTextField(
                'Название',
                _nameController,
                maxLength: 100,
              ),
              _buildTextField(
                'Описание',
                _emailController,
                maxLength: 550,
              ),
              if (widget.courseId != 0)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: width ~/ itemWidth,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 30,
                    children: List.generate(
                      (state.modulesByCourseId?.data?.length ?? 0) + 1,
                      (index) {
                        if ((state.modulesByCourseId?.data?.length ?? 0) ==
                            index) {
                          return GestureDetector(
                            onTap: () {
                              context.goNamed(
                                RoutePath.createModulePage,
                                pathParameters: {
                                  'moduleId': '0',
                                  'courseId': '${widget.courseId}',
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.pink,
                                  width: 1.2,
                                ),
                              ),
                              height: 200,
                              child: Icon(
                                Icons.add,
                                color: Colors.pink,
                                size: 100,
                              ),
                            ),
                          );
                        }
                        final module = state.modulesByCourseId!.data![index];
                        return GestureDetector(
                          onTap: () {
                            context.goNamed(
                              RoutePath.createModulePage,
                              pathParameters: {
                                'moduleId': '${module.id ?? 0}',
                                'courseId': '${widget.courseId}',
                              },
                            );
                          },
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: CourseElementWidget(
                              imageUrl: state.imagesFiles[index],
                              title: module.title ?? '',
                              description: '',
                              onTap: () {},
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: _buildActionButton(
                      text: widget.courseId == 0
                          ? 'Создать'
                          : 'Сохранить изменения',
                      isPrimary: true,
                      onPressed: () {
                        if (imageFile != null || widget.courseId != 0) {
                          context.read<CreateCoursePageBloc>().add(
                                CreateCourseEvent(
                                  courseId: widget.courseId,
                                  title: _nameController.text,
                                  description: _emailController.text,
                                  image: imageFile,
                                ),
                              );
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          );
        }
        return const SizedBox();
      },
    );
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
            Image.memory(
              imageBytes!,
              fit: BoxFit.cover,
            ),
          if (imageBytes == null && image != null)
            Image.memory(
              image,
              fit: BoxFit.cover,
            ),
          if (imageBytes == null && image == null)
            Center(
              child: const CircleAvatar(
                radius: 100,
                backgroundColor: Colors.pinkAccent,
                child: Icon(Icons.camera_alt, color: Colors.white, size: 80),
              ),
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

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false, int? maxLength}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 8,
      ),
      child: TextField(
        maxLength: maxLength,
        onChanged: (text) {
          setState(() {});
        },
        controller: controller,
        maxLines: null,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.transparent,
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
          contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 12.0),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.pinkAccent),
          hintText: 'Текст',
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        style: const TextStyle(color: Colors.pinkAccent),
      ),
    );
  }
}
