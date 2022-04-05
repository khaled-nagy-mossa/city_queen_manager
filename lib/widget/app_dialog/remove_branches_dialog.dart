import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class RemoveBranchesDialog extends StatelessWidget {
  final VoidCallback onDelete;

  const RemoveBranchesDialog({@required this.onDelete})
      : assert(onDelete != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are You Sure!'.tr),
      content: const Text(
        'This branch is different from the one you selected before. Do you want to delete everything in the cart and add this product?',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () {
            onDelete();
            Navigator.pop(context);
          },
          child: Text('Delete'.tr),
        ),
      ],
    );
  }
}
