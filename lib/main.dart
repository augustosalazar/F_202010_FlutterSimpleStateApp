import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// esta es una modificación de la app básica de Flutter usando un estado a nivel de toda la APP
// y no solo a nivel de un Widget
// para poder tener acceso a las clases del Provider hay que añadir la siguiente linea en en pubspec.yaml
// dependencies:
//   flutter:
//     sdk: flutter
//   provider: ^3.0.0    <<-----  new  
// ejemplo tomado de https://github.com/flutter/samples/tree/master/provider_counter

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}


class Counter with ChangeNotifier {  // implementa un Observer al que se puede subscribir 
  int value = 0;

  void increment() {
    value += 1;
    notifyListeners();  // aquí se notifica a todos los listeners que hay un cambio de estado
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {  // este Widget ya puede ser Stateless
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Consumer<Counter>(  // aquí nos subscribimos a los cambios de la clase Counter
              builder: (context, counter, child) => 
                Text('${counter.value}',style: Theme.of(context).textTheme.display1,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
           // aquí cambiamos el estado de la App almacenado en la clase Counter
           // con el false declaramos que este sub widget no necesita ser reconstruido con el cambio de estado
            Provider.of<Counter>(context, listen: false).increment(),  
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}