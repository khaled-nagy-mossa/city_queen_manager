import 'dart:developer';

import 'package:branch_manager/main_imports.dart';
import 'package:branch_manager/module/product_addition/cubit/history/cubit.dart';
import 'package:branch_manager/module/product_addition/cubit/history/states.dart';
import 'package:branch_manager/widget/app_bar/default_app_bar.dart';
import 'package:branch_manager/widget/app_snack_bar/app_snack_bar.dart';
import 'package:branch_manager/widget/linear_progress_indicator.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

/// Get the variant list to get history ...back end dev says that
class VariantHistoryView extends StatelessWidget {
  const VariantHistoryView({Key key}) : super(key: key);

  static const routeName = 'variant-history';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VariantHistoryCubit>(
      create: (context) => VariantHistoryCubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<VariantHistoryCubit, VariantHistoryStates>(
            listener: (context, state) {
              if (state is IneffectiveErrorState) {
                AppSnackBar.error(context, state.error);
              }
            },
            builder: (context, state) {
              final cubit = VariantHistoryCubit.get(context);

              return Scaffold(
                appBar: DefaultAppBar(title: Text('HISTORY'.tr)),
                body: Stack(
                  children: [
                    ListView.builder(
                      itemCount: cubit.variantList.variants.length,
                      itemBuilder: (context, index) {
                        final variant = cubit.variantList.variants[index];
                        return Card(
                          child: ListTile(
                            leading: Container(
                              height: 55.0,
                              width: 55.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:
                                      NetworkImage(API.imageUrl(variant.image)),
                                ),
                              ),
                            ),
                            title: Text(variant.name),
                          ),
                        );
                      },
                    ),
                    if (state is FetchingDataState) const AppLinearIndicator(),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
