import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

export 'package:photo_view/photo_view.dart';
export 'package:photo_view/photo_view_gallery.dart';

import 'text.dart';
import 'colors.dart';
import 'image.dart';
import 'navigator.dart';
import 'size.dart';
import 'tools.dart';

enum ToolsGalType { asset, network, file }

class ToolsGalItem {
  final String url;
  final ToolsGalType type;
  ToolsGalItem(this.url, this.type);
}

class ToolsGalMobile extends StatefulWidget {
  const ToolsGalMobile(
      {Key? key,
      required this.images,
      this.title,
      this.screenWidth,
      this.screenHeight,
      this.minScale,
      this.maxScale,
      this.initialScale,
      this.backgroundDecoration,
      this.reverse,
      this.enableRotation,
      this.scrollDirection,
      this.page = 0,
      this.scrollPhysics})
      : super(key: key);
  final double? screenWidth, screenHeight;
  final List<ToolsGalItem> images;
  final String? title;
  final double? minScale, maxScale, initialScale;
  final BoxDecoration? backgroundDecoration;
  final bool? reverse, enableRotation;
  final Axis? scrollDirection;
  final ScrollPhysics? scrollPhysics;
  final int page;
  @override
  ToolsGalMobileState createState() => ToolsGalMobileState();
}

class ToolsGalMobileState extends State<ToolsGalMobile> {
  late PageController _controller;
  int page = 0;
  @override
  void initState() {
    page = widget.page;
    _controller = PageController(initialPage: widget.page);
    super.initState();
  }

  ImageProvider makeImage(ToolsGalItem image) {
    if (image.type == ToolsGalType.asset) {
      return AssetImage(image.url);
    } else if (image.type == ToolsGalType.network) {
      return networkImage(
        image.url,
      );
    } else {
      return FileImage(File(image.url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MySizer(
      builder: (context, deviceType, screenWidth, screenHeight, realWidth, realHeight) {
        return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: ToolsText(
                widget.title ?? '',
                style: TextStyle(color: mainColor),
              ),
              leading: IconButton(
                onPressed: () {
                  Go.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: mainColor,
                ),
              ),
            ),
            body: Stack(
              children: [
                PhotoViewGallery.builder(
                  enableRotation: widget.enableRotation ?? false,
                  pageController: _controller,
                  onPageChanged: (e) {
                    setState(() {
                      page = e;
                    });
                  },
                  scrollPhysics: widget.scrollPhysics ?? const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      minScale: widget.minScale ?? 0.0,
                      maxScale: widget.maxScale ?? 2.0,
                      imageProvider: makeImage(widget.images[index]),
                      initialScale: PhotoViewComputedScale.contained * (widget.initialScale ?? 0.8),
                      // heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
                    );
                  },
                  itemCount: widget.images.length,
                  scrollDirection: widget.scrollDirection ?? Axis.horizontal,
                  reverse: widget.reverse ?? false,
                  backgroundDecoration:
                      widget.backgroundDecoration ?? const BoxDecoration(color: white),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.images
                        .map((e) => Container(
                          width: doubleWidth(10,screenWidth),
                          height: doubleWidth(10,screenWidth),
                              decoration:
                                  BoxDecoration(
                                    image: DecorationImage(image: makeImage(e))),
                            ))
                        .toList(),
                  ),
                )
              ],
            ));
      },
    );
  }
}
