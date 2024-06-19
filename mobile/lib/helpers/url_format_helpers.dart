import 'package:flutter_dotenv/flutter_dotenv.dart';

String formatToDirectLoadUrl (String url) {
  final envUrl = dotenv.env['WEB_SERVER_ADDRESS']!;
  final formattedEnvUrl = '${envUrl}get/';
  final directLoadUrl = url.replaceFirst(envUrl, formattedEnvUrl);

  return directLoadUrl;
}