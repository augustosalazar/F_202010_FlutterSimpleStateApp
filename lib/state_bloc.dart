import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MyEvent { increment }

class SimpleBlocState extends Bloc<MyEvent, int> {
  SimpleBlocState() : super(0);

  Stream<int> mapEventToState(MyEvent event) async* {
    switch (event) {
      case MyEvent.increment:
        int t = state + 1;
        yield t;
        break;
    }
  }
}

class MyAppBloc extends StatefulWidget {
  MyAppBloc({Key key}) : super(key: key);

  @override
  _MyAppBlocState createState() => _MyAppBlocState();
}

class _MyAppBlocState extends State<MyAppBloc> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SimpleBlocState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter with BLoC',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SimpleBlocState bloc = BlocProvider.of<SimpleBlocState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter with BLoC'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            BlocBuilder<SimpleBlocState, int>(
                builder: (context, state) => Text(
                      '$state',
                      style: Theme.of(context).textTheme.headline1,
                    )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.add(MyEvent.increment),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
