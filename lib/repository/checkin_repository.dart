import 'package:extension_tech_task_app/data/network_service/base_api_services.dart';
import 'package:extension_tech_task_app/data/network_service/network_api_services.dart';
import 'package:extension_tech_task_app/models/checkin_model.dart';
import 'package:extension_tech_task_app/models/employee_checkin_model.dart';
import 'package:extension_tech_task_app/res/app_url.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CheckInRepository {

  // Loosely Coupled
  final BaseApiService _apiService = NetworkApiService(http.Client());

  final String _token = dotenv.env['API_TOKEN'] ?? '';

  Future<dynamic> createCheckInOut(CheckInModel checkIn) async {
    try {
      final response = await _apiService.post(AppUrl.checkInUrl, checkIn.toMap(),
          headers: {'Authorization': 'token $_token'});

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<EmployeeCheckInModel> getEmployeeCheckIns() async {
    try {
      final response = await _apiService
          .get(AppUrl.getCheckInUrl, headers: {'Authorization': 'token $_token'});
      return EmployeeCheckInModel.fromMap(response);
    } catch (e) {
      rethrow;
    }
  }
}
