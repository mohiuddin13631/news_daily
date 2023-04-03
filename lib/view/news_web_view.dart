import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:news_app/model/news_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  NewsWebView({Key? key,required this.articles}) : super(key: key);

  Articles? articles;

  @override
  State<NewsWebView> createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {

  WebViewController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(widget.articles!.url.toString()));
  }

  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(

          controller: controller!),
    );

        // body: Stack(
        //   children: [
        //     InAppWebView(
        //       initialUrlRequest: URLRequest(url: Uri.parse("https://www.google.com/")),
        //       initialOptions: InAppWebViewGroupOptions(
        //         crossPlatform: InAppWebViewOptions(
        //           useShouldOverrideUrlLoading: true,
        //         ),
        //       ),
        //       onLoadStart: (controller, url) {
        //         setState(() {
        //           _isLoading = true;
        //         });
        //       },
        //       onLoadStop: (controller, url) {
        //         setState(() {
        //           _isLoading = false;
        //         });
        //       },
        //     ),
        //     if (_isLoading)
        //       Center(
        //         child: CircularProgressIndicator(),
        //       ),
        //   ],
        // ),
  }
}
