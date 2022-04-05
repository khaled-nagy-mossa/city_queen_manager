import '../../../common/config/api.dart';

abstract class HomeAPIs {
  const HomeAPIs();

  //to get all home page data
  //type get
  static String managerHome = '${API.baseUrl}/manager_home';
}
