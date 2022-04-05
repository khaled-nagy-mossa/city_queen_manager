import 'package:branch_manager/widget/default_body.dart';
import 'package:branch_manager/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../common/assets/assets.dart';
import '../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../widget/app_toast/app_toast.dart';
import '../../../widget/linear_progress_indicator.dart';
import '../../global/view/empty_view.dart';
import '../../product/cubit/products/products_cubit.dart';
import '../../product/cubit/products/products_states.dart';
import '../../product/model/helper/product_list_params.dart';
import '../../product/widget/products_grid_view.dart';
import '../model/category.dart';
import '../widget/app_bar/app_bar.dart';

class CategoryView extends StatelessWidget {
  static const String id = 'category_view';

  final Category category;

  CategoryView({@required this.category}) : assert(category != null);

  final ScrollController _scrollController = ScrollController();

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
        return ProductsCubit(params: ProductListParams(categoryId: category.id))
          ..init();
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
              if (state is EmptyState) {
                AppToast.normalToast(
                    context: context, msg: 'No Products Found!'.tr);
              }
            },
            builder: (context, state) {
              final cubit = ProductsCubit.get(context);
              return Stack(
                children: [
                  Scaffold(
                    // appBar: AppBar(title: Text(category?.name ?? ' '.tr),
                    appBar: CategoriesViewAppBar(
                      onSearchClosed: () => cubit.search(''),
                      onSearch: cubit.search,
                      onChanged: cubit.search,
                    ),
                    body: DefaultBody(child: _body(context, state)),
                  ),
                  if (state is FetchingMoreState) const AppLinearIndicator(),
                  if (state is LoadingState) const LoadingWidget(),
                ],
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
          onRefresh: () async {});
    } else if (state is ExceptionState) {
      return Center(child: Text(state.error));
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await cubit.refresh();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: ProductsGridView(productList: cubit.productList),
        ),
      );
    }
  }
}
