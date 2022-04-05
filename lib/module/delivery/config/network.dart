import 'package:branch_manager/common/config/api.dart';

abstract class DeliveryApis {
  const DeliveryApis();

  ///get all deliveries
  ///type get
  ///params ?limit=5&offset=0
  static String driversList = '${API.baseUrl}/drivers_list';

  ///set new driver to delivery
  ///type post
  static String updateOrderDriver = '${API.baseUrl}/update_order';

  /// Get driver profile data
  /// type post
  static String driverProfile = '${API.baseUrl}/driver_profile';

  /// Get driver Orders
  /// type post
  static String driverOrderList = '${API.baseUrl}/driver_order_list';
}
