import '../constants/app_constants.dart';

bool containsBannedKeyword(String query) {
  for (String keyword in AppConstants.bannedKeywords) {
    if (query.toLowerCase().contains(keyword.toLowerCase())) {
      return true;
    }
  }
  return false;
}
