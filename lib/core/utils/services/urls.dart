//https://safex.web.tr/api/auth/login/
class Urls {
  static const String BASE_URL = 'https://safex.web.tr';

  //auth
  static const String LOGIN_URL = '/api/auth/login/';
  //#
  static const String CARGO_LIST_URL = '/api/core/cargo/';
  static const String COURIERS_LIST_URL = '/api/core/couriers/';
  //Deliveries
  static const String DELIVERY_CREATE_URL = '/api/core/delivery/';
  static const String LIST_URL = '/api/core/deliveries/';
  static const String DELETE_DELIVERIES_URL = '/api/core/delivery/';
  static const String GET_DELIVERY_DETAIL = '/api/core/delivery/';
  //Package
  static const String PACKAGE_LIST = '/api/core/packages/';
  static const String GET_PACKAGE_DETAIL = '/api/core/package/';

}
