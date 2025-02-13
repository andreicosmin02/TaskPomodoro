import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/duration_utils.dart';
import '../widgets/gradient_background.dart';
import 'resting_page.dart';
import 'starting_page.dart';

class WorkingPage extends StatefulWidget {
  const WorkingPage({super.key});

  @override
  WorkingPageState createState() => WorkingPageState();
}

class WorkingPageState extends State<WorkingPage> with TickerProviderStateMixin {
  bool isStopwatchRunning = false;
  bool isStopwatchPaused = false;

  Duration stopwatchDuration = Duration.zero;
  DateTime? stopwatchStartTime;
  DateTime? stopwatchPauseTime;
  Duration accumulatedStopwatchDuration = Duration.zero;

  Timer? stopwatchTimer;
  AnimationController? _snackbarController;
  Animation<double>? _snackbarOpacity;
  OverlayEntry? _snackbarOverlayEntry;

  @override
  void initState() {
    super.initState();
    _snackbarController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _snackbarOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(_snackbarController!);
  }

  @override
  void dispose() {
    _snackbarController!.dispose();
    stopwatchTimer?.cancel();
    super.dispose();
  }

  void startStopwatch() {
    setState(() {
      isStopwatchRunning = true;
      isStopwatchPaused = false;
      stopwatchStartTime = DateTime.now();
    });

    stopwatchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        stopwatchDuration = DateTime.now().difference(stopwatchStartTime!) + accumulatedStopwatchDuration;
      });
    });
  }

  void pauseStopwatch() {
    setState(() {
      isStopwatchPaused = true;
      stopwatchPauseTime = DateTime.now();
    });
    accumulatedStopwatchDuration += DateTime.now().difference(stopwatchStartTime!);
    stopwatchTimer?.cancel();
  }

  void resumeStopwatch() {
    setState(() {
      isStopwatchPaused = false;
      stopwatchStartTime = DateTime.now();
    });

    stopwatchTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        stopwatchDuration = DateTime.now().difference(stopwatchStartTime!) + accumulatedStopwatchDuration;
      });
    });
  }

  void stopStopwatch() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to reset everything?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                isStopwatchRunning = false;
                isStopwatchPaused = false;
                stopwatchDuration = Duration.zero;
                accumulatedStopwatchDuration = Duration.zero;
                stopwatchTimer?.cancel();
              });
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const StartingPage()),
                (route) => false,
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void goResting() {
    stopwatchTimer?.cancel();
    setState(() {
      isStopwatchRunning = false;
      isStopwatchPaused = false;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RestingPage(workDuration: stopwatchDuration)),
    );
  }

  void showHint(String message) {
    _snackbarController!.reset();

    if (_snackbarOverlayEntry != null) {
      _snackbarOverlayEntry!.remove();
      _snackbarOverlayEntry = null;
    }

    _snackbarOverlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50,
        left: 20,
        right: 20,
        child: AnimatedBuilder(
          animation: _snackbarOpacity!,
          builder: (context, child) {
            return Opacity(
              opacity: _snackbarOpacity!.value,
              child: child,
            );
          },
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(12),
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(221, 56, 56, 56),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_snackbarOverlayEntry!);

    Future.delayed(const Duration(seconds: 2), () {
      _snackbarController!.forward();
    });

    Future.delayed(const Duration(seconds: 3), () {
      _snackbarOverlayEntry?.remove();
      _snackbarOverlayEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 1),
        decoration: getGradientBackground(false),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Work Timer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                formatDuration(stopwatchDuration),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFFbfce1c),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    onPressed: !isStopwatchRunning && !isStopwatchPaused ? startStopwatch : null,
                    child: const Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFFbfce1c),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    onPressed: isStopwatchRunning && !isStopwatchPaused ? pauseStopwatch : isStopwatchPaused ? resumeStopwatch : null,
                    child: Text(
                      isStopwatchPaused ? 'Resume' : 'Pause',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFFbfce1c),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    onPressed: stopStopwatch,
                    child: const Text(
                      'Stop',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                ),
                onLongPress: goResting,
                onPressed: () => showHint('Long press to go resting'),
                child: const Text(
                  'Go Resting',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}