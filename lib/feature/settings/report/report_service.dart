import 'package:pick_champ/core/const/enums/end_point.dart';
import 'package:pick_champ/core/init/cache_manager.dart';
import 'package:pick_champ/core/init/network_manager.dart';
import 'package:pick_champ/feature/settings/report/model/report_request.dart';
import 'package:pick_champ/feature/settings/report/model/report_response.dart';

class ReportService {
  ReportService._();
  static final ReportService instance = ReportService._();

  Future<ReportResponse> report(ReportRequest req) async {
    final userId = CacheManager.instance.getUserId();
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.report,
      data: {
        'userId': userId,
        'otherId': req.otherId,
        'reason': req.reason,
        'details': req.details,
      },
    );
    return response != null
        ? ReportResponse.fromJson(response)
        : ReportResponse(success: false);
  }

  Future<ReportResponse> getReports(String id) async {
    final response = await NetworkManager.instance.baseRequest(
      EndPointEnums.getReports,
      data: {'id': id},
    );
    return response != null
        ? ReportResponse.fromJson(response)
        : ReportResponse(success: false);
  }
}
