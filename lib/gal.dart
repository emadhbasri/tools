import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'text.dart';
import 'colors.dart';
import 'image.dart';
import 'navigator.dart';
import 'size.dart';

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
      this.minScale,
      this.maxScale,
      this.initialScale,
      this.backgroundDecoration,
      this.reverse,
      this.enableRotation,
      this.scrollDirection,
      this.scrollPhysics})
      : super(key: key);
  final List<ToolsGalItem> images;
  final String? title;
  final double? minScale, maxScale, initialScale;
  final BoxDecoration? backgroundDecoration;
  final bool? reverse, enableRotation;
  final Axis? scrollDirection;
  final ScrollPhysics? scrollPhysics;
  @override
  ToolsGalMobileState createState() => ToolsGalMobileState();
}

class ToolsGalMobileState extends State<ToolsGalMobile> {
  final PageController _controller = PageController();
  int page = 0;

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
      builder: (context,  deviceType, screenWidth, screenHeight,
          realWidth, realHeight) {
        return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: ToolsText(
                widget.title ?? '',
                style: const TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                onPressed: () {
                  Go.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
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
                  scrollPhysics:
                      widget.scrollPhysics ?? const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      minScale: widget.minScale ?? 0.0,
                      maxScale: widget.maxScale ?? 2.0,
                      imageProvider: makeImage(widget.images[index]),
                      initialScale: PhotoViewComputedScale.contained *
                          (widget.initialScale ?? 0.8),
                      // heroAttributes: PhotoViewHeroAttributes(tag: galleryItems[index].id),
                    );
                  },
                  itemCount: widget.images.length,
                  scrollDirection: widget.scrollDirection ?? Axis.horizontal,
                  reverse: widget.reverse ?? false,
                  backgroundDecoration: widget.backgroundDecoration ??
                      const BoxDecoration(color: white),
                ),
                // if(page==0)
                //   Align(
                //     alignment: Alignment.centerRight,
                //     child: GestureDetector(
                //       onTap: (){
                //         _controller.animateToPage(1, duration: Duration(milliseconds: 500),
                //             curve: Curves.linear);
                //       },
                //       child: Container(
                //           padding: EdgeInsets.all(12),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(100),
                //               color: Colors.grey.withOpacity(.4)
                //           ),
                //           child: Icon(Icons.arrow_forward_ios)),
                //     ),
                //   ),
                // if(page==1)
                //   Align(
                //     alignment: Alignment.centerLeft,
                //     child: GestureDetector(
                //       onTap: (){
                //         _controller.animateToPage(0, duration: Duration(milliseconds: 500),
                //             curve: Curves.linear);
                //       },
                //       child: Container(
                //           padding: EdgeInsets.all(12),
                //           decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(100),
                //               color: Colors.grey.withOpacity(.4)
                //           ),
                //           child: Icon(Icons.arrow_back_ios_new)),
                //     ),
                //   ),
              ],
            ));
      },
    );
  }
}
