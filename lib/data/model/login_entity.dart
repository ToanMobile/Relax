import 'package:relax/generated/json/base/json_convert_content.dart';

class LoginEntity with JsonConvert<LoginEntity> {
	int code;
	String jwt;
	String expiredDate;
	LoginUser user;
}

class LoginUser with JsonConvert<LoginUser> {
	String email;
	int id;
	String uuid;
	String username;
	String provider;
	bool confirmed;
	bool blocked;
	LoginUserRole role;
	String shortcode;
}

class LoginUserRole with JsonConvert<LoginUserRole> {
	int id;
	String name;
	String description;
	String type;
}
