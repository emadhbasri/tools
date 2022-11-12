import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
export 'package:cached_network_image/cached_network_image.dart';

ImageProvider networkImage(String url, {bool noCatch = false}) {
  if (noCatch) {
    return NetworkImage(url);
  }
  return CachedNetworkImageProvider(url);
}

Widget imageNetwork(String url,
    {Color? color,
    BoxFit? fit,
    Color? loadingBackColor,
    Color? loadingColor,
    String? errorImage,
    bool noCatch = false}) {
  if (noCatch) {
    return Image.network(
      url,
      color: color,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress != null && progress.expectedTotalBytes != null) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                value: (progress.cumulativeBytesLoaded /
                        progress.expectedTotalBytes!)
                    .toDouble(),
                backgroundColor: loadingBackColor,
                valueColor: loadingColor == null
                    ? null
                    : AlwaysStoppedAnimation<Color>(loadingColor),
              ),
            ),
          );
        } else {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                backgroundColor: loadingBackColor,
                valueColor: loadingColor == null
                    ? null
                    : AlwaysStoppedAnimation<Color>(loadingColor),
              ),
            ),
          );
        }
      },
      errorBuilder: (context, error, stackTrace) {
        return errorImage != null
            ? Image.asset(errorImage, fit: BoxFit.fill)
            : const SizedBox();
      },
    );
  }

  return CachedNetworkImage(
    imageUrl: url,
    color: color,
    fit: fit,
    progressIndicatorBuilder: (context, url, DownloadProgress progress) {
      if (progress.totalSize != null) {
        return Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              value: (progress.downloaded / progress.totalSize!).toDouble(),
              backgroundColor: loadingBackColor,
              valueColor: loadingColor == null
                  ? null
                  : AlwaysStoppedAnimation<Color>(loadingColor),
            ),
          ),
        );
      } else {
        return Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              backgroundColor: loadingBackColor,
              valueColor: loadingColor == null
                  ? null
                  : AlwaysStoppedAnimation<Color>(loadingColor),
            ),
          ),
        );
      }
    },
    errorWidget: (context, url, error) => errorImage != null
        ? Image.asset(errorImage, fit: BoxFit.fill)
        : const SizedBox(),
  );
}
