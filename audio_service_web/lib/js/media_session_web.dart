/// The interface to the Media Session API, `navigator.mediaSession`.
///
/// Useful links:
///  * W3C specification https://w3c.github.io/mediasession/
///  * MDN documentation https://developer.mozilla.org/en-US/docs/Web/API/MediaSession/
@JS()
library media_session_web;

import 'dart:js_interop';

/// Media session playback state types.
///
/// See [MediaSession.playbackState].
abstract class MediaSessionPlaybackState {
  MediaSessionPlaybackState._();

  /// The browsing context doesn't currently know the current playback
  /// state, or the playback state is not available at this time.
  static const none = 'none';

  /// The browser's media session is currently paused. Playback may be resumed.
  static const paused = 'paused';

  /// The browser's media session is currently playing media, which can be paused.
  static const playing = 'playing';
}

/// Actions that the user may perform in a media session.
abstract class MediaSessionActions {
  MediaSessionActions._();

  static const play = 'play';
  static const pause = 'pause';
  static const seekbackward = 'seekbackward';
  static const seekforward = 'seekforward';
  static const previoustrack = 'previoustrack';
  static const nexttrack = 'nexttrack';
  static const skipad = 'skipad';
  static const stop = 'stop';
  static const seekto = 'seekto';
  static const togglemicrophone = 'togglemicrophone';
  static const togglecamera = 'togglecamera';
  static const hangup = 'hangup';
}

/// A callback signature for the [MediaSession.setActionHandler].
typedef MediaSessionActionHandler = dynamic Function(MediaSessionActionDetails);

/// Specifies the type of action which needs to be performed
/// as well as the data needed to perform the action.
///
/// The dictionary parameter for [MediaSessionActionHandler] callback.
@JS()
@anonymous
extension type MediaSessionActionDetails._(JSObject _) implements JSObject {
  /// An action type string taken from the [MediaActions], indicating which
  /// type of action needs to be performed.
  external String get action;

  /// Indicates whether or not to perform a "fast" seek.
  ///
  /// A `seekto` action may optionally include this property.
  ///
  /// A "fast" seek is a seek being performed in a rapid sequence, such as when
  /// fast-forwarding or reversing through the media, rapidly skipping through it.
  ///
  /// This property can be used to indicate that you should use the shortest possible
  /// method to seek the media. This property is not included on the final action in
  /// the seek sequence in this situation.
  external bool? get fastSeek;

  /// If the action is either `seekforward` or `seekbackward`
  /// and this property is present, it is a floating point value which indicates
  /// the seek interval.
  ///
  /// If this property isn't present, those actions should choose a reasonable
  /// default interval.
  external double? get seekOffset;

  /// If the action is `seekto`, this property is present and
  /// indicates the absolute time within the media to move the playback position to.
  ///
  /// This property is not present for other action types.
  external double? get seekTime;

  /// Creates the details.
  external factory MediaSessionActionDetails({
    String? action,
    bool? fastSeek,
    double? seekOffset,
    double? seekTime,
  });
}
