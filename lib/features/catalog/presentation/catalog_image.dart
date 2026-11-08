import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:madivizion_jdonuts_app/app/di/injector.dart';
import 'package:madivizion_jdonuts_app/app/theme/app_theme.dart';
import 'package:madivizion_jdonuts_app/core/result/result.dart';
import 'package:madivizion_jdonuts_app/features/catalog/domain/image_cache.dart';
import 'package:madivizion_jdonuts_app/l10n/app_localizations.dart';

/// Bundled asset, or a remote file read from the disk cache.
class CatalogImage extends StatefulWidget {
  const CatalogImage({
    required this.url,
    this.load,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String url;
  final BoxFit fit;
  final Future<Result<Uint8List>> Function(String url)? load;

  static const placeholderKey = Key('catalog-image-placeholder');
  static const errorKey = Key('catalog-image-error');

  @override
  State<CatalogImage> createState() => _CatalogImageState();
}

class _CatalogImageState extends State<CatalogImage> {
  Uint8List? _bytes;
  var _failed = false;

  @override
  void initState() {
    super.initState();
    if (!isBundledAsset(widget.url)) {
      _load();
    }
  }

  Future<void> _load() async {
    final load = widget.load ?? injector<LoadRemoteImage>().call;
    final result = await load(widget.url);
    if (!mounted) {
      return;
    }
    setState(() {
      if (result case Success<Uint8List>(:final value)) {
        _bytes = value;
      } else {
        _failed = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: _picture());
  }

  Widget _picture() {
    if (isBundledAsset(widget.url)) {
      return Image.asset(
        widget.url,
        fit: widget.fit,
        errorBuilder: (_, _, _) => const _ImageError(),
      );
    }
    final bytes = _bytes;
    if (_failed) {
      return const _ImageError();
    }
    if (bytes == null) {
      return const _ImagePlaceholder();
    }
    return Image.memory(
      bytes,
      fit: widget.fit,
      errorBuilder: (_, _, _) => const _ImageError(),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      key: CatalogImage.placeholderKey,
      color: AppColors.border,
      child: SizedBox.expand(),
    );
  }
}

class _ImageError extends StatelessWidget {
  const _ImageError();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      key: CatalogImage.errorKey,
      color: AppColors.border,
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          color: AppColors.textSecondary,
          semanticLabel: AppLocalizations.of(context).imageUnavailable,
        ),
      ),
    );
  }
}
