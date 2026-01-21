import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //do the  provider.of (context) to get the model and use other class,use other .dart ,we need this for rev
    return ChangeNotifierProvider(
        create: (context) => Model(),
        child: MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                title: const Text('Home Page'),
              ),
              body: ListView(
                children: [
                  Column(
                    children: [
                      //The 1st Consumer
                      Selector<Model, int>(
                          selector: (context, modelS) => modelS.text1,
                          builder: (context, model, child) {
                            print("the text widget1 is rebuilt");
                            return Text(
                              {model}.toString(),
                              style: const TextStyle(fontSize: 20),
                            );
                          }),

                      Selector<Model, String>(
                          selector: (context, modelS) => modelS.text2,
                          builder: (context, model, child) {
                            print("the text widget2 is rebuilt");
                            return Text(
                              model,
                              style: const TextStyle(fontSize: 20),
                            );
                          }),

                      Consumer<Model>(builder: (context, model, child) {
                        print("the button widget1 is rebuilt");
                        return ElevatedButton(
                          onPressed: () {
                            model.changeText1();
                          },
                          child: const Text('Press'),
                        );
                      }),

                      Consumer<Model>(builder: (context, model, child) {
                        print("the button widget2 is rebuilt");
                        return ElevatedButton(
                          onPressed: () {
                            model.changeText2();
                          },
                          child: const Text('Press'),
                        );
                      }),
                    ],
                  ),
                ],
              )),
        ));
  }
}

class Model extends ChangeNotifier {
  var text1 = 1;
  String text2 = "INELEC Student";
  get changtext1 => text1;
  get changtext2 => text2;
  void changeText1() {
    text1++;
    notifyListeners();
  }

  void changeText2() {
    text2 = "Computer Engineer";
    notifyListeners();
  }
}
