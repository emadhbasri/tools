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
    Widget? errorImage,
    String? type,
    double? height,width,
    bool noCatch = false}) {
  if (noCatch) {
    return Image.network(
      url,
      color: color,
      fit: fit,
      height:height,
      width: width,
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
            ? errorImage
            : const SizedBox();
      },
    );
  }

  return CachedNetworkImage(
      imageUrl: url,
      color: color,
      fit: fit,
      height:height,
      width: width,
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
      errorWidget: (context, url, error) {
        return errorImage != null
            ? errorImage
            : const SizedBox();
        // switch (type) {
        //   case 'person':
        //     return Image.asset('assets/images/person/person_icons.png', fit: BoxFit.fill);
        //   case 'brand':
        //     return Image.asset('assets/images/brand.jpg', fit: BoxFit.fill);
        //   case 'ravand':
        //     return Image.asset('assets/images/buildsmall.jpg',
        //         fit: BoxFit.fill);
        //   case 'ravandbig': //todo
        //     return Image.asset('assets/images/buildbig.jpg', fit: BoxFit.fill);
        //   case 'map': //todo
        //     return Image.asset('assets/images/MAP_BASTAR.jpg',
        //         fit: BoxFit.fill);
        //   default:
        //     return Image.asset('assets/images/logo.png', fit: BoxFit.fill);
        // }
      });
}

/// center
CachedNetworkImage imageNetworkC(String url,
    {Color? color,
    BoxFit? fit,
    Color? loadingBackColor,
    Color? loadingColor,
    Widget? errorImage,
    String? type,
    bool noCatch = false}) {

  var out = CachedNetworkImage(
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
      errorWidget: (context, url, error) {
        return errorImage != null
            ? errorImage
            : const SizedBox();
      });
      return out;
}
