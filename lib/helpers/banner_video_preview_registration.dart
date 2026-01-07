import 'dart:ui_web' as ui;
import 'dart:html' as html;

void registerVideoView(String viewId, String blobUrl) {
  ui.platformViewRegistry.registerViewFactory(viewId, (int id) {
    final video = html.VideoElement()
      ..src = blobUrl
      ..controls = true
      ..autoplay = true
      ..loop = true
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.objectFit = 'cover';

    return video;
  });
}