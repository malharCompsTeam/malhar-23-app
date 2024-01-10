import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:malhar_2023/components/drawer_wrapper.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
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
                      URLRequest(url: Uri.parse("https://blog.malharfest.in/")),
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
