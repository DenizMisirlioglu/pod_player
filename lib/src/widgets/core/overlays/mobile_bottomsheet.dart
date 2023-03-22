part of 'package:pod_player/src/pod_player.dart';

class _MobileBottomSheet extends StatelessWidget {
  final String tag;

  const _MobileBottomSheet({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PodGetXVideoController>(
      tag: tag,
      builder: (_podCtr) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_podCtr.vimeoOrVideoUrls.isNotEmpty)
            _bottomSheetTiles(
              title: _podCtr.podPlayerLabels.quality,
              icon: Icons.video_settings_rounded,
              subText: '${_podCtr.vimeoPlayingVideoQuality}p',
              titleTextStyle: _podCtr.overlayStyle!.bottomsheetTitleTextStyle,
              subTextStyle: _podCtr.overlayStyle!.bottomsheetSubTextStyle,
              iconColor: _podCtr.overlayStyle!.bottomsheetIconColor,
              onTap: () {
                Navigator.of(context).pop();
                Timer(const Duration(milliseconds: 100), () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    barrierColor: _podCtr.overlayStyle!.bottomsheetBarrierColor,
                    builder: (context) => SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          color: _podCtr.overlayStyle!.bottomsheetBackground ??
                              Colors.white,
                          borderRadius:
                              _podCtr.overlayStyle!.bottomsheetBorderRadius,
                        ),
                        child: _VideoQualitySelectorMob(
                          tag: tag,
                          onTap: null,
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          _bottomSheetTiles(
            title: _podCtr.podPlayerLabels.loopVideo,
            icon: Icons.loop_rounded,
            subText: _podCtr.isLooping
                ? _podCtr.podPlayerLabels.optionEnabled
                : _podCtr.podPlayerLabels.optionDisabled,
            titleTextStyle: _podCtr.overlayStyle!.bottomsheetTitleTextStyle,
            subTextStyle: _podCtr.overlayStyle!.bottomsheetSubTextStyle,
            iconColor: _podCtr.overlayStyle!.bottomsheetIconColor,
            onTap: () {
              Navigator.of(context).pop();
              _podCtr.toggleLooping();
            },
          ),
          _bottomSheetTiles(
            title: _podCtr.podPlayerLabels.playbackSpeed,
            icon: Icons.slow_motion_video_rounded,
            subText: _podCtr.currentPaybackSpeed,
            titleTextStyle: _podCtr.overlayStyle!.bottomsheetTitleTextStyle,
            subTextStyle: _podCtr.overlayStyle!.bottomsheetSubTextStyle,
            iconColor: _podCtr.overlayStyle!.bottomsheetIconColor,
            onTap: () {
              Navigator.of(context).pop();
              Timer(const Duration(milliseconds: 100), () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  barrierColor: _podCtr.overlayStyle!.bottomsheetBarrierColor,
                  builder: (context) => SafeArea(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _podCtr.overlayStyle!.bottomsheetBackground ??
                            Colors.white,
                        borderRadius:
                            _podCtr.overlayStyle!.bottomsheetBorderRadius,
                      ),
                      child: _VideoPlaybackSelectorMob(
                        tag: tag,
                        onTap: null,
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }

  ListTile _bottomSheetTiles({
    required String title,
    required IconData icon,
    String? subText,
    void Function()? onTap,
    TextStyle? titleTextStyle,
    TextStyle? subTextStyle,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      onTap: onTap,
      title: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(
              title,
              style: titleTextStyle,
            ),
            if (subText != null) const SizedBox(width: 6),
            if (subText != null)
              const SizedBox(
                height: 4,
                width: 4,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            if (subText != null) const SizedBox(width: 6),
            if (subText != null)
              Text(
                subText,
                style: subTextStyle ?? const TextStyle(color: Colors.grey),
              ),
          ],
        ),
      ),
    );
  }
}

class _VideoQualitySelectorMob extends StatelessWidget {
  final void Function()? onTap;
  final String tag;

  const _VideoQualitySelectorMob({
    Key? key,
    required this.onTap,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _podCtr = Get.find<PodGetXVideoController>(tag: tag);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _podCtr.vimeoOrVideoUrls
            .map(
              (e) => ListTile(
                title: Text('${e.quality}p',
                    style: _podCtr.overlayStyle!.bottomsheetTitleTextStyle),
                onTap: () {
                  onTap != null ? onTap!() : Navigator.of(context).pop();

                  _podCtr.changeVideoQuality(e.quality);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class _VideoPlaybackSelectorMob extends StatelessWidget {
  final void Function()? onTap;
  final String tag;

  const _VideoPlaybackSelectorMob({
    Key? key,
    required this.onTap,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _podCtr = Get.find<PodGetXVideoController>(tag: tag);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _podCtr.videoPlaybackSpeeds
            .map(
              (e) => ListTile(
                title: Text(e,
                    style: _podCtr.overlayStyle!.bottomsheetTitleTextStyle),
                onTap: () {
                  onTap != null ? onTap!() : Navigator.of(context).pop();
                  _podCtr.setVideoPlayBack(e);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class _MobileOverlayBottomControllers extends StatelessWidget {
  final String tag;

  const _MobileOverlayBottomControllers({
    Key? key,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const durationTextStyle = TextStyle(color: Colors.white70);
    const itemColor = Colors.white;

    return GetBuilder<PodGetXVideoController>(
      tag: tag,
      id: 'full-screen',
      builder: (_podCtr) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(width: 12),
              GetBuilder<PodGetXVideoController>(
                tag: tag,
                id: 'video-progress',
                builder: (_podCtr) {
                  return Row(
                    children: [
                      Text(
                        _podCtr.calculateVideoDuration(_podCtr.videoPosition),
                        style: const TextStyle(color: itemColor),
                      ),
                      const Text(
                        ' / ',
                        style: durationTextStyle,
                      ),
                      Text(
                        _podCtr.calculateVideoDuration(_podCtr.videoDuration),
                        style: durationTextStyle,
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              GetBuilder<PodGetXVideoController>(
                tag: tag,
                id: 'volume',
                builder: (_podCtr) => MaterialIconButton(
                  toolTipMsg: _podCtr.isMute
                      ? _podCtr.podPlayerLabels.unmute ??
                          'Unmute${kIsWeb ? ' (m)' : ''}'
                      : _podCtr.podPlayerLabels.mute ??
                          'Mute${kIsWeb ? ' (m)' : ''}',
                  color: itemColor,
                  onPressed: _podCtr.toggleMute,
                  child: Icon(
                    _podCtr.isMute
                        ? Icons.volume_off_rounded
                        : Icons.volume_up_rounded,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              MaterialIconButton(
                toolTipMsg: _podCtr.isFullScreen
                    ? _podCtr.podPlayerLabels.exitFullScreen ??
                        'Exit full screen${kIsWeb ? ' (f)' : ''}'
                    : _podCtr.podPlayerLabels.fullscreen ??
                        'Fullscreen${kIsWeb ? ' (f)' : ''}',
                color: itemColor,
                onPressed: () {
                  if (_podCtr.isOverlayVisible) {
                    if (_podCtr.isFullScreen) {
                      _podCtr.disableFullScreen(context, tag);
                    } else {
                      _podCtr.enableFullScreen(tag);
                    }
                  } else {
                    _podCtr.toggleVideoOverlay();
                  }
                },
                child: Icon(
                  _podCtr.isFullScreen
                      ? Icons.fullscreen_exit
                      : Icons.fullscreen,
                ),
              ),
            ],
          ),
          GetBuilder<PodGetXVideoController>(
            tag: tag,
            id: 'overlay',
            builder: (_podCtr) {
              if (_podCtr.isFullScreen) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
                  child: Visibility(
                    visible: _podCtr.isOverlayVisible,
                    child: PodProgressBar(
                      tag: tag,
                      alignment: Alignment.topCenter,
                      podProgressBarConfig: _podCtr.podProgressBarConfig,
                    ),
                  ),
                );
              }
              return PodProgressBar(
                tag: tag,
                alignment: Alignment.bottomCenter,
                podProgressBarConfig: _podCtr.podProgressBarConfig,
              );
            },
          ),
        ],
      ),
    );
  }
}
