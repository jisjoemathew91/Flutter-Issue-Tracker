import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_issue_tracker/app/extension/color_extension.dart';
import 'package:flutter_issue_tracker/webview/presentation/bloc/web_view_bloc.dart';
import 'package:flutter_issue_tracker/webview/presentation/widget/web_view_dialog.dart';
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
    const resizeObserver = '''
    <script>
          const resizeObserver = new ResizeObserver(entries =>
          Resize.postMessage("height" + (entries[0].target.clientHeight).toString()) )
          resizeObserver.observe(document.body)
        </script>
    ''';
    final htmlString = '''
    <!DOCTYPE html>
        <head><meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>body { background-color: ${Theme.of(context).colorScheme.surface.toHex()};} </style>
        </head>
        <body text="${Theme.of(context).textTheme.bodyText2?.color?.toHex()}" >
        $htmlText
        </body>
        $resizeObserver''';

    final wv = WebView(
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _bloc.webViewController = webViewController;
        // If [webViewController] is initialised html string will be loaded.
        _loadHtmlFromString(_bloc.webViewController!, htmlString);
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
            await _bloc.webViewController?.runJavascriptReturningResult(
          'document.body.clientHeight',
        );
        _bloc.add(InitializeHeightEvent(height: height));
      },
      javascriptChannels: <JavascriptChannel>{
        JavascriptChannel(
          name: 'Resize',
          onMessageReceived: (JavascriptMessage message) {
            _bloc.add(
              InitializeHeightEvent(
                height: message.message.replaceAll('height', ''),
              ),
            );
          },
        ),
      },
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith('http')) {
          showDialog<CustomWebViewDialog>(
            context: context,
            builder: (context) {
              return CustomWebViewDialog(url: request.url);
            },
          );
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    );

    return BlocBuilder<WebViewBloc, WebViewState>(
      builder: (context, state) {
        return SizedBox(
          height: state.height,
          child: wv,
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
