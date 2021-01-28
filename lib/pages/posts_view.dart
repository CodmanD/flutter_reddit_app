import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission/permission.dart';
import 'package:toast/toast.dart';

class PostView extends StatelessWidget {
  final String url;

  // final BuildContext context;
  BuildContext _context;

  PostView({Key key, this.url}) : super(key: key);

  void onTapBottomBar(int index) {
    switch (index) {
      case 0:
        _downLoadImage(url);
        break;
      case 1:
        Navigator.pop(_context);
        break;
    }
  }

  Future<bool> _requestPermission() async {
    PermissionName permissionName = PermissionName.Storage;

    List<PermissionName> list = List<PermissionName>();

    list.add(permissionName);

    var permissions = await Permission.requestPermissions(list);

    if (permissions[0].permissionStatus == PermissionStatus.allow) return true;
    return false;
  }

  _downLoadImage(String url) async {
    if (!await _requestPermission()) return;

    var appDir = await getTemporaryDirectory();

    String fileUrl = url.replaceAll('amp;', '');
    String savePath = appDir.path +
        url.replaceFirst('https://preview.redd.it/', "/").split("?")[0];
    var x = await Dio().download(fileUrl, savePath);

    final result = await ImageGallerySaver.saveFile(savePath);

    Toast.show('$result', _context, duration: 5);

  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        backgroundColor: Colors.black,
        onTap: onTapBottomBar,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              label: 'Download',
              icon: Icon(Icons.download_sharp),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
              backgroundColor: Colors.white),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.network(
            url.replaceAll('amp;', ''),
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  // value: loadingProgress.expectedTotalBytes != null
                  //     ? loadingProgress.cumulativeBytesLoaded /
                  //         loadingProgress.expectedTotalBytes
                  //     : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
