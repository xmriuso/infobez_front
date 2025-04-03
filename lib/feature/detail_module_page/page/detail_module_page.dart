import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_web_project/core/api_service/domain/entities/modules_by_id_entity.dart';
import 'package:test_web_project/feature/detail_module_page/page/bloc/detail_module_page_bloc.dart';

class DetailModulePage extends StatefulWidget {
  final int courseId;

  const DetailModulePage({super.key, required this.courseId});

  @override
  State<DetailModulePage> createState() => _DetailModulePageState();
}

class _DetailModulePageState extends State<DetailModulePage> {
  @override
  void initState() {
    super.initState();
    context.read<DetailModulePageBloc>().add(LoadModulesEvent(widget.courseId));
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
            return _buildModulesList(state.modules);
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
            },
          ),
        );
      },
    );
  }
}