import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../main_imports.dart';
import '../../../widget/default_body.dart';
import '../../../widget/elevated_button_extension.dart';
import '../../chat/common/chat_view_imports.dart';

class ProductQtyUpdatedView extends StatelessWidget {
  static const routeName = 'product_qty_updated_view';

  const ProductQtyUpdatedView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: DefaultAppBar(
          title: Text('Product Quantity Has Updated'.tr),
          actions: [], //to remove default actions
        ),
        body: DefaultBody(
          child: Container(
            constraints: const BoxConstraints.expand(),
            child: Column(
              children: [
                Expanded(child: Container()),
                SvgPicture.asset(Assets.images.successful),
                const SizedBox(height: 40.0),
                const Text(
                  'Product Added Successfully',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                Expanded(flex: 2, child: Container()),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    // AppRoutes.popUntil(
                    //   context,
                    //   ScanProductBarcodeView.routeName,
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(240.0, 40.0),
                  ),
                  child: Text('Done'.tr),
                ).toGradient(context),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
