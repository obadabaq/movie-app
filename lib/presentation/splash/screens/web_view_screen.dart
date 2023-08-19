import 'package:flutter/material.dart';
import 'package:flutter_movies_app/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter_movies_app/presentation/splash/bloc/splash_event.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final SplashBloc splashBloc;

  const WebViewScreen({Key? key, required this.url, required this.splashBloc})
      : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Third party usage"),
          automaticallyImplyLeading: false,
        ),
        body: WebViewWidget(controller: controller),
      ),
    );
  }

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            if (url.contains("allow")) {
              widget.splashBloc.add(GotPermission(true));
              Navigator.pop(context);
            } else if (url.contains("deny")) {
              widget.splashBloc.add(GotPermission(false));
              Navigator.pop(context);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }
}
