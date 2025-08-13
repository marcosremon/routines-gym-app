// ignore_for_file: unnecessary_underscores

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/screens/home/training/add_routine_screen.dart';
import 'package:routines_gym_app/presentation/widgets/buttons/custom_filled_button.dart';
import 'package:routines_gym_app/presentation/widgets/cards/training_stats/training_stats_card.dart';
import 'package:routines_gym_app/provider/routine/routine_provider.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final RoutineProvider routineProvider = RoutineProvider();
  List<int> counts = [0, 0, 0];

  final List<Map<String, dynamic>> _trainingStats = [
    {
      'iconPath': 'assets/icons/routine_calendar_icon.png',
      'label': 'Routines Counter',
    },
    {
      'iconPath': 'assets/icons/exercise_icon.png',
      'label': 'Exercises Counter',
    },
    {
      'iconPath': 'assets/icons/split_day_icon.png',
      'label': 'Splits  Counter',
    },
  ];

  @override
  void initState() {
    super.initState();
    _fetchCounts();
  }

  Future<void> _fetchCounts() async {
    try {
      final response = await routineProvider.getRoutineStats();
      setState(() {
        counts = [
          response.routinesCount ?? 0,
          response.exercisesCount ?? 0,
          response.splitsCount ?? 0,
        ];
      });
    } catch (ex) {
      if (kDebugMode) {
        print('Error fetching stats: $ex');
      }
      setState(() {
        counts = List.filled(_trainingStats.length, 0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorThemes[17],
      appBar: _appBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _DecorationInitialIconBox(),
            const SizedBox(height: 25),

            _ScrollCards(
              trainingStats: _trainingStats,
              counts: counts,
            ),
            const SizedBox(height: 25),

            CustomFilledButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddRoutineScreen(),
                  ),
                );
                _fetchCounts(); 
              },
              backgroundColor: colorThemes[16],
              textColor: colorThemes[9],
              label: "+ Add New Routine",
            ),
            const SizedBox(height: 25),

            _DecorationEndIconBox(),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Training'),
      titleTextStyle: TextStyle(
        color: colorThemes[10],
        fontSize: 27,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: colorThemes[17],
      elevation: 0,
    );
  }
}

class _DecorationInitialIconBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: colorThemes[16],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Center(
        child: ImageIcon(
          AssetImage('assets/icons/training_icon.png'),
          size: 130,
        ),
      ),
    );
  }
}

class _ScrollCards extends StatelessWidget {
  const _ScrollCards({
    required this.trainingStats,
    required this.counts,
  });

  final List<Map<String, dynamic>> trainingStats;
  final List<int> counts;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: trainingStats.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final stat = trainingStats[index];
          final count = (index < counts.length) ? counts[index] : 0;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.5),
            child: SizedBox(
              width: 225,
              child: TrainingStatCard(
                icon: ImageIcon(
                  AssetImage(stat['iconPath']),
                  size: 28,
                  color: colorThemes[10],
                ),
                label: stat['label'],
                count: count,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DecorationEndIconBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorThemes[16],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(
            Icons.lightbulb_outline,
            size: 40,
            color: colorThemes[9],
          ),
          const SizedBox(height: 12),
          Text(
            'Did you know that you can customize your routines and add your own exercises?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: colorThemes[9]),
          ),
        ],
      ),
    );
  }
}