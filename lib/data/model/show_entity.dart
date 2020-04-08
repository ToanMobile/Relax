import 'package:relax/generated/json/base/json_convert_content.dart';

class ShowEntity with JsonConvert<ShowEntity> {
	String title;
	String url;

	ShowEntity(this.title, this.url);
}
