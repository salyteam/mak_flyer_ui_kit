import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saly_ui_kit/saly_ui_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPref = await SharedPreferences.getInstance();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.green, // Set the status bar's background to transparent
      statusBarIconBrightness: Brightness.dark, // Use dark icons on a light background
      statusBarBrightness: Brightness.light, // For iOS, use a light status bar
    ),
  );

  runApp(
    MaterialApp(
      builder: (context, child) {
        return SalyTheme(storage: sharedPref, child: child!);
      },
      home: const MyApp(),
    ),
  );
}

Brightness? getInitBrightness(SharedPreferences sharedPref) {
  final value = sharedPref.getInt("color_theme");
  if (value == null) return null;
  return Brightness.values[value];
}

class CityModel implements SalyDropDownMenuItem {
  CityModel(this.menuId, this.name);

  @override
  final int menuId;
  final String name;

  @override
  String get title => name;
}

class Anatoliy implements SalyDropDownMenuItem {
  @override
  int get menuId => 1;

  @override
  String get title => "";
}

final cities = List.generate((15), (i) => CityModel(i, "City name: $i"));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 20,
          children: [
            SalyDropDownMenu<Anatoliy>(initValue: cities.first, items: cities, onChange: (value) {}),

            SalyLikeButton(initValue: false, size: 100),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SalyTextInput(hintText: "Some text", suffixIconAsset: SalyAssets.icons.user),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: Text("Color theme", style: context.fonts.h5)),
                  SalySwitcher(
                    value: false,
                    onChange: (valur) {
                      SalyTheme.of(context).changeTheme();
                    },
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  spacing: 10,
                  children: [
                    for (int i = 0; i < 5; i++)
                      DiscountCard(
                        onTap: () {
                          print('asdfas');
                        },
                        description:
                            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore ma",
                        sale: 50,
                        name: "Lorem ipsum",
                        onFavoriteChange: (value) {
                          print("value $value");
                        },

                        onFavoriteTap: () {
                          print('Tap');
                        },
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SalyButton.primary(onTap: () {}, title: "Button"),
            ),
          ],
        ),
      ),
    );
  }
}
