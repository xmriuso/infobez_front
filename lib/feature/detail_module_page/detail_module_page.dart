import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';
import 'package:test_web_project/feature/detail_module_page/bloc/detail_module_page_bloc.dart';

class DetailModulePage extends StatefulWidget {
  const DetailModulePage({super.key});

  @override
  State<DetailModulePage> createState() => _DetailModulePageState();
}

class _DetailModulePageState extends State<DetailModulePage> {
  int currentVideoIndex = 0;
  
  void _nextVideo() {
    setState(() {
      currentVideoIndex++;
    });
  }

  void _previousVideo() {
    setState(() {
      if (currentVideoIndex > 0) {
        currentVideoIndex--;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //context.read<DetailModulePageBloc>().add(LoadModulesEvent(widget.courseId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Модули курса')),
      body: BlocBuilder<DetailModulePageBloc, DetailModulePageState>(
        builder: (context, state) {
          if (state is DetailModulePageLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is DetailModulePageError) {
            return Center(child: Text(state.message));
          }
          
          if (state is DetailModulePageEmpty) {
            return const Center(child: Text('Модули не найдены'));
          }
          
          if (state is DetailModulePageLoaded) {
            return Column(
              children: [
                // Блок с видео-плеером
                Expanded(
                  flex: 4,
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 245, 248),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            size: 80,
                            color: Colors.white,
                          ),
                        ),
                        Positioned(
                          left: 10,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back_ios_new),
                            onPressed: _previousVideo,
                          ),
                        ),
                        Positioned(
                          right: 10,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            onPressed: _nextVideo,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Список модулей
                Expanded(
                  flex: 3,
                  child: _buildModulesList(state.modules),
                ),
              ],
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildModulesList(AllLessonsEntity modules) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: modules.data?.length ?? 0,
      itemBuilder: (context, index) {
        final module = modules.data![index];
        return Card(
          child: ListTile(
            title: Text(module.title ?? 'Без названия'),
            subtitle: module.description != null 
                ? Text(module.description!)
                : null,
            leading: const Icon(Icons.video_library),
            onTap: () {
              // Обработка нажатия на модуль
              setState(() {
                currentVideoIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}