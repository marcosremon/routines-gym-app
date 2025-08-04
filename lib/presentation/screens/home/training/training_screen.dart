// ignore_for_file: deprecated_member_use, camel_case_types, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/widgets/buttons/custom_filled_button.dart';
import 'package:routines_gym_app/presentation/widgets/cards/training_stats/training_stats_card.dart';
import 'package:routines_gym_app/provider/training/training_provider.dart';

class TrainingScreen extends StatelessWidget {
  TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorThemes[9],
      appBar: _appBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _decorationInitialIconBox(),
            const SizedBox(height: 25),

            _ScrollCards(trainingStats: _trainingStats),
            const SizedBox(height: 25),

            CustomFilledButton(
              onPressed: () {
                // to_do add new routine action
              }, 
              backgroundColor: colorThemes[16], 
              textColor: colorThemes[9], // white color
              label: "+ Add New Routine",
            ),
            const SizedBox(height: 25),
            
            _decorationEndIconBox(),
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
      backgroundColor: colorThemes[9],
      elevation: 0,
    );
  }

  final List<Map<String, dynamic>> _trainingStats = [
    {
      'iconPath': 'assets/icons/routine_calendar_icon.png',
      'label': 'Routines',
    },
    {
      'iconPath': 'assets/icons/exercise_icon.png',
      'label': 'Exercises Counter',
    },
    {
      'iconPath': 'assets/icons/split_day_icon.png',
      'label': 'Splits Counter',
    },
  ];
}

class _decorationInitialIconBox extends StatelessWidget {
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

class _ScrollCards extends StatefulWidget {
  const _ScrollCards({
    required this.trainingStats,
  });

  final List<Map<String, dynamic>> trainingStats;

  @override
  State<_ScrollCards> createState() => _ScrollCardsState();
}

class _ScrollCardsState extends State<_ScrollCards> {
  final TrainingProvider trainingProvider = TrainingProvider();
  List<int> counts = [];

  @override
  void initState() {
    super.initState();
    _fetchCounts();
  }

  Future<void> _fetchCounts() async {
    try {
      final response = await trainingProvider.trainingStats();

      if (response.statusCode == 200) {
        List<int> data = [response.routineCount, response.exerciseCount, response.splitDayCount];
        setState(() {
          counts = List<int>.from(data);
        });
      } else {
        throw Exception('Error al obtener datos');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        counts = List.filled(widget.trainingStats.length, 0); // fallback
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.trainingStats.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final stat = widget.trainingStats[index];
          final count = (index < counts.length) ? counts[index] : 0;

          return Padding(
            padding: const EdgeInsets.fromLTRB(1.5, 0, 1.5, 0),
            child: SizedBox(
              width: 200,
              child: TrainingStatCard(
                icon: ImageIcon(
                  AssetImage(stat['iconPath']),
                  size: 28,
                  color: colorThemes[10],
                ),
                label: stat['label'],
                initialCount: count,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _decorationEndIconBox extends StatelessWidget {
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
            '¿Sabías que puedes personalizar tus rutinas y añadir tus propios ejercicios?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: colorThemes[9]),
          ),
        ],
      ),
    );
  }
}