import 'package:app_routes/app_routes.dart';
import 'package:branch_manager/main_imports.dart';
import 'package:branch_manager/module/product/widget/stock.dart';
import 'package:flutter/material.dart';

import '../../../common/config/api.dart';
import '../../../common/const/app_data.dart';
import '../model/product.dart';
import '../view/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductItem({@required this.product, this.onTap})
      : assert(product != null);

  @override
  Widget build(BuildContext context) {
    final accountCubit = AccountCubit.get(context);
    if (product == null || !product.usable) return const SizedBox();
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        } else {
          AppRoutes.push(context, ProductView(product: product));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: AppData.gradient,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(API.imageUrl(product.image)),
                  ),
                ),
                alignment: const Alignment(1.0, 0.7),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              product.name ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (product?.currencySymbol ?? '') +
                      (product.price?.toString() ?? '0.0'),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
                Stock(
                  count: product?.defaultVariant?.countInStock(
                    accountCubit.user?.branch?.id,
                  ),
                ),

                // Row(
                //   children: [
                //     const Icon(Icons.star, color: Colors.yellow, size: 16.0),
                //     Text(
                //       product.reviews.ratingAvg.toStringAsFixed(2),
                //       style: const TextStyle(
                //         color: Colors.grey,
                //         fontSize: 12.0,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     const SizedBox(width: 5.0),
                //     Container(
                //       constraints: const BoxConstraints(
                //         maxHeight: 25.0,
                //         maxWidth: 25.0,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
