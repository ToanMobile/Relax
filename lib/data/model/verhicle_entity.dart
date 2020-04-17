import 'package:relax/generated/json/base/json_convert_content.dart';

class VehicleEntity with JsonConvert<VehicleEntity> {
  String description;
  int height;
  int length;
  int max_weight;
  int resource_id;
  int width;
  bool visible;

  @override
  String toString() {
    return 'VehicleEntity{description: $description, height: $height, length: $length, max_weight: $max_weight, resource_id: $resource_id, width: $width, visible: $visible}';
  }
}
