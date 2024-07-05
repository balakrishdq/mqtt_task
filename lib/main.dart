import 'imports/index.dart';

void main() {
  runApp(const MyApp());
}

Future<void> _initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Style.colors.primary,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Style.colors.transparent,
      systemNavigationBarColor: Style.colors.white,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Mqtt',
        theme: appThemeData,
        home: HomePage(),
      ),
    );
  }
}
