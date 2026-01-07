import 'package:flutter/material.dart';
import 'package:mock_mart/features/animation/widgets/animation_section_widget.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({Key? key}) : super(key: key);

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  bool _toggled = false;

  void _toggle() {
    setState(() {
      _toggled = !_toggled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animations'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // AnimatedAlign
            AnimationSectionWidget(
              title: 'AnimatedAlign',
              child: SizedBox(
                height: 150,
                child: AnimatedAlign(
                  alignment: _toggled
                      ? Alignment.topRight
                      : Alignment.bottomLeft,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.star, color: Colors.white),
                  ),
                ),
              ),
            ),


            // AnimatedContainer
            AnimationSectionWidget(
              title: 'AnimatedContainer',
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                width: _toggled ? 200 : 100,
                height: _toggled ? 100 : 200,
                decoration: BoxDecoration(
                  color: _toggled ? Colors.green : Colors.orange,
                  borderRadius: BorderRadius.circular(_toggled ? 50 : 8),
                ),
                child: const Center(
                  child: Icon(Icons.favorite, color: Colors.white, size: 32),
                ),
              ),
            ),


            // AnimatedDefaultTextStyle
            AnimationSectionWidget(
              title: 'AnimatedDefaultTextStyle',
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                style: TextStyle(
                  fontSize: _toggled ? 32 : 16,
                  fontWeight: _toggled ? FontWeight.bold : FontWeight.normal,
                  color: _toggled ? Colors.purple : Colors.blue,
                ),
                child: const Text('Animated Text Style'),
              ),
            ),

            // AnimatedFractionallySizedBox
            AnimationSectionWidget(
              title: 'AnimatedFractionallySizedBox',
             child: SizedBox(
                height: 100,
                child: AnimatedFractionallySizedBox(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  widthFactor: _toggled ? 0.9 : 0.3,
                  heightFactor: _toggled ? 0.8 : 0.5,
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Icon(Icons.crop, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),

            // AnimatedOpacity
            AnimationSectionWidget(
             title: 'AnimatedOpacity',
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                opacity: _toggled ? 1.0 : 0.2,
                child: Container(
                  width: 150,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Fade In/Out',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),

            // AnimatedPadding
            AnimationSectionWidget(
              title: 'AnimatedPadding',
              child: Container(
                color: Colors.grey[200],
                child: AnimatedPadding(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(_toggled ? 40 : 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Padding Changes',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // AnimatedPositioned
            AnimationSectionWidget(
             title: 'AnimatedPositioned',
             child: SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      left: _toggled ? 200 : 20,
                      top: _toggled ? 120 : 20,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.navigation, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // AnimatedRotation
            AnimationSectionWidget(
              title: 'AnimatedRotation',
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                turns: _toggled ? 1 : 0,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.refresh, color: Colors.white, size: 40),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _toggle,
        icon: const Icon(Icons.play_arrow),
        label: const Text('Toggle Animations'),
      ),
    );
  }
}