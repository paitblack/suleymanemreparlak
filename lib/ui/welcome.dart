import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isReadyToStart = false;
  bool _showButtons = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted && !_isReadyToStart) {
        _triggerSequence();
      }
    });
  }

  void _triggerSequence() {
    setState(() {
      _isReadyToStart = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black, 
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(1.0),
                  Colors.black.withOpacity(0.8),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.35, 0.7], 
              ),
            ),
          ),
          
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: size.height * 0.15,
                      child: AnimatedOpacity(
                        opacity: _isReadyToStart ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          width: size.width * 0.4,
                          height: 180,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.9),
                                blurRadius: 80,
                                spreadRadius: 30,
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.elliptical(size.width * 0.4, 100)),
                          ),
                        ),
                      ),
                    ),
                    RepaintBoundary(
                      child: SizedBox(
                        height: size.height,
                        child: ModelViewer(
                          backgroundColor: Colors.transparent,
                          src: 'assets/models/welcome.glb',
                          alt: "Medieval Knight",
                          autoPlay: true,
                          cameraControls: false,
                          disableZoom: true,
                          exposure: 0.6,
                          onWebViewCreated: (controller) => _triggerSequence(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 250,
                        child: _isReadyToStart 
                          ? DefaultTextStyle(
                            style: GoogleFonts.cinzel(
                              fontSize: 42,
                              color: const Color(0xFFD4AF37),
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                              shadows: [
                                Shadow(offset: Offset(-1.5, -1.5), color: Colors.black),
                                Shadow(offset: Offset(1.5, -1.5), color: Colors.black),
                                Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                                Shadow(offset: Offset(-1.5, 1.5), color: Colors.black),
                                Shadow(
                                  blurRadius: 20.0,
                                  color: Colors.black.withOpacity(0.8),
                                  offset: const Offset(4.0, 4.0),
                                ),
                              ],
                            ),
                            child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              onFinished: () {
                                setState(() {
                                  _showButtons = true;
                                });
                              },
                              animatedTexts: [
                                TyperAnimatedText(
                                  'Halt, traveler!\nWhat seek ye in this\ndigital realm?',
                                  speed: const Duration(milliseconds: 50),
                                ),
                              ],
                            ),
                          )
                          : const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 30),
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return AnimatedOpacity(
      opacity: _showButtons ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeIn,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _medievalButton(
            text: "I seek the Master of this Keep",
            onTap: () => debugPrint("Seeking Architect..."),
          ),
          const SizedBox(height: 15),
          _medievalButton(
            text: "I carry a parchment for thee",
            onTap: () => debugPrint("Opening Message Box..."),
          ),
        ],
      ),
    );
  }

  Widget _medievalButton({required String text, required VoidCallback onTap}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 380,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.6), width: 1.5),
            borderRadius: BorderRadius.circular(4),
            color: Colors.black.withOpacity(0.8),
          ),
          child: Text(
            text,
            style: GoogleFonts.almendra(
              fontSize: 22,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}