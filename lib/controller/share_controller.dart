
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ShareController extends GetxController{

  Future<void> share(String url) async {
    await  Share.share('Check out the website $url', subject: "QR/Barcode Result",  );
  }

}