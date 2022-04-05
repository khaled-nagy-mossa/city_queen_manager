import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_bar/default_app_bar.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/default_body.dart';
import '../../../widget/linear_progress_indicator.dart';
import '../../../widget/loading_widget.dart';
import '../../global/view/empty_view.dart';
import '../cubit/products/products_cubit.dart';
import '../cubit/products/products_states.dart';
import '../model/helper/product_list_params.dart';
import '../model/product.dart';
import '../widget/products_grid_view.dart';

class SearchView extends StatelessWidget {
  static const String id = 'search_view';

  final String search;
  final void Function(Product product) onSelectItem;

  SearchView({this.search, this.onSelectItem, Key key}) : super(key: key);

  final _scrollController = ScrollController();

  void _setupScrollController(BuildContext context) {
    if (_scrollController.hasClients) {
      _scrollController.addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 250.0) {
          ProductsCubit.get(context).fetchMore();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>(
      create: (context) {
        return ProductsCubit(params: ProductListParams(search: search))..init();
      },
      child: Builder(
        builder: (context) {
          return BlocConsumer<ProductsCubit, ProductsStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
              if (state is HasInitState) {
                _setupScrollController(context);
              }
            },
            builder: (context, state) {
              final cubit = ProductsCubit.get(context);
              return Scaffold(
                appBar: DefaultAppBar(
                  title: TextFormField(
                    onChanged: cubit.search,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                body: DefaultBody(
                    child: Stack(
                  children: [
                    _body(context, state),
                    if (state is FetchingMoreState) const AppLinearIndicator(),
                    if (state is LoadingState) const LoadingWidget(),
                  ],
                )),
              );
            },
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, ProductsStates state) {
    final cubit = ProductsCubit.get(context);
    if (state is InitialState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is EmptyState) {
      return EmptyView(
        title: 'No Products Found!'.tr,
        svgPath: Assets.images.product,
        onRefresh: () async {
          await cubit.refresh();
        },
      );
    } else if (state is ExceptionState) {
      return Center(child: Text(state.error));
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await cubit.refresh();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: ProductsGridView(
            productList: cubit.productList,
            onSelectItem: onSelectItem,
          ),
        ),
      );
    }
  }
}
