import 'package:flutter/material.dart';
import 'package:flutter_lightbox/flutter_lightbox.dart';
import 'package:flutter_lightbox/image_type.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter LightBox Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter LightBox Demo'),
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
  final List<String> images = [
    'https://picsum.photos/250?image=10',
    'https://picsum.photos/250?image=13',
    'https://picsum.photos/250?image=15',
  ];

  final List<String> assetImages = [
    'assets/images/pikachu_1.png',
    'assets/images/pikachu_2.png',
    'assets/images/pikachu_3.png',
  ];

  Widget buildImageList(List<String> images, ImageType imageType) {
    return SizedBox(
      height: 85,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              showGeneralDialog(
                context: context,
                pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
                  return LightBox(
                    initialIndex: index,
                    images: images,
                    imageType: imageType,
                  );
                },
              );
            },
            child: Container(
              width: 70,
              height: 65,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(246, 246, 246, 1),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: imageType == ImageType.network
                    ? Image.network(images[index])
                    : Image.asset(images[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text("Network Images Example"),
            buildImageList(images, ImageType.network),
            const SizedBox(
              height: 30,
            ),
            const Text("Asset Images Example"),
            buildImageList(assetImages, ImageType.imageAsset),
            const Text("")
          ],
        ),
      ),
    );
  }
}
