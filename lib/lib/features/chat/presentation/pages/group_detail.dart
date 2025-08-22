import 'package:flutter/material.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:myco_flutter/features/chat/presentation/widgets/chat_list_card.dart';
import 'package:myco_flutter/widgets/custom_appbar.dart';
import 'package:myco_flutter/widgets/custom_searchfield.dart';
import 'package:myco_flutter/widgets/custom_text.dart';

// 1. Convert to a StatefulWidget to manage local search state
class GroupInfo extends StatefulWidget {
  const GroupInfo({super.key});

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  // The full list of members for this group
  final List<Map<String, String>> groupMembers = [
    {
      'name': 'Vedant',
      'message': 'Let’s start the meeting',
      'time': '5 mins ago',
      'image': 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
    },
    {
      'name': 'Anjali',
      'message': 'Shared the document',
      'time': '10 mins ago',
      'image': 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
    },
    {
      'name': 'Mukund',
      'message': 'Got it',
      'time': '15 mins ago',
      'image': 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
    },
  ];

  // 2. A new list to hold the filtered search results
  List<Map<String, String>> filteredGroupMembers = [];

  @override
  void initState() {
    super.initState();
    // Initially, the filtered list is the same as the full list
    filteredGroupMembers = groupMembers;
  }

  // 3. A local method to handle the search logic
  void _filterMembers(String query) {
    List<Map<String, String>> searchResult = [];
    if (query.isEmpty) {
      // If the search bar is empty, show all members
      searchResult = groupMembers;
    } else {
      // Otherwise, filter by name
      searchResult = groupMembers
          .where((member) =>
              member['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    // Update the UI with the new filtered list
    setState(() {
      filteredGroupMembers = searchResult;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const CustomAppbar(
          appBarBackgoundColor: Colors.transparent,
          title: 'Chat List',
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 0.05 * Responsive.getWidth(context),
          ),
          // 4. Removed the BlocBuilder as it's no longer needed here
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: Responsive.getWidth(context) * 0.12,
                  backgroundImage: const AssetImage('assets/chat/profile.jpg'),
                ),
              ),
              SizedBox(height: 0.012 * Responsive.getHeight(context)),
              CustomText(
                'Chat List',
                fontSize: 20 * Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 0.006 * Responsive.getHeight(context)),
              CustomText(
                'You & 22 Others',
                fontSize: 15 * Responsive.getResponsiveText(context),
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 0.012 * Responsive.getHeight(context)),
              CustomSearchField(
                hintText: 'Search',
                // 5. Call the local search method instead of the BLoC event
                onChanged: (value) => _filterMembers(value),
              ),
              SizedBox(height: 0.012 * Responsive.getHeight(context)),
              Expanded(
                child: ListView.separated(
                  // 6. Use the local filtered list
                  itemCount: filteredGroupMembers.length,
                  itemBuilder: (context, index) {
                    final member = filteredGroupMembers[index];
                    return ChatListCard(
                      name: member['name']!,
                      lastMessage: member['message']!,
                      timeAgo: member['time']!,
                      profileImagePath: member['image']!,
                      isSufixIcon: true,
                      onTap: () {
                        
                      },
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 0.015 * Responsive.getHeight(context)),
                ),
              ),
            ],
          ),
        ),
      );
}
