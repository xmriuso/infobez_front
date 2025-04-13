// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:test_web_project/core/theme/app_colors.dart';
// import 'package:test_web_project/core/theme/typography.dart';
// import 'package:test_web_project/feature/app/routing/route_path.dart';
// import 'package:test_web_project/feature/detail_module_page/bloc/detail_module_page_bloc.dart';

// class ModuleCardWidget extends StatelessWidget {
//   final dynamic module;
//   final Uint8List? image;

//   const ModuleCardWidget({
//     super.key,
//     required this.module,
//     required this.image,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         context.goNamed(RoutePath.detailModulePage);
//         context.read<DetailModulePageBloc>().add(LoadModulesEvent(module.id!));
//       },
//       child: _buildCardContent(),
//     );
//   }

//   Widget _buildCardContent() {
//     if (image != null) {
//       return Image.memory(
//         image!,
//         fit: BoxFit.cover,
//       );
//     }

//     return Column(
//       children: [
//         Expanded(
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//                 bottomLeft: Radius.circular(8),
//                 bottomRight: Radius.circular(8),
//               ),
//               border: Border.all(
//                 color: AppColors.loginGradient3,
//                 width: 1.2,
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Flexible(
//                   flex: 1,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(8),
//                         topRight: Radius.circular(8),
//                       ),
//                       color: AppColors.PINK101,
//                     ),
//                     child: Center(
//                       child: Text(
//                         module.title ?? '',
//                         style: AppTypography.font12RegularZillaSlab.copyWith(
//                           color: AppColors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Flexible(
//                   flex: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'День ${module.orderNumber ?? ''}',
//                           style: AppTypography.font12RegularZillaSlab.copyWith(
//                             color: AppColors.black,
//                           ),
//                         ),
//                         Text(
//                           module.subtitle ?? '',
//                           style: AppTypography.font12RegularZillaSlab.copyWith(
//                             color: AppColors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }