import 'package:flutter/widgets.dart';

/// 圖片畫家
class CImagePainter extends StatelessWidget {
  const CImagePainter(
    this.imageProvider, {
    super.key,
    required this.width,
    required this.height,
  });

  final ImageProvider<Object> imageProvider;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _ImagePainter(imageProvider, width: width, height: height),
        child: SizedBox(
          width: width,
          height: height,
        ),
      ),
    );
  }
}

class _ImagePainter extends CustomPainter {
  const _ImagePainter(
    this.imageProvider, {
    required this.width,
    required this.height,
  });

  final ImageProvider<Object> imageProvider;
  final double width;
  final double height;

  @override
  void paint(Canvas canvas, Size size) {
    debugPrint('======paint : paint=========');

    final ImageStream stream = imageProvider.resolve(ImageConfiguration.empty);

    stream.addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          final imageWidth = image.image.width;
          final imageHeight = image.image.height;

          if (synchronousCall) {
            final double imageAspectRatio = imageWidth / imageHeight;
            final double canvasAspectRatio = size.width / size.height;

            double targetWidth;
            double targetHeight;

            if (canvasAspectRatio > imageAspectRatio) {
              // 如果畫布的寬高比大於圖片的寬高比，則基於畫布的高度調整目標寬度
              targetWidth = size.height * imageAspectRatio;
              targetHeight = size.height;
            } else {
              // 如果畫布的寬高比小於或等於圖片的寬高比，則基於畫布的寬度調整目標高度
              targetWidth = size.width;
              targetHeight = size.width / imageAspectRatio;
            }

            final Rect rect = Rect.fromCenter(
              center: size.center(Offset.zero),
              width: targetWidth,
              height: targetHeight,
            );

            final Rect destRect = Rect.fromPoints(
              Offset.zero,
              Offset(
                imageWidth.toDouble(),
                imageHeight.toDouble(),
              ),
            );

            canvas.drawImageRect(
              image.image,
              destRect,
              rect,
              Paint(),
            );
          }
        },
        onChunk: (ImageChunkEvent? chunkEvent) {
          // Handle image loading chunks if necessary
          print({'Handle image loading chunks if necessary: $chunkEvent'});
        },
        onError: (dynamic error, StackTrace? stackTrace) {
          // Handle image loading error if necessary
          print({'Handle image loading error if necessary: $error'});
        },
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _ImagePainter oldDelegate) {
    return oldDelegate.width != width || oldDelegate.height != height;
  }
}
