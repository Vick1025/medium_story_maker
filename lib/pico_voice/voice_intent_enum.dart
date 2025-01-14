enum VoiceIntent {
  createNewStory,
  note,
  unknown;

  static VoiceIntent fromString(String? intent) {
    if (intent == null) return VoiceIntent.unknown;

    return VoiceIntent.values.firstWhere(
      (e) => e.name == intent,
      orElse: () => VoiceIntent.unknown,
    );
  }
}
