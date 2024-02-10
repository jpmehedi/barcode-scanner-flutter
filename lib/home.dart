import 'package:barcode_scanner/controller/qr_controller.dart';
import 'package:barcode_scanner/controller/launcher_controller.dart';
import 'package:barcode_scanner/controller/share_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  final qrController = Get.put(QRController());
  final shareController = Get.put(ShareController());
  final launcherController = Get.put(LauncherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Scanner"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 200,
            color: Colors.blueGrey.shade50,
            child: Center(
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Obx(()=> SelectableLinkify(
                      onOpen: launcherController.onOpen,
                      text: qrController.scanBarcode.value,
                      options: const LinkifyOptions(humanize: false),
                      linkStyle: const TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                        onPressed: ()async{
                          await launcherController.openResult(qrController.scanBarcode.value.toString());
                        },
                        child: const Column(
                          children: <Widget>[
                            Icon(
                              Icons.open_in_browser,
                              size: 20,
                            ),
                            Text("Open")
                          ],
                        ),
                    ),
                    MaterialButton(
                      onPressed:() async{
                        await shareController.share(qrController.scanBarcode.value.toString());
                      },
                      child: const Column(
                        children: <Widget>[
                          Icon(
                            Icons.share,
                            size: 20,
                          ),
                          Text("Share")
                        ],
                      ),
                    ),
                    Tooltip(
                      verticalOffset: 60,
                      preferBelow: false,
                      // triggerMode: TooltipTriggerMode.manual,
                      message: "Copyed",
                      child: MaterialButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: qrController.scanBarcode.value),
                          );
                        },
                        child: const Column(
                          children: <Widget>[
                            Icon(
                              Icons.content_copy,
                              size: 20,
                            ),
                            Text("Copy")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.camera_alt),
        label: const Text("Scan"),
        onPressed: qrController.scanQR
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
