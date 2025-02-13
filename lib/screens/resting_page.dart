import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/duration_utils.dart';
import '../widgets/gradient_background.dart';
import 'starting_page.dart';
import 'working_page.dart';

class RestingPage extends StatefulWidget {
  final Duration workDuration;

  const RestingPage({super.key, required this.workDuration});

  @override
  RestingPageState createState() => RestingPageState();
}

class RestingPageState extends State<RestingPage> with TickerProviderStateMixin {
  bool isResting = true;
  bool isRestPaused = false;
  bool restStarted = false;

  Duration restDuration = Duration.zero;
  DateTime? restStartTime;
  Duration accumulatedRestDuration = Duration.zero;

  Timer? restTimer;
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
    restDuration = calculateRestDuration(widget.workDuration);
  }

  @override
  void dispose() {
    _snackbarController!.dispose();
    restTimer?.cancel();
    super.dispose();
  }

  void startResting() {
    setState(() {
      restStarted = true;
      isRestPaused = false;
      restStartTime = DateTime.now();
    });

    restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final elapsedTime = DateTime.now().difference(restStartTime!) + accumulatedRestDuration;
        restDuration = calculateRestDuration(widget.workDuration) - elapsedTime;

        if (restDuration.isNegative || restDuration == Duration.zero) {
          restTimer?.cancel();
          isResting = false;
          restStarted = false;
          restDuration = Duration.zero; // Reset rest duration
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WorkingPage()),
          );
        }
      });
    });
  }

  void pauseResting() {
    setState(() {
      isRestPaused = true;
    });
    accumulatedRestDuration += DateTime.now().difference(restStartTime!);
    restTimer?.cancel();
  }

  void resumeResting() {
    setState(() {
      isRestPaused = false;
      restStartTime = DateTime.now();
    });

    restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        final elapsedTime = DateTime.now().difference(restStartTime!) + accumulatedRestDuration;
        restDuration = calculateRestDuration(widget.workDuration) - elapsedTime;

        if (restDuration.isNegative || restDuration == Duration.zero) {
          restTimer?.cancel();
          isResting = false;
          restStarted = false;
          restDuration = Duration.zero; // Reset rest duration
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WorkingPage()),
          );
        }
      });
    });
  }

  void skipResting() {
    restTimer?.cancel();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const WorkingPage()),
      (route) => false,
    );
  }

  void stopResting() {
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
                isResting = false;
                isRestPaused = false;
                restDuration = Duration.zero;
                accumulatedRestDuration = Duration.zero;
                restTimer?.cancel();
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
        decoration: getGradientBackground(true),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Rest Timer',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                formatDuration(restDuration),
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
                    onPressed: !restStarted ? startResting : null,
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
                    onPressed: restStarted && isResting && !isRestPaused ? pauseResting : isRestPaused ? resumeResting : null,
                    child: Text(
                      isRestPaused ? 'Resume' : 'Pause',
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
                    onPressed: stopResting,
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
                onLongPress: skipResting,
                onPressed: () => showHint('Long press to skip resting'),
                child: const Text(
                  'Skip Resting',
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