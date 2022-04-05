import 'package:flutter/material.dart';

import '../../../common/config/api.dart';
import '../../../main_imports.dart';
import '../model/variant.dart';

class VariantItem extends StatelessWidget {
  const VariantItem({@required this.variant, this.onTap, Key key})
      : super(key: key);
  final Variant variant;
  final VoidCallback onTap;

  String get _variantPrice {
    try {
      var temp = '';
      temp += variant?.price.toString() ?? '';

      if (variant?.currencySymbol != null) {
        temp += variant.currencySymbol;
      } else {
        temp += variant?.currency ?? '';
      }
      return temp;
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (variant == null || variant.unusable) return const SizedBox();
    return ListTile(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      leading: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(API.imageUrl(variant.image)),
          ),
        ),
      ),
      title: Text(variant?.displayName ?? variant?.name ?? ''),
      trailing: Text(
        _variantPrice,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
