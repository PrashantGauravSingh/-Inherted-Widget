import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'inherited_provider.dart';

import 'data.dart';

class InheritedGenericPage extends StatefulWidget {
  @override
  InheritedPageState createState() {
    return new InheritedPageState();
  }
}

class InheritedPageState extends State<InheritedGenericPage> {
  final data = Data(
      counter: 1,
      dateTime: DateFormat("dd/MM/yyyy - HH:mm:ss:S").format(DateTime.now()),
      text: "Lorem ipsum");

  int rebuilding = 0;

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    rebuilding += 1;

    textController.text = data.text;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Inherited'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text('NWidget re-builds: $rebuilding',
                style: TextStyle(fontWeight: FontWeight.w700)),
            Container(
                height: 60.0,
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'Data from the parent widget propagates along the tree:',
                    style: TextStyle(fontWeight: FontWeight.w700))),
            Container(height: 12.0),
            TextField(
              controller: textController,
              decoration: InputDecoration(
                  labelText: 'Text',
                  hintText: 'Insert some text',
                  border: OutlineInputBorder()),
              onSubmitted: (text) {
                setState(() {
                  data.text = text;
                });
              },
            ),
            RaisedButton(
              child: Text('Second page'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InheritedProvider<Data>(
                              child: SecondPage(),
                              inheritedData: data,
                            )));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = InheritedProvider.of<Data>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Second page'),
      ),
      body: Container(
        padding: EdgeInsets.all(12.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text('${data.text}'),
          ],
        ),
      ),
    );
  }
}
