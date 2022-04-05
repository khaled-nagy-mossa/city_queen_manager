import 'dart:developer';

import '../model/home.dart';

import 'repo.dart';

abstract class HomeViewService {
  const HomeViewService();

  static Future homePage() async {
    try {
      final res = await HomeViewRepo.homePage();

      if (res.hasError) throw res.msg;

      return HomeViewModel.fromMap(
        res.json['result']['data'][0] as Map<String, dynamic>,
      );
    } catch (e) {
      log('Exception in HomeViewService.homePage: $e');
      return e.toString();
    }
  }
}
