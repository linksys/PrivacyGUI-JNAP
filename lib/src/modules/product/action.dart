import 'package:jnap/src/modules/product/service.dart';
import 'package:jnap/src/modules/jnap_action.dart';

/// http://linksys.com/jnap/product/GetSoftSKUSettings
sealed class ProductAction extends JNAPAction {
  ProductAction({
    required super.name,
    required super.varients,
  }) : super(service: productService);

  static List<ProductAction> get all => [
        GetSoftSKUSettings.instance,
      ];
}

class GetSoftSKUSettings extends ProductAction {
  static final GetSoftSKUSettings instance = GetSoftSKUSettings._();
  GetSoftSKUSettings._()
      : super(name: 'GetSoftSKUSettings', varients: [VersionVarients(1, 1)]);
}
