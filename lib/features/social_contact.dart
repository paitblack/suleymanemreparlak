import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialContactStrip extends StatelessWidget {
  const SocialContactStrip({super.key});
  static const String _githubUrl = 'https://github.com/paitblack';
  static const String _linkedinUrl = 'https://www.linkedin.com/in/süleyman-emre-parlak-a30374260';
  static const String _contactEmail = 'emre-parlak2002@hotmail.com';
  static const String _emailSubject = 'Greetings! From Portfolio';

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $urlString');
    }
  }

  static String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  static Future<void> sendRavenEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: _contactEmail,
      query: encodeQueryParameters(<String, String>{
        'subject': _emailSubject,
        'body': 'Hello Emre,\n\n',
      }),
    );

    if (!await launchUrl(emailLaunchUri)) {
      debugPrint('Could not launch mail client');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 40),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: const Color(0xFFD4AF37).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _SocialIconBtn(
              icon: FontAwesomeIcons.github,
              onTap: () => _launchUrl(_githubUrl),
              tooltip: 'Visit GitHub Chronicle',
            ),
            const SizedBox(width: 25),
            _SocialIconBtn(
              icon: FontAwesomeIcons.linkedinIn,
              onTap: () => _launchUrl(_linkedinUrl),
              tooltip: 'Connect on LinkedIn',
            ),
            const SizedBox(width: 25),
            _SocialIconBtn(
              icon: Icons.email_outlined,
              onTap: SocialContactStrip.sendRavenEmail, 
              tooltip: 'Send a Raven',
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIconBtn extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  const _SocialIconBtn({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  @override
  State<_SocialIconBtn> createState() => _SocialIconBtnState();
}

class _SocialIconBtnState extends State<_SocialIconBtn> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: Tooltip(
        message: widget.tooltip,
        textStyle: const TextStyle(color: Colors.black),
        decoration: BoxDecoration(
          color: const Color(0xFFD4AF37),
          borderRadius: BorderRadius.circular(4),
        ),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isHovered ? const Color(0xFFD4AF37).withOpacity(0.1) : Colors.transparent,
            ),
            child: FaIcon(
              widget.icon,
              size: 28,
              color: _isHovered ? const Color(0xFFD4AF37) : Colors.white.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }
}