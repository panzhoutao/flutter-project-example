import '../generated/json/base/json_field.dart';
import '../generated/json/response_entity.g.dart';

@JsonSerializable()
class ResponseEntity {
	String? msg;
	int? code;
	dynamic data;
	String? msgCode;

	ResponseEntity();

	factory ResponseEntity.fromJson(Map<String, dynamic> json) =>
			$ResponseEntityFromJson(json);

	Map<String, dynamic> toJson() => $ResponseEntityToJson(this);
}
