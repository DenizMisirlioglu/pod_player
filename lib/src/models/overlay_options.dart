import 'package:flutter/material.dart';

import '../../pod_player.dart';

class OverLayOptions {
  final PodVideoState podVideoState;
  final Duration videoDuration;
  final Duration videoPosition;
  final bool isFullScreen;
  final bool isLooping;
  final bool isOverlayVisible;
  final bool isMute;
  final bool autoPlay;
  final String currentVideoPlaybackSpeed;
  final List<String> videoPlayBackSpeeds;
  final PodVideoPlayerType videoPlayerType;
  final PodProgressBar podProgressBar;
  OverLayOptions({
    required this.podVideoState,
    required this.videoDuration,
    required this.videoPosition,
    required this.isFullScreen,
    required this.isLooping,
    required this.isOverlayVisible,
    required this.isMute,
    required this.autoPlay,
    required this.currentVideoPlaybackSpeed,
    required this.videoPlayBackSpeeds,
    required this.videoPlayerType,
    required this.podProgressBar,
  });
}

class OverlayStyle {
  OverlayStyle({
    this.bottomsheetBackground = Colors.white,
    this.bottomsheetBorderRadius = BorderRadius.zero,
    this.bottomsheetBarrierColor,
    this.bottomsheetTitleTextStyle,
    this.bottomsheetSubTextStyle,
    this.bottomsheetIconColor,
  });

  final Color? bottomsheetBackground;
  final BorderRadius? bottomsheetBorderRadius;
  final Color? bottomsheetBarrierColor;
  final TextStyle? bottomsheetTitleTextStyle;
  final TextStyle? bottomsheetSubTextStyle;
  final Color? bottomsheetIconColor;
}
