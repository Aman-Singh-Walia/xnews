import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xnews/models/article_model.dart';

class ArticleViewPage extends StatefulWidget {
  final Article openedArticle;
  const ArticleViewPage({Key? key, required this.openedArticle})
      : super(key: key);

  @override
  State<ArticleViewPage> createState() => _ArticleViewPageState();
}

class _ArticleViewPageState extends State<ArticleViewPage> {
  double progressValue = 0;
  @override
  Widget build(BuildContext context) {
    late WebViewController _webViewController;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(CupertinoIcons.clear)),
        actions: [
          IconButton(
              onPressed: () {
                _webViewController.reload();
              },
              icon: const Icon(CupertinoIcons.refresh)),
          IconButton(
              onPressed: () async {
                final urlPreview = widget.openedArticle.url;
                await Share.share('X-News $urlPreview');
              },
              icon: const Icon(CupertinoIcons.share)),
          // IconButton(
          //     onPressed: () {}, icon: const Icon(CupertinoIcons.bookmark))
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progressValue,
            color: Colors.blueGrey,
            backgroundColor: Colors.transparent,
            valueColor: const AlwaysStoppedAnimation(Colors.purple),
          ),
          Expanded(
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.openedArticle.url,
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onProgress: (progress) {
                setState(() {
                  progressValue = progress / 100;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
