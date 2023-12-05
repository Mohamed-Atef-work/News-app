import 'package:flutter/material.dart';
import 'package:news/core/components/appText.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  late final String url;
  WebViewScreen({
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DefaultText(
          text: AppLocalizations.of(context)!.article,
        ),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
