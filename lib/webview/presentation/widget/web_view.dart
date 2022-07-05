import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/app/extension/color_extension.dart';
import 'package:flutter_issue_tracker/webview/presentation/bloc/web_view_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatelessWidget {
  const CustomWebView({super.key, required this.htmlText});

  final String htmlText;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WebViewBloc(),
      child: CustomWebViewBody(
        htmlText: htmlText,
      ),
    );
  }
}

class CustomWebViewBody extends StatelessWidget {
  const CustomWebViewBody({super.key, required this.htmlText});

  final String htmlText;

  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.of<WebViewBloc>(context);
    final htmlString = '''
    <!DOCTYPE html>
        <head><meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>body { background-color: ${Theme.of(context).colorScheme.surface.toHex()};} </style>
        </head>
        <body text="${Theme.of(context).textTheme.bodyText2?.color?.toHex()}" >
        $htmlText
        </body>''';
    return BlocBuilder<WebViewBloc, WebViewState>(
      builder: (context, state) {
        // If [webViewController] is initialised html string will be loaded.
        if (state.webViewController != null) {
          _loadHtmlFromString(state.webViewController!, htmlString);
        }

        return SizedBox(
          height: state.height,
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _bloc.add(InitializeWebViewControllerEvent(webViewController));
            },
            gestureRecognizers: {}..add(
                const Factory<HorizontalDragGestureRecognizer>(
                  HorizontalDragGestureRecognizer.new,
                ),
              ),
            gestureNavigationEnabled: true,
            onPageFinished: (v) async {
              // The clientHeight property returns the viewable
              // height of an element in pixels,
              final height =
                  await state.webViewController?.runJavascriptReturningResult(
                'document.body.clientHeight',
              );
              _bloc.add(InitializeHeightEvent(height: height));
            },
          ),
        );
      },
    );
  }

  Future _loadHtmlFromString(
    WebViewController controller,
    String htmlText,
  ) async {
    await controller.loadUrl(
      Uri.dataFromString(
        htmlText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
        base64: true,
        //parameters: widget.parameters,
      ).toString(),
    );
  }
}
