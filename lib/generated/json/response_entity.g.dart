import 'package:flutter_project_example/generated/json/base/json_convert_content.dart';
import 'package:flutter_project_example/entitys/response_entity.dart';

ResponseEntity $ResponseEntityFromJson(Map<String, dynamic> json) {
	final ResponseEntity responseEntity = ResponseEntity();
	final String? msg = jsonConvert.convert<String>(json['msg']);
	if (msg != null) {
		responseEntity.msg = msg;
	}
	final int? code = jsonConvert.convert<int>(json['code']);
	if (code != null) {
		responseEntity.code = code;
	}
	final dynamic? data = jsonConvert.convert<dynamic>(json['data']);
	if (data != null) {
		responseEntity.data = data;
	}
	final String? msgCode = jsonConvert.convert<String>(json['msgCode']);
	if (msgCode != null) {
		responseEntity.msgCode = msgCode;
	}
	return responseEntity;
}

Map<String, dynamic> $ResponseEntityToJson(ResponseEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['msg'] = entity.msg;
	data['code'] = entity.code;
	data['data'] = entity.data;
	data['msgCode'] = entity.msgCode;
	return data;
}