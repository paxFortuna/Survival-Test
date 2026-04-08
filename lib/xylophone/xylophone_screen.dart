import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class XylophoneApp extends StatefulWidget {
  const XylophoneApp({super.key});

  @override
  State<XylophoneApp> createState() => _XylophoneAppState();
}

class _XylophoneAppState extends State<XylophoneApp> {
  // Soundpool pool = Soundpool.fromOptions(options: SoundpoolOptions.kDefault);
  // List<int> _soundIds = [];
  final List<AudioPlayer> _audioPlayers = [];

  bool _isLoading = true;

  @override
  void initState() {
    // initSoundPool();
    super.initState();
    initAudioPlayers();
  }

  @override
  void dispose() {
      for (final player in _audioPlayers) {
        player.dispose();
      }
    super.dispose();
  }

  Future<void> initAudioPlayers() async {
    final List<String> notes = [
      'do1.wav',
      're.wav',
      'mi.wav',
      'fa.wav',
      'sol.wav',
      'la.wav',
      'si.wav',
      'do2.wav',
    ];

    // for (final note in notes) {
    //   final player = AudioPlayer();
    //   await player.setAsset('assets/$note');
    //   _audioPlayers.add(player);
    // }
    await Future.wait(notes.map((note) async {
      final player = AudioPlayer();
      await player.setAsset('assets/$note');
      _audioPlayers.add(player);
    }));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //   SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
      //     appBar: AppBar(title: const Text('실로폰')),
          body:
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: gunban('도', Colors.red, index: 0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: gunban('레', Colors.amber, index: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: gunban('미', Colors.orange, index: 2),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: gunban('파', Colors.cyan, index: 3,)
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: gunban('솔', Colors.blue, index: 4),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48.0),
                        child: gunban('라', Colors.purple, index: 5),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 56.0),
                        child: gunban('시', Colors.orange, index: 6),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 64.0),
                        child: gunban('도', Colors.red, index: 7),
                      ),
                    ],
                  ),
    );
  }

  // Widget gunban(String text, Color color, int soundId) {
  //   return InkWell(
  //     onTap: (){
  //       // pool.play(soundId);
  //     },
  //     child: Container(
  //       width: 50,
  //       height: double.infinity,
  //       color: color,
  //       child: Text(text),
  //     ),
  //   );
  // }
Widget gunban(String text, Color color, {required int index}) {
  return InkWell(
    onTap: (){
      // pool.play(soundId);
      if(index <_audioPlayers.length) {
        _audioPlayers[index].seek(Duration.zero);
        _audioPlayers[index].play();
      }
    },
    child: Container(
      width: 50,
      height: double.infinity,
      color: color,
      child: Text(text),
    ),
  );
}

  // assets 디렉토리에 wav파일을 저장해야함.
  // Future<void> initSoundPool() async {
  //   int soundId = await rootBundle
  //       .load('assets/do1.wav')
  //       .then((soundData) => pool.load(soundData));
  //   _soundIds.add(soundId);
  //
  //   soundId = await rootBundle
  //       .load('assets/re.wav')
  //       .then((soundData) => pool.load(soundData));
  //   _soundIds.add(soundId);
  //   soundId = await rootBundle
  //       .load('assets/mi.wav')
  //       .then((soundData) => pool.load(soundData));
  //   _soundIds.add(soundId);
  //   soundId = await rootBundle
  //       .load('assets/fa.wav')
  //       .then((soundData) => pool.load(soundData));
  //   _soundIds.add(soundId);
  //   soundId = await rootBundle
  //       .load('assets/sol.wav')
  //       .then((soundData) => pool.load(soundData));
  //   _soundIds.add(soundId);
  //   soundId = await rootBundle
  //       .load('assets/ra.wav')
  //       .then((soundData) => pool.load(soundData));
  //   _soundIds.add(soundId);
  //   soundId = await rootBundle
  //       .load('assets/si.wav')
  //       .then((soundData) => pool.load(soundData));
  //   _soundIds.add(soundId);
  //   soundId = await rootBundle
  //       .load('assets/do2.wav')
  //       .then((soundData) => pool.load(soundData));
  //   _soundIds.add(soundId);
  //
  //   _isLoading = false;
  // }
}