import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GallerySegment extends StatelessWidget {
  final String title;
  final List<dynamic> images;
  GallerySegment(this.title, this.images);

  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitFadingCube(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(decoration: BoxDecoration(color: Colors.green));
      },
    );

    showAlertDialog(BuildContext context, int index) {
      // Create AlertDialog
      AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        contentPadding: EdgeInsets.all(0),
        content: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/placeholder.jpg',
              image: images[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

      // show the dialog
      showDialog(
        barrierColor: Colors.black87,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    // return Text(title);
    return Container(
      padding: EdgeInsets.all(15.0),
      width: double.infinity,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15.0),
                child: Text(
                  '${title[0].toUpperCase()}${title.substring(1)} images',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: images.length,
                itemBuilder: (ctx, i) {
                  return Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/placeholder.jpg',
                            image: images[i],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              showAlertDialog(context, i);
                            },
                            splashColor: Colors.green,
                          ),
                        ),
                      )
                    ],
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
