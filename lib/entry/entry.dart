import 'package:flutter/material.dart';
import 'package:jogi_hackathon/data_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Provider Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DataTestScreen(),
    );
  }
}

class DataTestScreen extends StatefulWidget {
  const DataTestScreen({super.key});

  @override
  State<DataTestScreen> createState() => _DataTestScreenState();
}

class _DataTestScreenState extends State<DataTestScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await DataProvider.fetchImageUrls();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Provider Test'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: DataProvider.imageUrls.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(DataProvider.imageUrls[index]),
                  title: Text('Image $index'),
                );
              },
            ),
    );
  }
}
