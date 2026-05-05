import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:async';
import 'package:my_personal_website/ui/info.dart';
import 'package:my_personal_website/features/social_contact.dart';

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
    final isDesktop = size.width > 800;

    Widget modelSection = Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          bottom: isDesktop ? size.height * 0.15 : size.height * 0.05,
          child: AnimatedOpacity(
            opacity: _isReadyToStart ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            child: Container(
              width: isDesktop ? size.width * 0.4 : size.width * 0.8,
              height: isDesktop ? 180 : 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.9),
                    blurRadius: 80,
                    spreadRadius: 30,
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.elliptical(isDesktop ? size.width * 0.4 : size.width * 0.8, 100)),
              ),
            ),
          ),
        ),
        RepaintBoundary(
          child: SizedBox(
            height: isDesktop ? size.height : size.height * 0.5,
            child: ModelViewer(
              backgroundColor: Colors.transparent,
              src: 'assets/assets/models/welcome.glb',
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
    );

    Widget textAndButtonsSection = Padding(
      padding: EdgeInsets.only(
        left: isDesktop ? 60.0 : 20.0,
        right: isDesktop ? 60.0 : 20.0,
        top: isDesktop ? 0.0 : 30.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: isDesktop ? 250 : 120,
            child: _isReadyToStart 
              ? DefaultTextStyle(
                style: GoogleFonts.cinzel(
                  fontSize: isDesktop ? 42 : 28,
                  color: const Color(0xFFD4AF37),
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                  shadows: isDesktop 
                    ? [
                        const Shadow(offset: Offset(-1.5, -1.5), color: Colors.black),
                        const Shadow(offset: Offset(1.5, -1.5), color: Colors.black),
                        const Shadow(offset: Offset(1.5, 1.5), color: Colors.black),
                        const Shadow(offset: Offset(-1.5, 1.5), color: Colors.black),
                        Shadow(
                          blurRadius: 20.0,
                          color: Colors.black.withOpacity(0.8),
                          offset: const Offset(4.0, 4.0),
                        ),
                      ]
                    : [
                        const Shadow(offset: Offset(1.0, 1.0), color: Colors.black),
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.9),
                          offset: const Offset(2.0, 2.0),
                        ),
                      ],
                ),
                textAlign: isDesktop ? TextAlign.start : TextAlign.center,
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
                      textAlign: isDesktop ? TextAlign.start : TextAlign.center,
                    ),
                  ],
                ),
              )
              : const SizedBox.shrink(),
          ),
          SizedBox(height: isDesktop ? 30 : 10),
          _buildActionButtons(isDesktop),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black, 
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
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
          isDesktop
              ? Row(
                  children: [
                    Expanded(flex: 1, child: modelSection),
                    Expanded(flex: 1, child: textAndButtonsSection),
                  ],
                )
              : Column(
                  children: [
                    Expanded(flex: 1, child: textAndButtonsSection),
                    Expanded(flex: 1, child: modelSection),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(bool isDesktop) {
    return AnimatedOpacity(
      opacity: _showButtons ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeIn,
      child: Column(
        crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          _medievalButton(
            text: "I seek the Master of this Keep",
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ArchitectScreen())),
            isDesktop: isDesktop,
          ),
          const SizedBox(height: 12),
          _medievalButton(
            text: "I carry a parchment for thee",
            onTap: SocialContactStrip.sendRavenEmail,
            isDesktop: isDesktop,
          ),
        ],
      ),
    );
  }

  Widget _medievalButton({required String text, required VoidCallback onTap, required bool isDesktop}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: isDesktop ? 380 : MediaQuery.of(context).size.width * 0.8,
          constraints: const BoxConstraints(maxWidth: 380),
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 25 : 12, vertical: isDesktop ? 15 : 10),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.6), width: 1.5),
            borderRadius: BorderRadius.circular(4),
            color: Colors.black.withOpacity(0.8),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.almendra(
                fontSize: isDesktop ? 22 : 16,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}