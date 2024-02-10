import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
class QRController extends GetxController{

  var scanBarcode = 'No date found'.obs;
  var url = "".obs;

  Future<void> scanQR() async {
    String barcodeScanRes = "";
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.DEFAULT
      );
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    } catch(err){
      print("Something want to worng");
    }
    scanBarcode.value = barcodeScanRes;
  }

}