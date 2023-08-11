
/// 产品模块提供数据库名称，需要存放日志、pref信息的目录
class ProductProvider {

  static final ProductProvider _instance = ProductProvider._internal();

  factory ProductProvider() {
    return _instance;
  }

  late String dbName;

  late String logFolder;

  late String logZipPath;

  late String prefFolder;

  String? shopId;
  String? shopName;
  String? devCode;

  ProductProvider._internal();

  register({
    required String dbName,
    required String logFolder,
    required String logZipPath,
    required String prefFolder,
    String? shopId,
    String? shopName,
    String? devCode
  }) {
    this.dbName = dbName;
    this.logFolder = logFolder;
    this.logZipPath = logZipPath;
    this.prefFolder = prefFolder;
    updateShopAndDevice(shopId: shopId, shopName: shopName, devCode: devCode);
  }

  updateShopAndDevice({String? shopId, String? shopName, String? devCode}) {
    this.shopId = shopId;
    this.shopName = shopName;
    this.devCode = devCode;
  }
}