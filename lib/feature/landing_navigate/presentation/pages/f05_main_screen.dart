import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rhino_flutter/rhino.dart';
import 'package:story_maker/feature/landing_navigate/presentation/widgets/recording_dot.dart';
import 'package:story_maker/pico_voice/story_maker_pico_client.dart';
import 'package:story_maker/pico_voice/voice_intent_enum.dart';
import 'package:story_maker/utils/widgets/menu_button.dart';
import 'package:go_router/go_router.dart';

class F05MainScreen extends StatefulWidget {
  const F05MainScreen({super.key});

  @override
  State<F05MainScreen> createState() => F05MainScreenState();
}

class F05MainScreenState extends State<F05MainScreen> {
  final picoClient = StoryMakerPicoClient();

  void _handleInference(RhinoInference inference) {
    if (inference.isUnderstood ?? false) {
      final voiceIntent = VoiceIntent.fromString(inference.intent);
      switch (voiceIntent) {
        case VoiceIntent.createNewStory:
          debugPrint("Create new story");
          context.push(
            '/F20',
          );
          break;
        case VoiceIntent.note:
          debugPrint("Note");
          break;
        case VoiceIntent.unknown:
          debugPrint(
              "Unknown(Maybe you create a new setting on web console, but haven't update the app?)");
          break;
      }
    } else {
      debugPrint("The voice is not understood");
    }
  }

  void _handleError(Exception error) {
    debugPrint("The voice error is : ${error.toString()}");
  }

  @override
  void initState() {
    super.initState();
    picoClient.addInferenceCallback(_handleInference);
    picoClient.addErrorCallback(_handleError);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'home'.tr(),
        ),
        centerTitle: true,
        leading: const MenuButton(),
      ),
      body: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: picoClient.processingNotifier,
          builder: (context, isProcessing, child) {
            return isProcessing
                ? const RecordingDot()
                : ElevatedButton(
                    onPressed: () async {
                      await picoClient.startProcessing();
                    },
                    child: Text('start_listening'.tr()),
                  );
          },
        ),
      ),
    );
  }
}
