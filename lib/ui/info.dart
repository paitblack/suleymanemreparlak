import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:my_personal_website/features/social_contact.dart';

class ArchitectScreen extends StatefulWidget {
  const ArchitectScreen({super.key});

  @override
  State<ArchitectScreen> createState() => _ArchitectScreenState();
}

class _ArchitectScreenState extends State<ArchitectScreen> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;
    final horizontalPadding = isDesktop ? size.width * 0.15 : 20.0;

    return Scaffold(
      backgroundColor: const Color(0xFF070707),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          children: [
            _buildParallaxBackground(),
            CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildSliverAppBar(size),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 40),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildHeroSection(),
                      _buildLinksSection(isDesktop),
                      const _OrnateDivider(),
                      _buildGuildRecordsSection(),
                      const _OrnateDivider(),
                      _buildArsenalSection(isDesktop),
                      const _OrnateDivider(),
                      _buildRunesSection(isDesktop),
                      const _OrnateDivider(),
                      _buildApprenticeshipSection(),
                      const _OrnateDivider(),
                      _buildChroniclesSection(isDesktop),
                      const _OrnateDivider(),
                      const SizedBox(height: 100),
                    ]),
                  ),
                ),
              ],
            ),
            _buildReturnButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLinksSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        const SocialContactStrip(),
      ],
    );
  }

  Widget _buildParallaxBackground() {
    return Positioned.fill(
      child: Image.asset(
        'assets/images/bg2.png',
        fit: BoxFit.cover,
        color: Colors.black.withOpacity(0.75),
        colorBlendMode: BlendMode.darken,
      ),
    );
  }

  Widget _buildReturnButton() {
    return Positioned(
      top: 40,
      left: 40,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          hoverColor: const Color(0xFFD4AF37).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_ios, color: Color(0xFFD4AF37), size: 16),
                const SizedBox(width: 8),
                Text(
                  "Return",
                  style: GoogleFonts.almendra(
                    color: const Color(0xFFD4AF37),
                    fontSize: 20,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(Size size) {
    return SliverAppBar(
      expandedHeight: size.height * 0.4,
      backgroundColor: Colors.transparent,
      elevation: 0,
      pinned: true,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          "The AI Engineer's Sanctum",
          style: GoogleFonts.cinzel(
            color: const Color(0xFFD4AF37),
            fontWeight: FontWeight.bold,
            fontSize: 28,
            shadows: [
              Shadow(color: Colors.black.withOpacity(0.9), blurRadius: 10, offset: const Offset(2, 2)),
            ],
          ),
        ),
        background: ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent, Colors.black],
              stops: [0.0, 0.5, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: Container(color: Colors.black.withOpacity(0.3)),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFD4AF37), width: 3),
            boxShadow: [
              BoxShadow(color: const Color(0xFFD4AF37).withOpacity(0.2), blurRadius: 30, spreadRadius: 5),
            ],
            image: const DecorationImage(
              image: AssetImage('assets/images/ben.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          "I forge realms from logic and light.",
          textAlign: TextAlign.center,
          style: GoogleFonts.cinzel(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          "A fourth-year Computer Engineering student in Turkey with a strong passion for computer science and a deep enthusiasm for Artifcial Intelligence and its applications. Dedicated to exploring AI-driven solutions, machine learning, and data science, with a keen interest in developing innovative and effcient technologies.",
          textAlign: TextAlign.center,
          style: GoogleFonts.almendra(
            fontSize: 20,
            color: Colors.white70,
            height: 1.8,
          ),
        ),
      ],
    );
  }

  Widget _buildArsenalSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _SectionTitle(title: "Arsenals"),
        const SizedBox(height: 40),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            const _SkillRune(name: "Python", mastery: 1),
            const _SkillRune(name: "Java", mastery: 1),
            const _SkillRune(name: "Flutter & Dart", mastery: 1),
            const _SkillRune(name: "PostgreSQL", mastery: 1),
            const _SkillRune(name: "MySQL", mastery: 1),
            const _SkillRune(name: "Firebase", mastery: 1),
            const _SkillRune(name: "Vector Databases(Qdrant, Faiss)", mastery: 1),
            const _SkillRune(name: "NestJS", mastery: 1),
            const _SkillRune(name: "PrismaORM", mastery: 1),
            const _SkillRune(name: "TensorFlow", mastery: 1),
            const _SkillRune(name: "Scikit-Learn", mastery: 1),
            const _SkillRune(name: "Pandas", mastery: 1),
            const _SkillRune(name: "NumPy", mastery: 1),
            const _SkillRune(name: "Bs4", mastery: 1),
            const _SkillRune(name: "Sellenium", mastery: 1),
            const _SkillRune(name: "FastAPI", mastery: 1),
            const _SkillRune(name: "Flask", mastery: 1),
            const _SkillRune(name: "Rest API", mastery: 1),
            const _SkillRune(name: "Docker", mastery: 1),
            const _SkillRune(name: "Google Developer Console", mastery: 1),
            const _SkillRune(name: "Git & GitHub", mastery: 1),
            const _SkillRune(name: "Text-to-Speech", mastery: 1),
            const _SkillRune(name: "Speech-to-Text", mastery: 1),
            const _SkillRune(name: "Asterisk", mastery: 1),

          ],
        ),
      ],
    );
  }

  Widget _buildRunesSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const _SectionTitle(title: "Runes"),
        const SizedBox(height: 40),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            const _SkillRune(name: "Data Preprocessing", mastery: 1),
            const _SkillRune(name: "Data Visualization(Matplotlib)", mastery: 1),
            const _SkillRune(name: "Deep Learning", mastery: 1),
            const _SkillRune(name: "Machine Learning", mastery: 1),
            const _SkillRune(name: "Natural Language Processing", mastery: 1),
            const _SkillRune(name: "Retrieval-Augmented Generation (RAG)", mastery: 1),
            const _SkillRune(name: "Large Language Models", mastery: 1),
            const _SkillRune(name: "AI Agents", mastery: 1),
            const _SkillRune(name: "Database Management Systems", mastery: 1),
            const _SkillRune(name: "Regular Expressions", mastery: 1),
            const _SkillRune(name: "Web Scraping/Parsing", mastery: 1),
            const _SkillRune(name: "Object Oriented Programming", mastery: 1),
            const _SkillRune(name: "Data Structures and Algorithms", mastery: 1),
            const _SkillRune(name: "Mobile and Desktop App Development", mastery: 1),
            const _SkillRune(name: "End-to-End Development", mastery: 1),
          ],
        ),
      ],
    );
  }

  Widget _buildChroniclesSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: "The Grand Chronicles"),
        const SizedBox(height: 40),
        _ProjectTome(
          title: "Tome I: BitSafe AI (TÜBİTAK 2209-A)",
          role: "Machine Learning and FastAPI Developer",
          description: """◦ Contributed to the AI components of a real-time, risk-based traffc analysis tool for small-scale networks, developed in Go using the BitNet model.
                          \n◦ Implemented website classifcation based on the IAB Taxonomy to categorize network traffc and enhance risk assessment capabilities.
                          \n◦ Additionally designed and deployed an effcient FastAPI service to serve the model for low-latency inference and scalable integration with the system.""",
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 20),
        _ProjectTome(
          title: "Tome II: Votel (Senior Design Project)",
          role: "Full Stack Developer and Architect",
          description: """◦ Engineered an end-to-end hospitality platform designed to empower small and boutique hotels with enterprise level automation, drastically reducing their manual administrative overhead.
                          \n◦ At its core, I built a fully autonomous AI voice assistant utilizing Asterisk, Python, and FastAPI that seamlessly handles 100% of complex room reservations, cancellations, and customer inquiries over the phone without human intervention.
                          \n◦ This intelligent voice agent is directly integrated with a robust B2B management dashboard developed with Nest.js, PostgreSQL, and Flutter; allowing hotel staff to confgure bot behavior and manage real-time room inventory effortlessly.
                          \n◦ To drive guest acquisition on the B2C side, the platform features a "Smart Hotel Finder" leveraging OpenSearch to deliver high-speed, natural language-based accommodation discovery tailored to user travel plans, while dynamically generating custom landing pages to establish online visibility for partner hotels lacking standalone websites.
                          \n◦ Finally, this highly scalable ecosystem is complemented by a cross-platform Flutter mobile application for on-the-go accessibility, with the entire architecture fully containerized via Docker for reliable deployment.""",
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 20),
        _ProjectTome(
          title: "Tome III: Layla - AI Based Mail Assistant",
          role: "Full Stack Developer and Architect",
          description: """◦ Developed a Flutter mobile app to manage Gmail accounts via Google OAuth2.
                          \n◦ Implemented features include full-text email search, a Gemini-powered chatbot, intelligent email header classifcation, and OCR-based document scanning.
                          \n◦ Demonstrates skills in mobile development, NLP, and API integration.""",
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 20),
        _ProjectTome(
          title: "Tome IV: NeuroLoop",
          role: "Full Stack Developer and Architect",
          description: """◦ Developed a Flutter desktop app for educational use, featuring personalized Qdrant vector databases for each user.
                          \n◦ Implemented a Gemini-powered RAG system for natural language Q&A, and automated quiz generation with categorized question storage for effcient retrieval.""",
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 20),
        _ProjectTome(
          title: "Tome V: Travelogue",
          role: "Co-Contributor and Java Android Developer",
          description: """◦ Developed Travelogue, a mobile travel journal application that enables users to document trips, visualize visited locations on an interactive map, and plan future travels through goal tracking and personalized features.
                          \n◦ Built and managed core features including trip journaling (add/edit/view travels), user authentication, settings, and travel detail modules, while contributing to UI components and overall application logic using Java and Android development principles.""",
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 20),
        _ProjectTome(
          title: "Tome VI: DejaView",
          role: "Co-Contributor and Machine Learning Developer",
          description: """◦ Clustered Turkish historical texts using SBERT, TF-IDF, and BERTurk with algorithms like KMeans, GMM, and OPTICS; benchmarked clustering performance.""",
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 20),
        _ProjectTome(
          title: "Tome VII: AI Car Game",
          role: "Full Stack Python Developer",
          description: """◦  Developed a car game using Pygame, and implemented AI agents trained with Reinforcement Learning(DQN) and rule-based algorithms.""",
          isDesktop: isDesktop,
        ),
        const SizedBox(height: 20),
        _ProjectTome(
          title: "Tome VIII: Smart Path Finder",
          role: "Full Stack Developer",
          description: """◦  Developed and visualized a pathfnding system using A* and Dijkstra’s algorithms, integrated with Leaﬂet.js for interactive mapping, served via Flask, and built with HTML, CSS, and JavaScript.""",
          isDesktop: isDesktop,
        ),
      ],
    );
  }

  Widget _buildGuildRecordsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: "Educational Guild Records"),
        const SizedBox(height: 40),
        const _TimelineNode(
          year: "BSc in Computer Engineering",
          title: "Muğla Sıtkı Koçman University",
          subtitle: "Sep 2021 - Present(Expected date of graduation: June 2026)",
          description: "GPA : 3.46",
          isLast: false,
        ),
      ],
    );
  }

  Widget _buildApprenticeshipSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(title: "Apprenticeship Records"),
        const SizedBox(height: 40),
        const _TimelineNode(
          year: "Artificial Intelligence Intern",
          title: "MAVA",
          subtitle: "Jun 2025 - Aug 2025 | Muğla, Turkey",
          description: "Developed a recommendation system by scraping data from a dynamic e-commerce platform and leveraging product categories for predictive modeling. Experimented with multiple approaches, including Logistic Regression with TF-IDF, LSTM, GRU, and fne-tuned BERTurk. Trained the models and containerized both the models and the OpenSearch database using Docker, resolving dependency issues and ensuring scalability. Designed and implemented an innovative web interface using HTML/CSS, and built a chatbot service powered by Gemini API and Flask, seamlessly integrated into the interface.",
          isLast: false,
        ),
        const _TimelineNode(
          year: "Data Science Intern",
          title: "Virtus R&D Software Inc.",
          subtitle: "May 2024 - Oct 2024 | Muğla, Turkey",
          description: "Developed Python scripts for data collection, preprocessing, and structuring, leveraging mathematical approaches to clean and organize CSV fles. Worked on medical image processing using TensorFlow, focusing on deep learning-based analysis. Experienced in data mining, automation, and building effcient pipelines for data organization and analysis.",
          isLast: false,
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.cinzel(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFD4AF37),
              letterSpacing: 3,
              shadows: [
                Shadow(color: Colors.black.withOpacity(0.8), offset: const Offset(3, 3), blurRadius: 6),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 2,
            width: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, const Color(0xFFD4AF37), Colors.transparent],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillRune extends StatefulWidget {
  final String name;
  final double mastery;

  const _SkillRune({required this.name, required this.mastery});

  @override
  State<_SkillRune> createState() => _SkillRuneState();
}

class _SkillRuneState extends State<_SkillRune> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animController;
  late Animation<double> _fillAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fillAnimation = Tween<double>(begin: 0, end: widget.mastery).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    Future.delayed(const Duration(milliseconds: 500), () => _animController.forward());
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isHovered ? const Color(0xFF1A1510) : Colors.black.withOpacity(0.5),
          border: Border.all(
            color: _isHovered ? const Color(0xFFD4AF37) : const Color(0xFFD4AF37).withOpacity(0.3),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isHovered
              ? [BoxShadow(color: const Color(0xFFD4AF37).withOpacity(0.2), blurRadius: 15, spreadRadius: 2)]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.name,
              style: GoogleFonts.almendra(
                fontSize: 18,
                color: _isHovered ? Colors.white : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Stack(
              children: [
                Container(
                  height: 4,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(2)),
                ),
                AnimatedBuilder(
                  animation: _fillAnimation,
                  builder: (context, child) {
                    return FractionallySizedBox(
                      widthFactor: _fillAnimation.value,
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4AF37),
                          borderRadius: BorderRadius.circular(2),
                          boxShadow: [
                            BoxShadow(color: const Color(0xFFD4AF37).withOpacity(0.5), blurRadius: 4),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectTome extends StatelessWidget {
  final String title;
  final String role;
  final String description; 
  final bool isDesktop;

  const _ProjectTome({
    required this.title,
    required this.role,
    required this.description,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 15,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.menu_book_sharp, 
              size: 200,
              color: const Color(0xFFD4AF37).withOpacity(0.03), 
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Padding(
              padding: EdgeInsets.all(isDesktop ? 40.0 : 25.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.cinzel(
                      fontSize: isDesktop ? 36 : 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFD4AF37),
                      shadows: const [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    role,
                    style: GoogleFonts.almendra(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 1,
                    width: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFD4AF37).withOpacity(0.5),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),             
                  const SizedBox(height: 25),
                  Text(
                    description,
                    style: GoogleFonts.almendra(
                      fontSize: 19,
                      color: Colors.white70,
                      height: 1.7,
                      letterSpacing: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: Container(
              width: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFD4AF37),
                    const Color(0xFFD4AF37).withOpacity(0.2),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineNode extends StatelessWidget {
  final String year;
  final String title;
  final String subtitle;
  final String description;
  final bool isLast;

  const _TimelineNode({
    required this.year,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  border: Border.all(color: const Color(0xFFD4AF37), width: 3),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [const Color(0xFFD4AF37), const Color(0xFFD4AF37).withOpacity(0.1)],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(year, style: GoogleFonts.cinzel(fontSize: 20, color: const Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(title, style: GoogleFonts.cinzel(fontSize: 24, color: Colors.white)),
                  const SizedBox(height: 5),
                  Text(subtitle, style: GoogleFonts.almendra(fontSize: 18, color: Colors.white54, fontStyle: FontStyle.italic)),
                  const SizedBox(height: 15),
                  Text(description, style: GoogleFonts.almendra(fontSize: 18, color: Colors.white70, height: 1.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HoverButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _HoverButton({required this.text, required this.onTap});

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0xFFD4AF37).withOpacity(0.1) : Colors.black.withOpacity(0.8),
            border: Border.all(color: const Color(0xFFD4AF37), width: _isHovered ? 2 : 1),
            borderRadius: BorderRadius.circular(4),
            boxShadow: _isHovered ? [BoxShadow(color: const Color(0xFFD4AF37).withOpacity(0.3), blurRadius: 10)] : [],
          ),
          child: Text(
            widget.text,
            style: GoogleFonts.cinzel(
              fontSize: 22,
              color: _isHovered ? Colors.white : const Color(0xFFD4AF37),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class _OrnateDivider extends StatelessWidget {
  const _OrnateDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80.0),
      child: CustomPaint(
        size: const Size(double.infinity, 40),
        painter: _DividerPainter(),
      ),
    );
  }
}

class _DividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD4AF37).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final center = Offset(size.width / 2, size.height / 2);
    
    // Middle Diamond
    final path = Path()
      ..moveTo(center.dx, center.dy - 10)
      ..lineTo(center.dx + 10, center.dy)
      ..lineTo(center.dx, center.dy + 10)
      ..lineTo(center.dx - 10, center.dy)
      ..close();
    canvas.drawPath(path, paint);

    // Left Line
    canvas.drawLine(Offset(0, center.dy), Offset(center.dx - 20, center.dy), paint);
    
    // Right Line
    canvas.drawLine(Offset(center.dx + 20, center.dy), Offset(size.width, center.dy), paint);

    // End Dots
    final dotPaint = Paint()..color = const Color(0xFFD4AF37).withOpacity(0.8);
    canvas.drawCircle(Offset(10, center.dy), 3, dotPaint);
    canvas.drawCircle(Offset(size.width - 10, center.dy), 3, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}