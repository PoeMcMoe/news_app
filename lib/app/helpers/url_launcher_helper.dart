import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  Future<void> openUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);

    final canLaunch = await canLaunchUrl(url);
    if (!canLaunch) {
      throw Exception('Cannot open this URL');
    }

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
