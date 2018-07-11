import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:mime/mime.dart';

bool externalStoragePermissionOkay = false;

class FileManager extends StatefulWidget {
  final String mainDirectory;

  FileManager({this.mainDirectory});
  @override
  createState() => FileManagerState();
}

class FileManagerState extends State<FileManager> {
  var _directory = '';
  var _currentDirectory = '';
  var _back = 'Go to back';
  var accentColor = Colors.blue;
  List<FileSystemEntity> _allPathsList;

  //Temporary list before merging into one list
  List<String> _directoriesList = List();
  List<String> _filesList = List();

  List<String> _filteredPathsList = List();

  @override
  initState() {
    super.initState();
    _initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid && externalStoragePermissionOkay) {
      return FutureBuilder<Directory>(
          future: getExternalStorageDirectory(), builder: _buildDirectory);
    } else {
      return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("You're not on Android"));
    }
    ;
  }

  Widget _buildDirectory(
      BuildContext context, AsyncSnapshot<Directory> snapshot) {
    _allPathsList = [];
    _filteredPathsList = [];
    _directoriesList = [];
    _filesList = [];
    Text text = const Text('');
    Directory dir;

    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        text = Text('Error: ${snapshot.error}');
      } else if (snapshot.hasData) {
        dir = Directory(snapshot.data.path + _directory);
        // text = Text('path: ${dir.path}');
        _allPathsList = dir.listSync(recursive: false, followLinks: true);

        for (int i = 0; i < _allPathsList.length; i++) {
          var path = _allPathsList.elementAt(i).path;
          var filename = basename(path);

          var isDirectory = FileSystemEntity.isDirectorySync(path);
          var isFile = FileSystemEntity.isFileSync(path);

          if (!filename.startsWith('.')) {
            if (isDirectory)
              _directoriesList.add(path);
            else if (isFile) {
              _filesList.add(path);
            }
          }
        }
        _directoriesList.sort();
        _filesList.sort();

        _filteredPathsList = _directoriesList + _filesList;
        if (_directory != widget.mainDirectory)
          _filteredPathsList.insert(0, _back);
      } else {
        text = const Text('path unavailable');
      }
    }
    if (_allPathsList != null) {
      return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: _filteredPathsList.length,
          itemBuilder: (context, i) {
            return _buildRow(_filteredPathsList.elementAt(i), context);
          });
    } else {
      return Padding(padding: const EdgeInsets.all(16.0), child: text);
    }
  }

  Widget _buildRow(String path, BuildContext context) {
    final _fileName = basename(path);
    return ListTile(
      leading: _fileName == _back
          ? Icon(
              Icons.arrow_back_ios,
              color: accentColor,
            )
          : _getIcon(path),
      title: Text(
        _fileName,
        style:
            TextStyle(color: _fileName == _back ? accentColor : Colors.black),
      ),
      onTap: () {
        if (_fileName == _back) {
          setState(() {
            _directory = _directory.replaceFirst(_currentDirectory, '');
            _currentDirectory = '/${_directory.split("/").last}';
          });
        } else if (FileSystemEntity.isDirectorySync(path)) {
          _currentDirectory = '/$_fileName';

          setState(() {
            _directory = _directory + _currentDirectory;
          });
        } else if (FileSystemEntity.isFileSync(path)) {
          Navigator.pop(
            context,
            path,
          );
          //Navigator.of(context).pop(path);
          //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CourseworkUploadPage(path)));
        }
      },
    );
  }

  _initPlatformState() async {
    if (Platform.isAndroid) {
      SimplePermissions
          .checkPermission(Permission.WriteExternalStorage)
          .then((checkOkay) {
        if (!checkOkay) {
          SimplePermissions
              .requestPermission(Permission.WriteExternalStorage)
              .then((okDone) {
            if (okDone) {
              setState(() {
                externalStoragePermissionOkay = okDone;
              });
            }
          });
        } else {
          setState(() {
            externalStoragePermissionOkay = checkOkay;
          });
        }
      });
    }
  }
}

Widget _getIcon(String path) {
  if (FileSystemEntity.isDirectorySync(path))
    return Image.asset(
      'assets/file_manager_icons/directory.png',
      height: 30.0,
    );
  else if (FileSystemEntity.isFileSync(path)) {
    if (lookupMimeType(basename(path)) == 'image/jpeg')
      return Image.asset(
        'assets/file_manager_icons/jpg.png',
        height: 30.0,
      );
    else if (lookupMimeType(basename(path)) == 'image/png')
      return Image.asset(
        'assets/file_manager_icons/png.png',
        height: 30.0,
      );
    else if (lookupMimeType(basename(path)) == 'application/pdf')
      return Image.asset(
        'assets/file_manager_icons/pdf.png',
        height: 30.0,
      );
    else if (lookupMimeType(basename(path)) ==
            'application/vnd.openxmlformats-officedocument.wordprocessingml.document' ||
        lookupMimeType(basename(path)) == 'application/msword')
      return Image.asset(
        'assets/file_manager_icons/doc.png',
        height: 30.0,
      );
    else if (lookupMimeType(basename(path)) ==
            'application/vnd.openxmlformats-officedocument.presentationml.presentation' ||
        lookupMimeType(basename(path)) == 'application/vnd.ms-powerpoint')
      return Image.asset(
        'assets/file_manager_icons/ppt.png',
        height: 30.0,
      );
    else if (lookupMimeType(basename(path)) ==
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ||
        lookupMimeType(basename(path)) == 'application/vnd.ms-excel')
      return Image.asset(
        'assets/file_manager_icons/xls.png',
        height: 30.0,
      );
    else if (lookupMimeType(basename(path)) == 'text/csv')
      return Image.asset(
        'assets/file_manager_icons/csv.png',
        height: 30.0,
      );
    else if (lookupMimeType(basename(path)) == 'text/html')
      return Image.asset(
        'assets/file_manager_icons/html.png',
        height: 30.0,
      );
    else if (lookupMimeType(basename(path)) == 'application/json')
      return Image.asset(
        'assets/file_manager_icons/json.png',
        height: 30.0,
      );
    else if (lookupMimeType(basename(path)) == 'application/javascript')
      return Image.asset(
        'assets/file_manager_icons/javascript.png',
        height: 30.0,
      );
    else if (lookupMimeType(basename(path)) == 'application/zip' ||
        lookupMimeType(basename(path)) == 'application/x-7z-compressed')
      return Image.asset(
        'assets/file_manager_icons/zip.png',
        height: 30.0,
      );
    else if (lookupMimeType(basename(path)) == 'application/x-msdownload')
      return Image.asset(
        'assets/file_manager_icons/exe.png',
        height: 30.0,
      );
    else if (lookupMimeType(basename(path)) == 'video/mp4' ||
        lookupMimeType(basename(path)) == 'application/mp4')
      return Image.asset(
        'assets/file_manager_icons/mp4.png',
        height: 30.0,
      );
    else if (lookupMimeType(basename(path)) == 'text/plain')
      return Image.asset(
        'assets/file_manager_icons/txt.png',
        height: 30.0,
      );
    else
      return Image.asset(
        'assets/file_manager_icons/file.png',
        height: 30.0,
      );
  } else
    return Image.asset(
      'assets/file_manager_icons/file.png',
      height: 30.0,
    );
}