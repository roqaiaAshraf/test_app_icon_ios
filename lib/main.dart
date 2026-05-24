import 'package:flutter/material.dart';
import 'package:test_app_icon_ios/service/dynamic_icon_service.dart';

void main() {
  runApp(const MyApp());
}

enum IOSAppIcons {
  backToSchoolIcon('BackToSchool'),
  defaultIcon('AppIcon'),
  spring('Spring');

  final String appIcon;
  const IOSAppIcons(this.appIcon);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currentIcon = 'Default';

  @override
  void initState() {
    super.initState();
    _loadCurrentIcon();
  }

  Future<void> _loadCurrentIcon() async {
    final iconName = await DynamicIconService.getCurrentIcon();

    if (mounted) {
      setState(() {
        _currentIcon = iconName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary),
      body: Column(
        children: [
          Center(child: Text('Current icon: $_currentIcon')),
          FloatingActionButton(
            onPressed: () async {
              await DynamicIconService.setIcon(iconName: IOSAppIcons.spring.appIcon);
            },
            child: Text('Spring Icon', style: TextStyle(color: Colors.blue)),
          ),
          FloatingActionButton(
            onPressed: () async {
              await DynamicIconService.setIcon(iconName: IOSAppIcons.backToSchoolIcon.appIcon);
            },
            child: Text('back to school Icon', style: TextStyle(color: Colors.blue)),
          ),
          FloatingActionButton(
            onPressed: () async {
              await DynamicIconService.setIcon(iconName: IOSAppIcons.defaultIcon.appIcon);
            },
            child: Text('default Icon', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }
}
