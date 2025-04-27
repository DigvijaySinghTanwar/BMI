import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Body Mass Index',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _sizeAnimation = Tween<double>(begin: 50, end: 120).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI App'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF87CEEB),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.withOpacity(0.4),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: AnimatedBuilder(
                      animation: _sizeAnimation,
                      builder: (context, child) {
                        return Icon(
                          Icons.favorite,
                          size: _sizeAnimation.value,
                          color: Colors.pink,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              OpenContainer(
                transitionDuration: const Duration(milliseconds: 500),
                transitionType: ContainerTransitionType.fade,
                closedBuilder: (
                    BuildContext context,
                    VoidCallback openContainer,
                    ) {
                  return ElevatedButton(
                    onPressed: openContainer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      textStyle: const TextStyle(fontSize: 18),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Check BMI',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
                openBuilder: (BuildContext context, VoidCallback _) {
                  return const MyHomePage(title: 'Check Your BMI');
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HealthTipsPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Health Tips',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Stay healthy and achieve your ideal weight with our BMI app!",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final wtController = TextEditingController();
  final ftController = TextEditingController();
  final inController = TextEditingController();
  String result = "";
  Color bgColor = Colors.cyan.shade200;

  @override
  void dispose() {
    wtController.dispose();
    ftController.dispose();
    inController.dispose();
    super.dispose();
  }

  void showAlertDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI: Body Mass Index"),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7FA),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'BMI Calculator',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: wtController,
                    decoration: InputDecoration(
                      labelText: 'Weight (KG)',
                      prefixIcon:
                      const Icon(Icons.line_weight, color: Colors.pink),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.pink, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: ftController,
                    decoration: InputDecoration(
                      labelText: 'Height (Feet)',
                      prefixIcon: const Icon(Icons.height, color: Colors.pink),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.pink, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: inController,
                    decoration: InputDecoration(
                      labelText: 'Height (Inches)',
                      prefixIcon: const Icon(Icons.height, color: Colors.pink),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.pink, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      String wt = wtController.text.trim();
                      String ft = ftController.text.trim();
                      String inch = inController.text.trim();

                      if (wt.isNotEmpty && ft.isNotEmpty && inch.isNotEmpty) {
                        try {
                          double iWt = double.parse(wt);
                          int iFt = int.parse(ft);
                          int iInch = int.parse(inch);

                          int tInch = (iFt * 12) + iInch;

                          double tCm = tInch * 2.54;

                          double tM = tCm / 100;

                          double bmi = iWt / (tM * tM);

                          String msg = "";
                          if (bmi > 25 && bmi < 29.9) {
                            msg = "You are OverWeight !!";
                            bgColor = Colors.orange.shade400;
                          } else if (bmi >= 30) {
                            msg = "You are Obese !!";
                            bgColor = Colors.red.shade400;
                          } else if (bmi < 18.5) {
                            msg = "You are UnderWeight !!";
                            bgColor = Colors.red.shade200;
                          } else {
                            msg = "You are Healthy!!";
                            bgColor = Colors.green.shade500;
                          }

                          setState(() {
                            result =
                            "$msg \n Your BMI is: ${bmi.toStringAsFixed(4)}";
                          });
                        } catch (e) {
                          showAlertDialog(
                            context,
                            "Please enter valid numerical values.",
                          );
                          setState(() {
                            result = "";
                          });
                        }
                      } else {
                        setState(() {
                          result = "Please Fill all Required Blanks";
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Calculate',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HealthInsightsPage(
                            wt: wtController.text.trim(),
                            ft: ftController.text.trim(),
                            inch: inController.text.trim(),
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Health Insights',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 19, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HealthInsightsPage extends StatefulWidget {
  const HealthInsightsPage({
    super.key,
    required this.wt,
    required this.ft,
    required this.inch,
  });

  final String wt;
  final String ft;
  final String inch;

  @override
  State<HealthInsightsPage> createState() => _HealthInsightsPageState();
}

class _HealthInsightsPageState extends State<HealthInsightsPage> {
  late final TextEditingController wtController;
  late final TextEditingController ftController;
  late final TextEditingController inController;
  String healthInsights = "";
  double bmi = 0.0;
  String bmiCategory = "";
  String calorieIntakeGoal = "";
  String exerciseRecommendation = "";
  String bonusTip = "";

  @override
  void initState() {
    super.initState();
    wtController = TextEditingController(text: widget.wt);
    ftController = TextEditingController(text: widget.ft);
    inController = TextEditingController(text: widget.inch);
    calculateInitialBMI();
  }

  void calculateInitialBMI() {
    bmi = calculateBMI(widget.wt, widget.ft, widget.inch);
    updateHealthInsights();
  }

  @override
  void dispose() {
    wtController.dispose();
    ftController.dispose();
    inController.dispose();
    super.dispose();
  }

  void showAlertDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  double calculateBMI(String wt, String ft, String inch) {
    if (wt.isNotEmpty && ft.isNotEmpty && inch.isNotEmpty) {
      try {
        double iWt = double.parse(wt);
        int iFt = int.parse(ft);
        int iInch = int.parse(inch);

        int tInch = (iFt * 12) + iInch;

        double tCm = tInch * 2.54;

        double tM = tCm / 100;

        return iWt / (tM * tM);
      } catch (e) {
        return 0.0;
      }
    } else {
      return 0.0;
    }
  }

  void updateHealthInsights() {
    if (bmi > 0) {
      if (bmi < 18.5) {
        bmiCategory = "Underweight";
        calorieIntakeGoal = "Target 2500-3000 calories/day to gain weight.";
        exerciseRecommendation =
        "Focus on strength training exercises 2-3 times per week.";
        bonusTip = "Snack on nuts and seeds for extra calories!";
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        bmiCategory = "Normal weight";
        calorieIntakeGoal = "Maintain 2000-2500 calories/day for maintenance.";
        exerciseRecommendation =
        "Aim for at least 150 minutes of moderate-intensity exercise per week.";
        bonusTip = "Drink plenty of water throughout the day!";
      } else if (bmi >= 25 && bmi <= 29.9) {
        bmiCategory = "Overweight";
        calorieIntakeGoal = "Target 1500-2000 calories/day to lose weight.";
        exerciseRecommendation = "Try 30 minutes of brisk walking daily.";
        bonusTip = "Reducing sugary drinks can help you reach your goal!";
      } else {
        bmiCategory = "Obese";
        calorieIntakeGoal = "Consult a professional for a personalized plan.";
        exerciseRecommendation =
        "Start with low-impact exercises like swimming or cycling.";
        bonusTip = "Plan your meals in advance to avoid unhealthy choices!";
      }
      healthInsights = "";
    } else {
      bmiCategory = "Please enter your weight and height to calculate BMI.";
      calorieIntakeGoal = "";
      exerciseRecommendation = "";
      bonusTip = "";
      healthInsights = "Please fill all required blanks.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Insights'),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFE8F5E9),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Personalized Health Insights',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: wtController,
                decoration: const InputDecoration(
                  labelText: 'Enter Your Weight in KG',
                  prefixIcon: Icon(Icons.line_weight),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: ftController,
                decoration: const InputDecoration(
                  labelText: 'Enter your Height in FEET',
                  prefixIcon: Icon(Icons.height),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: inController,
                decoration: const InputDecoration(
                  labelText: 'Enter your Height in Inches',
                  prefixIcon: Icon(Icons.height),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  String wt = wtController.text.trim();
                  String ft = ftController.text.trim();
                  String inch = inController.text.trim();

                  bmi = calculateBMI(wt, ft, inch);
                  updateHealthInsights();
                  setState(() {});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Get Health Insights',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),
              if (bmi > 0)
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        // color: Colors.grey.withOpacity(0.3),
                        // ignore: deprecated_member_use
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "1). BMI Category Recap:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Your BMI: ${bmi.toStringAsFixed(2)} ($bmiCategory)",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "2). Calorie Intake Goal:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        calorieIntakeGoal,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "3). Exercise Recommendation:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        exerciseRecommendation,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "4). Bonus Tip:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        bonusTip,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                )
              else
                Text(
                  bmiCategory,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class HealthTipsPage extends StatefulWidget {
  const HealthTipsPage({super.key});

  @override
  State<HealthTipsPage> createState() => _HealthTipsPageState();
}

class _HealthTipsPageState extends State<HealthTipsPage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, String>> healthTips = [
    {
      'category': 'Nutrition',
      'tip': 'Eat more fiber for better digestion.',
      'learnMore': 'Fiber helps regulate blood sugar and lowers cholesterol.'
    },
    {
      'category': 'Exercise',
      'tip': 'Walk for at least 30 minutes daily.',
      'learnMore': 'Walking improves cardiovascular health and boosts mood.'
    },
    {
      'category': 'Mental Health',
      'tip': 'Practice mindfulness meditation.',
      'learnMore': 'Meditation reduces stress and improves focus.'
    },
    {
      'category': 'Hydration',
      'tip': 'Drink 8 glasses of water daily.',
      'learnMore': 'Water is essential for metabolism and skin health.'
    },
    {
      'category': 'Sleep',
      'tip': 'Get 7-8 hours of sleep each night.',
      'learnMore':
      'Adequate sleep improves cognitive function and immune system.'
    },
    {
      'category': 'Nutrition',
      'tip': 'Add protein to every meal for muscle repair.',
      'learnMore': 'Protein helps muscle repair and keeps you full longer.'
    },
    {
      'category': 'Exercise',
      'tip': 'Incorporate strength training exercises 2-3 times per week.',
      'learnMore':
      'Strength training builds muscle mass and increases metabolism.'
    },
    {
      'category': 'Mental Health',
      'tip': 'Take short breaks to stretch during the day.',
      'learnMore':
      'Stretching reduces muscle tension and improves flexibility.'
    },
    {
      'category': 'Hydration',
      'tip': 'Carry a water bottle to stay hydrated on the go.',
      'learnMore': 'Staying hydrated prevents headaches and fatigue.'
    },
    {
      'category': 'Sleep',
      'tip': 'Establish a consistent sleep schedule.',
      'learnMore': 'A regular sleep schedule improves sleep quality.'
    }
  ];

  late int currentTipIndexTimer;
  late int currentTipIndexNext;
  String detailedContentTimer = '';
  String detailedContentNext = '';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;
  Duration _timeUntilNextTip = const Duration(hours: 24);
  String get timeUntilNextTipString {
    final hours = _timeUntilNextTip.inHours;
    final minutes = _timeUntilNextTip.inMinutes % 60;
    return 'New tip in ${hours}h ${minutes}m';
  }

  @override
  void initState() {
    super.initState();
    currentTipIndexTimer = Random().nextInt(healthTips.length);
    currentTipIndexNext = Random().nextInt(healthTips.length);
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        _timeUntilNextTip = _timeUntilNextTip - const Duration(minutes: 1);
        if (_timeUntilNextTip.isNegative) {
          getNextTipTimer();
          _timeUntilNextTip = const Duration(hours: 24);
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> getDetailedContentTimer() async {
    setState(() {
      detailedContentTimer = healthTips[currentTipIndexTimer]['learnMore'] ??
          "Detailed content not available.";
    });
  }

  Future<void> getDetailedContentNext() async {
    setState(() {
      detailedContentNext = healthTips[currentTipIndexNext]['learnMore'] ??
          "Detailed content not available.";
    });
  }

  void getNextTipTimer() {
    _animationController.reset();
    setState(() {
      currentTipIndexTimer = Random().nextInt(healthTips.length);
      detailedContentTimer = '';
    });
    _animationController.forward();
  }

  void getNextTipNext() {
    _animationController.reset();
    setState(() {
      currentTipIndexNext = Random().nextInt(healthTips.length);
      detailedContentNext = '';
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Tips'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Tip of the Day',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        timeUntilNextTipString,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            Text(
                              healthTips[currentTipIndexTimer]['tip']!,
                              style: const TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.category),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'Category: ${healthTips[currentTipIndexTimer]['category']!}',
                                    style: const TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          getDetailedContentTimer();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          textStyle: const TextStyle(fontSize: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                        ),
                        child: const Text('Learn More',
                            style: TextStyle(color: Colors.white)),
                      ),
                      if (detailedContentTimer.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            detailedContentTimer,
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Extra Tip',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            Text(
                              healthTips[currentTipIndexNext]['tip']!,
                              style: const TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.category),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'Category: ${healthTips[currentTipIndexNext]['category']!}',
                                    style: const TextStyle(fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              getDetailedContentNext();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              textStyle: const TextStyle(fontSize: 16),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: const Text('Learn More',
                                style: TextStyle(color: Colors.white)),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              getNextTipNext();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              textStyle: const TextStyle(fontSize: 16),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            child: const Text('Next Tip',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      if (detailedContentNext.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            detailedContentNext,
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
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
