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
                _buildSliverAppBar(size, isDesktop),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: isDesktop ? 40 : 20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildHeroSection(isDesktop),
                      _buildLinksSection(isDesktop),
                      const _OrnateDivider(),
                      _buildGuildRecordsSection(isDesktop),
                      const _OrnateDivider(),
                      _buildArsenalSection(isDesktop, size),
                      const _OrnateDivider(),
                      _buildRunesSection(isDesktop, size),
                      const _OrnateDivider(),
                      _buildApprenticeshipSection(isDesktop),
                      const _OrnateDivider(),
                      _buildChroniclesSection(isDesktop),
                      const _OrnateDivider(),
                      const SizedBox(height: 100),
                    ]),
                  ),
                ),
              ],
            ),
            _buildReturnButton(isDesktop),
          ],
        ),
      ),
    );
  }

  Widget _buildLinksSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: isDesktop ? 40 : 20),
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

  Widget _buildReturnButton(bool isDesktop) {
    return Positioned(
      top: isDesktop ? 40 : 50,
      left: isDesktop ? 40 : 10,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pop(context),
          hoverColor: const Color(0xFFD4AF37).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.all(isDesktop ? 8.0 : 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back_ios, color: const Color(0xFFD4AF37), size: isDesktop ? 16 : 14),
                SizedBox(width: isDesktop ? 8 : 4),
                Text(
                  "Return",
                  style: GoogleFonts.almendra(
                    color: const Color(0xFFD4AF37),
                    fontSize: isDesktop ? 20 : 16,
                    letterSpacing: isDesktop ? 2 : 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(Size size, bool isDesktop) {
    return SliverAppBar(
      expandedHeight: size.height * (isDesktop ? 0.4 : 0.3),
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
            fontSize: isDesktop ? 28 : 18,
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

  Widget _buildHeroSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: isDesktop ? 120 : 90,
          height: isDesktop ? 120 : 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFD4AF37), width: isDesktop ? 3 : 2),
            boxShadow: [
              BoxShadow(color: const Color(0xFFD4AF37).withOpacity(0.2), blurRadius: 30, spreadRadius: 5),
            ],
            image: const DecorationImage(
              image: AssetImage('assets/images/ben.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: isDesktop ? 40 : 25),
        Text(
          "I forge realms from logic and light.",
          textAlign: TextAlign.center,
          style: GoogleFonts.cinzel(
            fontSize: isDesktop ? 32 : 22,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: isDesktop ? 30 : 20),
        Text(
          "Computer Engineering graduate specializing in Artifcial Intelligence, Machine Learning, and AI-driven software systems. Experienced in developing end-to-end solutions involving LLMs, RAG systems, voice assistants, and scalable backend architectures. Passionate about building intelligent technologies that solve real-world problems.",
          textAlign: TextAlign.center,
          style: GoogleFonts.almendra(
            fontSize: isDesktop ? 20 : 16,
            color: Colors.white70,
            height: isDesktop ? 1.8 : 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildArsenalSection(bool isDesktop, Size size) {
    final double spacing = isDesktop ? 20 : 10;
    final double itemWidth = isDesktop ? 300 : (size.width - 40 - (spacing * 2) - 1) / 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _SectionTitle(title: "Arsenals", isDesktop: isDesktop),
        SizedBox(height: isDesktop ? 40 : 25),
        Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.center,
          children: [
            _SkillRune(name: "Python", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Java", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Flutter & Dart", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "PostgreSQL", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "MySQL", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Firebase", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Vector Databases\n(Qdrant, Faiss)", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "NestJS", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "PrismaORM", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "TensorFlow", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Scikit-Learn", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Pandas", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "NumPy", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Bs4", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Sellenium", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "FastAPI", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Flask", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Rest API", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Docker", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Google Developer\nConsole", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Git & GitHub", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Text-to-Speech", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Speech-to-Text", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Asterisk", mastery: 1, isDesktop: isDesktop, width: itemWidth),
          ],
        ),
      ],
    );
  }

  Widget _buildRunesSection(bool isDesktop, Size size) {
    final double spacing = isDesktop ? 20 : 10;
    final double itemWidth = isDesktop ? 300 : (size.width - 40 - (spacing * 2) - 1) / 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _SectionTitle(title: "Runes", isDesktop: isDesktop),
        SizedBox(height: isDesktop ? 40 : 25),
        Wrap(
          spacing: spacing,
          runSpacing: spacing,
          alignment: WrapAlignment.center,
          children: [
            _SkillRune(name: "Data\nPreprocessing", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Data Visualization\n(Matplotlib)", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Deep\nLearning", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Machine\nLearning", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Natural Language\nProcessing", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "RAG\nGeneration", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Large Language\nModels", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "AI\nAgents", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Database Mng\nSystems", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Regular\nExpressions", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Web Scraping\nParsing", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Object Oriented\nProgramming", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Data Struct & \nAlgorithms", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "Mobile & Desktop\nApp Dev", mastery: 1, isDesktop: isDesktop, width: itemWidth),
            _SkillRune(name: "End-to-End\nDevelopment", mastery: 1, isDesktop: isDesktop, width: itemWidth),
          ],
        ),
      ],
    );
  }

  Widget _buildChroniclesSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: "The Grand Chronicles", isDesktop: isDesktop),
        SizedBox(height: isDesktop ? 40 : 25),
        _ProjectTome(
          title: "Tome I: BitSafe AI (TÜBİTAK 2209-A)",
          role: "Machine Learning and FastAPI Developer",
          description: """◦ Contributed to the AI components of a real-time, risk-based traffc analysis tool for small-scale networks, developed in Go using the BitNet model.
                          \n◦ Implemented website classifcation based on the IAB Taxonomy to categorize network traffc and enhance risk assessment capabilities.
                          \n◦ Additionally designed and deployed an effcient FastAPI service to serve the model for low-latency inference and scalable integration with the system.""",
          isDesktop: isDesktop,
        ),
        SizedBox(height: isDesktop ? 20 : 15),
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
        SizedBox(height: isDesktop ? 20 : 15),
        _ProjectTome(
          title: "Tome III: Layla - AI Based Mail Assistant",
          role: "Full Stack Developer and Architect",
          description: """◦ Developed a Flutter mobile app to manage Gmail accounts via Google OAuth2.
                          \n◦ Implemented features include full-text email search, a Gemini-powered chatbot, intelligent email header classifcation, and OCR-based document scanning.
                          \n◦ Demonstrates skills in mobile development, NLP, and API integration.""",
          isDesktop: isDesktop,
        ),
        SizedBox(height: isDesktop ? 20 : 15),
        _ProjectTome(
          title: "Tome IV: NeuroLoop",
          role: "Full Stack Developer and Architect",
          description: """◦ Developed a Flutter desktop app for educational use, featuring personalized Qdrant vector databases for each user.
                          \n◦ Implemented a Gemini-powered RAG system for natural language Q&A, and automated quiz generation with categorized question storage for effcient retrieval.""",
          isDesktop: isDesktop,
        ),
        SizedBox(height: isDesktop ? 20 : 15),
        _ProjectTome(
          title: "Tome V: Travelogue",
          role: "Co-Contributor and Java Android Developer",
          description: """◦ Developed Travelogue, a mobile travel journal application that enables users to document trips, visualize visited locations on an interactive map, and plan future travels through goal tracking and personalized features.
                          \n◦ Built and managed core features including trip journaling (add/edit/view travels), user authentication, settings, and travel detail modules, while contributing to UI components and overall application logic using Java and Android development principles.""",
          isDesktop: isDesktop,
        ),
        SizedBox(height: isDesktop ? 20 : 15),
        _ProjectTome(
          title: "Tome VI: DejaView",
          role: "Co-Contributor and Machine Learning Developer",
          description: """◦ Clustered Turkish historical texts using SBERT, TF-IDF, and BERTurk with algorithms like KMeans, GMM, and OPTICS; benchmarked clustering performance.""",
          isDesktop: isDesktop,
        ),
        SizedBox(height: isDesktop ? 20 : 15),
        _ProjectTome(
          title: "Tome VII: AI Car Game",
          role: "Full Stack Python Developer",
          description: """◦  Developed a car game using Pygame, and implemented AI agents trained with Reinforcement Learning(DQN) and rule-based algorithms.""",
          isDesktop: isDesktop,
        ),
        SizedBox(height: isDesktop ? 20 : 15),
        _ProjectTome(
          title: "Tome VIII: Smart Path Finder",
          role: "Full Stack Developer",
          description: """◦  Developed and visualized a pathfnding system using A* and Dijkstra’s algorithms, integrated with Leaﬂet.js for interactive mapping, served via Flask, and built with HTML, CSS, and JavaScript.""",
          isDesktop: isDesktop,
        ),
      ],
    );
  }

  Widget _buildGuildRecordsSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: "Educational Guild Records", isDesktop: isDesktop),
        SizedBox(height: isDesktop ? 40 : 25),
        _TimelineNode(
          year: "BSc in Computer Engineering",
          title: "Muğla Sıtkı Koçman University",
          subtitle: "Sep 2021 - Jun 2026",
          description: "GPA : 3.50",
          isLast: false,
          isDesktop: isDesktop,
        ),
      ],
    );
  }

  Widget _buildApprenticeshipSection(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: "Apprenticeship Records", isDesktop: isDesktop),
        SizedBox(height: isDesktop ? 40 : 25),
        _TimelineNode(
          year: "Software Engineer Intern",
          title: "Iceberg Digital",
          subtitle: "Jun 2026 - Present | Essex, UK",
          description: "Ongoing.",
          isLast: false,
          isDesktop: isDesktop,
        ),
        _TimelineNode(
          year: "Artificial Intelligence Intern",
          title: "MAVA",
          subtitle: "Jun 2025 - Aug 2025 | Muğla, Turkey",
          description: "Developed a recommendation system by scraping data from a dynamic e-commerce platform and leveraging product categories for predictive modeling. Experimented with multiple approaches, including Logistic Regression with TF-IDF, LSTM, GRU, and fne-tuned BERTurk. Trained the models and containerized both the models and the OpenSearch database using Docker, resolving dependency issues and ensuring scalability. Designed and implemented an innovative web interface using HTML/CSS, and built a chatbot service powered by Gemini API and Flask, seamlessly integrated into the interface.",
          isLast: false,
          isDesktop: isDesktop,
        ),
        _TimelineNode(
          year: "Data Science Intern",
          title: "Virtus R&D Software Inc.",
          subtitle: "May 2024 - Oct 2024 | Muğla, Turkey",
          description: "Developed Python scripts for data collection, preprocessing, and structuring, leveraging mathematical approaches to clean and organize CSV fles. Worked on medical image processing using TensorFlow, focusing on deep learning-based analysis. Experienced in data mining, automation, and building effcient pipelines for data organization and analysis.",
          isLast: false,
          isDesktop: isDesktop,
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final bool isDesktop;
  
  const _SectionTitle({required this.title, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.cinzel(
              fontSize: isDesktop ? 40 : 26,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFD4AF37),
              letterSpacing: isDesktop ? 3 : 1.5,
              shadows: [
                Shadow(color: Colors.black.withOpacity(0.8), offset: const Offset(3, 3), blurRadius: 6),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 2,
            width: isDesktop ? 100 : 70,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Color(0xFFD4AF37), Colors.transparent],
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
  final bool isDesktop;
  final double width;

  const _SkillRune({
    required this.name, 
    required this.mastery, 
    required this.isDesktop,
    required this.width,
  });

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
        width: widget.width,
        padding: EdgeInsets.all(widget.isDesktop ? 20 : 8),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: GoogleFonts.almendra(
                fontSize: widget.isDesktop ? 18 : 11,
                color: _isHovered ? Colors.white : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: widget.isDesktop ? 15 : 10),
            Stack(
              children: [
                Container(
                  height: widget.isDesktop ? 4 : 3,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(2)),
                ),
                AnimatedBuilder(
                  animation: _fillAnimation,
                  builder: (context, child) {
                    return FractionallySizedBox(
                      widthFactor: _fillAnimation.value,
                      child: Container(
                        height: widget.isDesktop ? 4 : 3,
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
              size: isDesktop ? 200 : 120,
              color: const Color(0xFFD4AF37).withOpacity(0.03), 
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Padding(
              padding: EdgeInsets.all(isDesktop ? 40.0 : 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.cinzel(
                      fontSize: isDesktop ? 36 : 22,
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
                      fontSize: isDesktop ? 20 : 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.white54,
                    ),
                  ),
                  SizedBox(height: isDesktop ? 20 : 15),
                  Container(
                    height: 1,
                    width: isDesktop ? 200 : 120,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFD4AF37).withOpacity(0.5),
                          Colors.transparent
                        ],
                      ),
                    ),
                  ),             
                  SizedBox(height: isDesktop ? 25 : 15),
                  Text(
                    description,
                    style: GoogleFonts.almendra(
                      fontSize: isDesktop ? 19 : 15,
                      color: Colors.white70,
                      height: isDesktop ? 1.7 : 1.5,
                      letterSpacing: isDesktop ? 1.1 : 1.0,
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
  final bool isDesktop;

  const _TimelineNode({
    required this.year,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.isLast,
    required this.isDesktop,
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
                width: isDesktop ? 20 : 16,
                height: isDesktop ? 20 : 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  border: Border.all(color: const Color(0xFFD4AF37), width: isDesktop ? 3 : 2),
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
          SizedBox(width: isDesktop ? 30 : 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isDesktop ? 50.0 : 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(year, style: GoogleFonts.cinzel(fontSize: isDesktop ? 20 : 16, color: const Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(title, style: GoogleFonts.cinzel(fontSize: isDesktop ? 24 : 18, color: Colors.white)),
                  const SizedBox(height: 5),
                  Text(subtitle, style: GoogleFonts.almendra(fontSize: isDesktop ? 18 : 14, color: Colors.white54, fontStyle: FontStyle.italic)),
                  SizedBox(height: isDesktop ? 15 : 10),
                  Text(description, style: GoogleFonts.almendra(fontSize: isDesktop ? 18 : 15, color: Colors.white70, height: isDesktop ? 1.5 : 1.4)),
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
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 20, vertical: isDesktop ? 15 : 10),
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0xFFD4AF37).withOpacity(0.1) : Colors.black.withOpacity(0.8),
            border: Border.all(color: const Color(0xFFD4AF37), width: _isHovered ? 2 : 1),
            borderRadius: BorderRadius.circular(4),
            boxShadow: _isHovered ? [BoxShadow(color: const Color(0xFFD4AF37).withOpacity(0.3), blurRadius: 10)] : [],
          ),
          child: Text(
            widget.text,
            style: GoogleFonts.cinzel(
              fontSize: isDesktop ? 22 : 16,
              color: _isHovered ? Colors.white : const Color(0xFFD4AF37),
              fontWeight: FontWeight.bold,
              letterSpacing: isDesktop ? 2 : 1,
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
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 900;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isDesktop ? 80.0 : 40.0),
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
    
    final path = Path()
      ..moveTo(center.dx, center.dy - 10)
      ..lineTo(center.dx + 10, center.dy)
      ..lineTo(center.dx, center.dy + 10)
      ..lineTo(center.dx - 10, center.dy)
      ..close();
    canvas.drawPath(path, paint);

    canvas.drawLine(Offset(0, center.dy), Offset(center.dx - 20, center.dy), paint);
    
    canvas.drawLine(Offset(center.dx + 20, center.dy), Offset(size.width, center.dy), paint);

    final dotPaint = Paint()..color = const Color(0xFFD4AF37).withOpacity(0.8);
    canvas.drawCircle(Offset(10, center.dy), 3, dotPaint);
    canvas.drawCircle(Offset(size.width - 10, center.dy), 3, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}