import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rhino_flutter/rhino.dart';
import 'package:rhino_flutter/rhino_error.dart';
import 'package:rhino_flutter/rhino_manager.dart';

class StoryMakerPicoClient {
  static final StoryMakerPicoClient _instance =
      StoryMakerPicoClient._internal();

  /// The Rhino module, this is the core of the pico voice client
  RhinoManager? _rhinoManager;

  /// The state of the pico voice client
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  final processingNotifier = ValueNotifier<bool>(false);
  bool get isProcessing => processingNotifier.value;

  /// The context info of the pico voice client
  String? get contextInfo => _rhinoManager?.contextInfo;

  /// The inference callbacks, it's the result of the pico voice client
  final List<Function(RhinoInference)> _inferenceCallbacks = [];

  /// The error callbacks, it's the error of the pico voice client
  final List<Function(Exception)> _errorCallbacks = [];

  /// Private constructor for singleton pattern
  StoryMakerPicoClient._internal();

  /// Factory constructor for singleton pattern
  factory StoryMakerPicoClient() {
    return _instance;
  }

  /// Add an inference callback
  void addInferenceCallback(Function(RhinoInference) callback) {
    _inferenceCallbacks.add(callback);
  }

  /// Remove an inference callback
  void removeInferenceCallback(Function(RhinoInference) callback) {
    _inferenceCallbacks.remove(callback);
  }

  /// Add an error callback
  void addErrorCallback(Function(Exception) callback) {
    _errorCallbacks.add(callback);
  }

  /// Remove an error callback
  void removeErrorCallback(Function(Exception) callback) {
    _errorCallbacks.remove(callback);
  }

  /// Init the pico voice client
  Future<void> initRhino({
    required String accessKey,
  }) async {
    if (_isInitialized) {
      return;
    }
    String platform = Platform.isAndroid
        ? "android"
        : Platform.isIOS
            ? "ios"
            : throw RhinoRuntimeException(
                "This demo supports iOS and Android only.");

    String contextPath =
        "assets/pico_context/$platform/storyMaker_en_android_v3_0_0.rhn";

    try {
      _rhinoManager = await RhinoManager.create(
        accessKey,
        contextPath,
        _handleInference,
        processErrorCallback: _handleError,
      );
      _isInitialized = true;
    } on RhinoException catch (ex) {
      _handleError(ex);
    }
  }

  /// Handle the inference
  void _handleInference(RhinoInference inference) {
    stopProcessing();
    for (var callback in _inferenceCallbacks) {
      callback(inference);
    }
  }

  /// Handle the error
  void _handleError(Exception error) {
    stopProcessing();
    for (var callback in _errorCallbacks) {
      callback(error);
    }
  }

  /// Start listening and processing the audio
  Future<void> startProcessing() async {
    if (!_isInitialized) {
      debugPrint("Not initialized");
      return;
    }
    if (processingNotifier.value) {
      debugPrint("Already processing");
      return;
    }

    try {
      await _rhinoManager?.process();
      processingNotifier.value = true;
    } on RhinoException catch (ex) {
      processingNotifier.value = false;
      debugPrint(ex.toString());
      rethrow;
    }
  }

  /// Stop processing the audio
  void stopProcessing() {
    processingNotifier.value = false;
  }

  /// Pretty print the inference
  String prettyPrintInference(RhinoInference inference) {
    String printText =
        "{\n    \"isUnderstood\" : \"${inference.isUnderstood}\",\n";
    if (inference.isUnderstood!) {
      printText += "    \"intent\" : \"${inference.intent}\",\n";
      if (inference.slots!.isNotEmpty) {
        printText += '    "slots" : {\n';
        Map<String, String> slots = inference.slots!;
        for (String key in slots.keys) {
          printText += "        \"$key\" : \"${slots[key]}\",\n";
        }
        printText += '    }\n';
      }
    }
    printText += '}';
    return printText;
  }
}
