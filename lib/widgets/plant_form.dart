import 'package:flutter/material.dart';

class PlantForm extends StatefulWidget {
  @override
  _PlantFormState createState() => _PlantFormState();
}

class _PlantFormState extends State<PlantForm> {
  String _nickname;
  String _commonName;
  String _imageUrl;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        titlePadding: EdgeInsets.all(0.0),
        title: Container(
          height: 200.0,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            child: _imageUrl != null
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.jpg',
                    image: _imageUrl,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/placeholder.jpg',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: "Nickname"),
              validator: (String value) {
                return value.isEmpty ? 'Please enter Nickname' : null;
              },
              onSaved: (String value) {
                _nickname = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Common Name"),
              validator: (String value) {
                return value.isEmpty ? 'Please enter Common Name' : null;
              },
              onSaved: (String value) {
                _commonName = value;
              },
            )
          ],
        ),
        actions: <Widget>[
          new TextButton(
            onPressed: () {
              // Navigator.of(context).pop();
              if (!_formKey.currentState.validate()) return;
              _formKey.currentState.save();
              _imageUrl =
                  "https://ocdn.eu/pulscms-transforms/1/npnktkqTURBXy83NDI4OWE2NDBlMWU5MTFiN2Q3YTljY2FhOWJjNzEyYy5qcGVnkpUDABTNAmzNAV2TBc0BpM0BLA";

              print(_nickname + _commonName);
              print(_imageUrl);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
