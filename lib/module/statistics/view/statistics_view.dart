import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../widget/app_bar/default_app_bar.dart';
import '../../../widget/default_body.dart';

class StatisticsView extends StatelessWidget {
  static const routeName = '/statistics_view';

  const StatisticsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(title: Text('Statistics'.tr)),
        body: DefaultBody(
          child: Center(child: Text('Hello,World'.tr)),
        ));
  }
}
