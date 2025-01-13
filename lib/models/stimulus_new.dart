import 'dart:async';
import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

part 'stimulus_new.freezed.dart';

// // Initialize stimuli map
// _stimuli = {
// tensIntensity : 0,
// tensModeChannel1 : 1,
// tensModeChannel2 : 1,
// tensPlayButtonChannel1 : 0,
// tensPlayButtonChannel2 : 0,
// currentChannel : 1,
// tensPhase: 0,
// temp : 0,
// vibeIntensity : 0,
// vibeFreq : 0
// };
@freezed
class StimulusNew with _$StimulusNew {
  const factory StimulusNew({
    @Default(0) int tensIntensity,

  }) = _StimulusNew;
}