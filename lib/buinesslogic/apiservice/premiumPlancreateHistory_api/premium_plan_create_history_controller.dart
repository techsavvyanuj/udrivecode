import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:webtime_movie_ocean/buinesslogic/apiservice/app_url.dart';

/// PremiumPlan Create History ///
class PremiumPlanCreateHistoryProvider {
  static Future premiumPlanCreateHistoryProvider(
    String userId,
    String paymentGateway,
    String premiumPlanId, {
    Map<String, dynamic>? paymentMeta,
  }) async {
    final Map<String, dynamic> payload = {
      "userId": userId,
      "premiumPlanId": premiumPlanId,
      "paymentGateway": paymentGateway,
    };

    if (paymentMeta != null) {
      payload.addAll(paymentMeta);
    }

    http.Response response = await http.post(
      Uri.parse(AppUrls.premiumPlanCreateHistory),
      headers: {'Content-Type': 'application/json; charset=UTF-8', "key": AppUrls.SECRET_KEY},
      body: jsonEncode(payload),
    );
    log(response.body);

    dynamic data;
    try {
      data = jsonDecode(response.body);
    } catch (_) {
      data = {
        "status": false,
        "message": "Invalid server response",
      };
    }

    if (response.statusCode == 200) {
      return data;
    }

    return data;
  }
}
