import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherController extends GetxController{

  Future<void> onOpen(LinkableElement link) async {
    final _url = Uri.parse(link.url!);
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $link';
    }
  }

  Future openResult(String? url) async {
    final _url = Uri.parse(url!);
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $url';
    }
  }
}