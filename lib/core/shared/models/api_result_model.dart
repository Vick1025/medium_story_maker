import 'package:story_maker/core/shared/constants.dart';

import '../entities/api_result_entity.dart';

class ApiResultModel extends ApiResultEntity {
  const ApiResultModel({required super.status, required super.message});

  factory ApiResultModel.fromJson(Map<String, dynamic> json) {
    return ApiResultModel(
      status: json[kStatus] as int,
      message: json[kMessage] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kStatus: status,
      kMessage: message,
    };
  }
}
