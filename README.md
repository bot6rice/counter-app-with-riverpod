# Counter App with Riverpod ^0.14

This project guides you how to use riverpod ^0.14, which is totally different from ^0.13.

**We use flutter_riverpod, not hooks_riverpod.**

## Riverpod ^0.14

The second argument for Consumer.build method is no longer `WidgetRef ref`.

(And we used to use `ref.watch()` or `ref.read()`.)

Instead it is `ScopedReader watch` in the version 0.14. 

```dart
return Consumer(builder: (BuildContext context, ScopedReader watch, Widget? child) {
  final int counter = watch(counterProvider);
  final Counter counterNotifier = watch(counterProvider.notifier);
  // So if you want to call the method of Counter, you just do like this.
  // counterNotifier.increment();

  return SomeWidget(...);
```

If you don't add type parameters to `stateNotifierProvider`, you'll get an error for `watch(counterProvider)`.

```dart:lib/counter.dart
// This will cause an error.
final counterProvider = StateNotifierProvider((ref) {
  return Counter();
});

// Add type parametes.
final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});

class Counter extends StateNotifier<int> {
  Counter() : super(0);

  void increment() => state++;
}
```

- Ref
  - [^0.13.0 to ^0.14.0](https://riverpod.dev/docs/migration/0.13.0_to_0.14.0/)

## Consumer VS ConsumerWidget

Cosumer fits in both StatefulWidgets and StatelessWidgets.

But if your StatefulWidget with Consumer is stateless other than the states, you can use ConsumerWidget.

Yes, ConsumerWidget implements StatelessWidget.

We'll dive into this by looking at the two cases.

- Ref
  - [Consumer class](https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/Consumer-class.html)
  - [ConsumerWidget class](https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/ConsumerWidget-class.html)


### Consumer

First we try to implement the app with StatefulWidget and Consumer.

(When you first create a flutter app, you'll see a StatefulWidget.)

The code will look like this.

```dart:lib/main.dart
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
```

### ConsumerWidget

Next up, we try to convert the code above to ConsumerWidget.

Looking at the code, you'll notice that the `MyHomePage` widget looks like a Stateless widget.

(It's because we don't have any statefull properties.)

Yes! It's ConsumerWidget time!! We can replace the code above with ConsumerWidget.

```dart:lib/main.dart
class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final int counter = watch(counterProvider);
    final Counter counterNotifier = watch(counterProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterNotifier.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
```
