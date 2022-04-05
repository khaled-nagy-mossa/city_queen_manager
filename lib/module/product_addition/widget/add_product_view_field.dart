import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../widget/custom_shadow.dart';

class AddProductViewField extends StatelessWidget {
  final TextEditingController controller;

  const AddProductViewField({@required this.controller, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShadow(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'WRITE_BARCODE'.tr,
          prefixIcon: const Icon(Icons.qr_code),
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
