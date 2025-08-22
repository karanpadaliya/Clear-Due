import 'package:flutter/material.dart';
import 'package:myco_flutter/core/utils/responsive.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatefulWidget {
  final String? imageUrl;
  final ImageProvider? imageProvider;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CachedImage({
    super.key, // For Search Functionality Key should be passed
    this.imageUrl,
    this.imageProvider,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  }) : assert(
         imageUrl != null || imageProvider != null,
         'Either imageUrl or imageProvider must be provided.',
       );

  @override
  State<CachedImage> createState() => _CachedImageState();
}

class _CachedImageState extends State<CachedImage> {
  late final ImageProvider _provider;
  bool _hasError = false;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();

    _provider = widget.imageProvider ?? NetworkImage(widget.imageUrl!);

    _provider
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener(
            (info, _) {
              if (mounted) {
                setState(() => _isLoaded = true);
              }
            },
            onError: (_, __) {
              if (mounted) {
                setState(() => _hasError = true);
              }
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return widget.errorWidget ??
          Icon(
            Icons.broken_image,
            size: 30 * Responsive.getResponsive(context),
            color: Colors.grey,
          );
    }

    if (!_isLoaded) {
      return widget.placeholder ??
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: widget.width,
              height: widget.height,
              color: Colors.white,
            ),
          );
    }

    return Image(
      key: ValueKey(widget.imageUrl ?? widget.imageProvider.toString()),
      image: _provider,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:myco_flutter/core/utils/responsive.dart';
// import 'package:shimmer/shimmer.dart';

// class CachedImage extends StatefulWidget {
//   final String imageUrl;
//   final BoxFit fit;
//   final double? width;
//   final double? height;
//   final Widget? placeholder;
//   final Widget? errorWidget;

//   const CachedImage({
//     required this.imageUrl,
//     super.key,
//     this.fit = BoxFit.cover,
//     this.width,
//     this.height,
//     this.placeholder,
//     this.errorWidget,
//   });

//   @override
//   State<CachedImage> createState() => _CachedImageState();
// }

// class _CachedImageState extends State<CachedImage> {
//   late final ImageProvider _imageProvider;
//   bool _hasError = false;
//   bool _isLoaded = false;

//   @override
//   void initState() {
//     super.initState();
//     _imageProvider = NetworkImage(widget.imageUrl);

//     _imageProvider
//         .resolve(const ImageConfiguration())
//         .addListener(
//           ImageStreamListener(
//             (info, _) {
//               if (mounted) {
//                 setState(() => _isLoaded = true);
//               }
//             },
//             onError: (_, __) {
//               if (mounted) {
//                 setState(() => _hasError = true);
//               }
//             },
//           ),
//         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_hasError) {
//       return widget.errorWidget ??
//           Icon(
//             Icons.broken_image,
//             size: 30 * Responsive.getResponsive(context),
//             color: Colors.grey,
//           );
//     }

//     if (!_isLoaded) {
//       return widget.placeholder ??
//           Shimmer.fromColors(
//             baseColor: Colors.grey.shade300,
//             highlightColor: Colors.grey.shade100,
//             child: Container(
//               width: widget.width,
//               height: widget.height,
//               color: Colors.white,
//             ),
//           );
//     }

//     return Image(
//       image: _imageProvider,
//       fit: widget.fit,
//       width: widget.width,
//       height: widget.height,
//     );
//   }
// }
