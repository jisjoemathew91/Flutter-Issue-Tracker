class HTMLUtil {
  static const String resizeObserver = '''
    <script>
          const resizeObserver = new ResizeObserver(entries =>
          Resize.postMessage("height" + (entries[0].target.clientHeight).toString()) )
          resizeObserver.observe(document.body)
        </script>
    ''';

  static const String bodyStyles = r'''
  <style>
  pre {
      background:$%[0];
      border: 1px solid #ddd;
      border-left: 3px solid #f36d33;
      color: $%[1];
      page-break-inside: avoid;
      font-family: monospace;
      font-size: 15px;
      line-height: 1.6;
      margin-bottom: 1.6em;
      max-width: 100%;
      overflow: auto;
      padding: 1em 1.5em;
      display: block;
      word-wrap: break-word;
  }
  </style>''';

  static const String backgroundColor = r'''
  <style>
  body { background-color: $%[0];} 
  </style>''';
}
