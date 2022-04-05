import 'package:app_routes/app_routes.dart';
import 'package:flutter/material.dart';

import '../../../common/const/app_data.dart';
import '../../../main_imports.dart';
import '../../global/view/image_view.dart';
import '../model/barcode_product.dart';

class ProductImage extends StatelessWidget {
  final BarcodeProduct product;
  final Size size;

  const ProductImage({@required this.product, this.size, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (product == null || product.unusable) return const SizedBox();

    final scWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        AppRoutes.push(
          context,
          ImageView(
            heroTag: 'product_${product.productId}_image',
            image: NetworkImage(API.imageUrl(product?.variant?.image)),
          ),
        );
      },
      child: Hero(
        tag: 'product_${product.productId}_image',
        child: Container(
          constraints: BoxConstraints.tight(
            size ?? Size(scWidth - 80, scWidth - 200),
          ),
          decoration: BoxDecoration(
            gradient: AppData.gradient,
            borderRadius: BorderRadius.circular(14.0),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                API.imageUrl(product?.variant?.image),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
