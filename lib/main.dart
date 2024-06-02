import 'package:extension_tech_task_app/presentation/view/splash/screens/splash_screen.dart';
import 'package:extension_tech_task_app/presentation/view_model/home_view_model.dart';
import 'package:extension_tech_task_app/utils/helper.dart';
import 'package:extension_tech_task_app/utils/routes/route_generator.dart';
import 'package:extension_tech_task_app/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefHelper.initSharedPref();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => HomeViewModel())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: Routes.splashScreen,
      ),
    );
  }
}
