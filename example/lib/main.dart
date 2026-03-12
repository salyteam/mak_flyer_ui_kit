import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mak_flyer_ui_kit/mak_flyer_ui_kit.dart';
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
      builder: (context, child) => MFTheme(storage: sharedPref, child: child!),
      home: const MyApp(),
    ),
  );
}

Brightness? getInitBrightness(SharedPreferences sharedPref) {
  final value = sharedPref.getInt("color_theme");
  if (value == null) return null;
  return Brightness.values[value];
}

class CityModel implements MFDropdownMenuItem {
  CityModel(this.menuId, this.name);

  @override
  final int menuId;
  final String name;

  @override
  String get title => name;
}

class Anatoliy implements MFDropdownMenuItem {
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
    bool option1IsActive = false;
    bool option2IsActive = false;

    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 20,
          children: [
            MFDropdownMenu<Anatoliy>(initValue: cities.first, items: cities, onChange: (value) {}),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 8,
              children: [
                MFIconButton.primary(icon: Icon(Icons.check), onTap: () {}),
                MFIconButton.secondary(icon: Icon(Icons.close), size: MFIconButtonSize.small),
                MFIconButton.ghost(icon: Icon(Icons.visibility_off), onTap: () {}, size: MFIconButtonSize.superSmall),
                MFIconButton.custom(icon: Icon(Icons.add), backgroundColor: Colors.green, onTap: () {}),
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 12,
                children: [
                  StatefulBuilder(
                    builder: (context, setState) => MFRadioOption(
                      title: "Nothing",
                      onTap: () => setState(() => option1IsActive = !option1IsActive),
                      isActive: option1IsActive,
                    ),
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => MFRadioOption(
                      title: "Ramen",
                      emoji: "🍜",
                      onTap: () => setState(() => option2IsActive = !option2IsActive),
                      isActive: option2IsActive,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 12,
                children: [
                  MFOptionButton.link(title: "Option 1", onTap: () {}),
                  MFOptionButton.switcher(title: "Option 2", value: false, onChange: (value) {}),
                ],
              ),
            ),

            MFLikeButton(initValue: false, size: 100),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MFTextInput(hintText: "Some text", suffixIconAsset: MFAssets.icons.user),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(child: Text("Color theme", style: context.fonts.h5)),
                  MFSwitcher(value: false, onChange: (value) => MFTheme.of(context).changeTheme()),
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
                        onTap: () => debugPrint('asdfas'),
                        description:
                            "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore ma",
                        sale: 50,
                        name: "Lorem ipsum",
                        onFavoriteChange: (value) => debugPrint("value $value"),
                        onFavoriteTap: () => debugPrint('Tap'),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MFButton.primary(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CardsListScreen())),
                isDestructive: true,
                title: "Button",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final class CardsListScreen extends StatelessWidget {
  const CardsListScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemBuilder: (c, i) => MFCategoryChip(
                onTap: () {},
                opacity: 1,
                title: "Name",
                leading: Text("📱"),
                mainAxisAlignment: MainAxisAlignment.center,
                isActive: false,
              ),
              separatorBuilder: (c, i) => const SizedBox(width: 10),
              itemCount: 10,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (c, i) => DiscountCard(
                name: "Магнит",
                imgBackground:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzjQUSQzSfQuxWGk_Lw2HSU8GUuTPl-jCPfA&s",
                description:
                    "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita ka",
                onMoreTap: () => debugPrint("Hello"),
              ),
              separatorBuilder: (c, i) => const SizedBox(height: 10),
              itemCount: 10,
            ),
          ),
        ],
      ),
    ),
  );
}
