// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:myco_flutter/features/dashboard/domain/entites/home_menu_response_entity.dart';
// import 'package:myco_flutter/features/speech_menu_search/presentation/bloc/speech_bloc.dart';

// class SpeechMenuViewScreen extends StatelessWidget {
//   const SpeechMenuViewScreen({super.key});

//   @override
//   Widget build(BuildContext context) => BlocBuilder<SpeechBloc, SpeechState>(
//     builder: (context, state) {
//       final menuList = state.props.first.;

//       return Scaffold(
//         appBar: AppBar(title: const Text('Speech Menu List')),
//         body: menuList.isEmpty
//             ? const Center(child: Text('No speech menus available'))
//             : GridView.builder(
//                 padding: const EdgeInsets.all(16),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   childAspectRatio: 0.8,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                 ),
//                 itemCount: menuList.length,
//                 itemBuilder: (context, index) {
//                   final AppMenuEntity item = menuList[index];
//                   return GestureDetector(
//                     onTap: () {
//                       // Optionally handle navigation here
//                       print('Tapped: ${item.menuClick}');
//                     },
//                     child: Column(
//                       children: [
//                         CircleAvatar(
//                           radius: 30,
//                           backgroundImage: item.menuIcon != null
//                               ? NetworkImage(item.menuIcon!)
//                               : null,
//                           child: item.menuIcon == null ? const Icon(Icons.menu) : null,
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           item.menuTitle ?? 'No Title',
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(fontSize: 14),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//       );
//     },
//   );
// }
