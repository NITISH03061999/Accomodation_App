import 'package:accomodation/screens/manage_Rooms.dart';
import 'package:accomodation/screens/Add_Property.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the primary Firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize the secondary Firebase app (optional)
  // var secondaryApp = await Firebase.initializeApp(
  //   name: 'secondaryapp',
  //   options: const FirebaseOptions(
  //     apiKey: "AIzaSyAHsDsqmvVGj0zwvDQaVBt77l2Is2iQUzw",
  //     appId: "1:980107544854:android:c3fa31b30c066febb26837",
  //     messagingSenderId: "980107544854",
  //     projectId: "hdc-dev-9202b",
  //   ),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accommodation App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ACCOMMODATION APP'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Accommodation App'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ManagerRooms()),
            );
          },
        ),
      ),
      body: const Center(
        child: Text(
          'Press + button to add any property.',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
