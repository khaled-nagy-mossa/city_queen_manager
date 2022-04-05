import 'dart:developer';

class VariantListParams {
  const VariantListParams({
    this.productId,
    this.offset,
    this.limit = 10,
    this.search,
  });

  final int productId;
  final int offset;
  final int limit;
  final String search;

  VariantListParams copyWith({
    int productId,
    int offset,
    int limit,
    String search,
  }) {
    try {
      return VariantListParams(
        productId: productId ?? this.productId,
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
        search: search ?? this.search,
      );
    } catch (e) {
      log('Exception in ProductListParams.copyWith : $e');
      return this;
    }
  }

  /// to parse params and get as url
  String get parse {
    var url = '';

    ///add params
    try {
      url += '?';

      if (limit != null && offset != null) {
        url += 'limit=$limit&offset=$offset&';
      }

      if (productId != null) {
        url += 'product_id=$productId&';
      }

      if (search != null) {
        url += 'search=$search';
      }

      ///Erase extra marks
      if (url[url.length - 1] == '&') {
        url = url.substring(0, url.length - 1);
      }
      if (url[url.length - 1] == '?') {
        url = url.substring(0, url.length - 1);
      }

      return url;
    } catch (e) {
      log('Exception in ProductListParams.parse :$e');
      return url;
    }
  }
}
