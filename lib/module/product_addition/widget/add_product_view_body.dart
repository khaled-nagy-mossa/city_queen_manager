import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../common/assets/assets.dart';

class AddProductViewBody extends StatelessWidget {
  final VoidCallback onTap;

  const AddProductViewBody({@required this.onTap, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(child: Container()),
          Expanded(
            flex: 14,
            child: GestureDetector(
              onTap: () {
                if (onTap != null) onTap();
              },
              child: Container(
                constraints: const BoxConstraints.expand(),
                color: Colors.transparent,
                child: Column(
                  children: [
                    Container(
                      constraints: const BoxConstraints(
                        maxHeight: 180.0,
                        minHeight: 150.0,
                      ),
                      child: Image.asset(Assets.images.barcode),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'CLICK_TO_READ'.tr,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
