import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:counterapp/counter.dart';

void main() {
  runApp(
    // DON'T FORGET *ProviderScope*!!
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
//                         Consumer in StatefulWidget                         //
////////////////////////////////////////////////////////////////////////////////
class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, ScopedReader watch, Widget? child) {
      final int counter = watch(counterProvider);
      final Counter counterNotifier = watch(counterProvider.notifier);

      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$counter',
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: counterNotifier.increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}

// ////////////////////////////////////////////////////////////////////////////////
// //                               ConsumerWidget                               //
// ////////////////////////////////////////////////////////////////////////////////
// class MyHomePage extends ConsumerWidget {
//   const MyHomePage({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   final String title;

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final int counter = watch(counterProvider);
//     final Counter counterNotifier = watch(counterProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: counterNotifier.increment,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
