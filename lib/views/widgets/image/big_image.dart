import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class BigImageScreen extends StatelessWidget {
  final String? url;
  final File? file;

  const BigImageScreen({
    Key? key,
    this.url,
    this.file,
  }) : super(key: key);

  static const Color _backgroundColor = Colors.black87;
  static const Color _textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        leading: const CloseButton(
          color: _textColor,
        ),
        title: const Text(
          'Fotoğraf',
          style: TextStyle(
            color: _textColor,
          ),
        ),
      ),
      backgroundColor: _backgroundColor,
      body: Center(
        child: Hero(
          tag: url ?? file!.path,
          child: url != null
              ? PhotoView(
                  imageProvider: CachedNetworkImageProvider(url!),
                )
              : PhotoView(
                  imageProvider: FileImage(file!),
                ),
        ),
      ),
    );
  }
}
