import 'package:download_to_optional_folder/save_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pdf download Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'File Dialog Demo'),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final urlController = useTextEditingController();
    final fileNameController = useTextEditingController(); // Add this line

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: 'Enter URL',
              ),
            ),
            TextField(
              // Add this block
              controller: fileNameController,
              decoration: const InputDecoration(
                labelText: 'Enter File Name',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final url = urlController.text;
                final fileName = fileNameController.text;
                final isSuccessful = await savePdfFile(url, fileName);
                if (!isSuccessful && context.mounted) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Failed to Download'),
                        content: const Text('Failed to download the file.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
