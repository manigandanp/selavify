import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtils {
  final String folderName;
  final String fileName;

  FileUtils(this.folderName, this.fileName);

  Future<Directory> get baseDir async =>
      await getApplicationDocumentsDirectory();

  Future<Directory> _createFolder() async {
    final root = await baseDir;
    return new Directory("${root.path}/$folderName").create(recursive: true);
  }

  Future<File> _createFile() async {
    final Directory dir = await _createFolder();
    final pathOfTheFileToWrite = "${dir.path}$fileName";
    File file = File(pathOfTheFileToWrite);
    return file;
  }

  Future<File> writeContent(String content) async {
    final file = await _createFile();
    return file.writeAsString(content);
  }

  Future<void> deleteFile(File file) async {
    await file.delete();
  }
}
