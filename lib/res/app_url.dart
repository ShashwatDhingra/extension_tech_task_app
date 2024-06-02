class AppUrl {
  static const _baseUrl = 'https://demo.extensionerp.com/api';

  // Create Check-In/Out Url
  static const checkInUrl = '$_baseUrl/resource/Employee Checkin';

  // Get Employee Check-Ins/Outs Url
  static const getCheckInUrl = '$_baseUrl/resource/Employee Checkin?fields=["*"]&limit=0';
}
