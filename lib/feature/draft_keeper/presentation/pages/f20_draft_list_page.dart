import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:story_maker/feature/draft_keeper/presentation/widgets/custom_list_item.dart';

class F20DraftListPage extends StatelessWidget {
  const F20DraftListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('draft_list'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return CustomListItem(
            title: 'Title ${index + 1}',
            content: 'This is the content of the ${index + 1} item',
          );
        },
      ),
    );
  }
}
