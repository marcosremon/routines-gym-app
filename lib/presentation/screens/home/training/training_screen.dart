import 'package:flutter/material.dart';
import 'package:routines_gym_app/application/data_transfer_object/interchange/routine/get_routine_stats/get_routine_stats_response.dart';
import 'package:routines_gym_app/configuration/theme/app_theme.dart';
import 'package:routines_gym_app/presentation/screens/home/training/add_routine_screen.dart';
import 'package:routines_gym_app/presentation/widgets/buttons/custom_filled_button.dart';
import 'package:routines_gym_app/presentation/widgets/cards/training_stats/training_stats_card.dart';
import 'package:routines_gym_app/provider/routine/routine_provider.dart';

class TrainingScreen extends StatelessWidget {
  TrainingScreen({super.key});

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

            _ScrollCards(trainingStats: _trainingStats),
            const SizedBox(height: 25),

            CustomFilledButton(
              onPressed: () async {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const AddRoutineScreen())
                );
              }, 
              backgroundColor: colorThemes[16], 
              textColor: colorThemes[9], // white color
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
      'label': 'Splits Counter',
    },
  ];
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

class _ScrollCards extends StatefulWidget {
  const _ScrollCards({
    required this.trainingStats,
  });

  final List<Map<String, dynamic>> trainingStats;

  @override
  State<_ScrollCards> createState() => _ScrollCardsState();
}

class _ScrollCardsState extends State<_ScrollCards> {
  final RoutineProvider routineProvider = RoutineProvider();
  List<int> counts = [];

  @override
  void initState() {
    super.initState();
    _fetchCounts();
  }

  Future<void> _fetchCounts() async {
    try {
      GetRoutineStatsResponse getRoutineStatsResponse = await routineProvider.getRoutineStats();
      
      int routineCounte = getRoutineStatsResponse.routinesCount ?? 0; 
      int exerciseCount = getRoutineStatsResponse.exercisesCount ?? 0; 
      int splitsCount = getRoutineStatsResponse.splitsCount ?? 0; 
      
      setState(() {
          counts = List<int>.from([routineCounte, exerciseCount, splitsCount]);
      });
    } catch (ex) {
      print('Error: $ex');
      setState(() {
        counts = List.filled(widget.trainingStats.length, 0);
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
              width: 225,
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