import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:malhar_2023/components/drawer_wrapper.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  late InAppWebViewController _webViewController;
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    return DrawerWrapper(
      disableGestures: true,
        drawerController: _advancedDrawerController,
        scaffold: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text(
              "",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            child: Container(
                child: Column(children: <Widget>[
              Expanded(
                child: InAppWebView(
                  onReceivedServerTrustAuthRequest:
                      (controller, challenge) async {
                    return ServerTrustAuthResponse(
                        action: ServerTrustAuthResponseAction.PROCEED);
                  },
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(),
                      android: AndroidInAppWebViewOptions(
                          useHybridComposition: true)),
                  initialUrlRequest:
                      URLRequest(url: Uri.parse("https://malharfest.in/shop")),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                ),
              ),
            ])),
          ),
        ));
  }
}
