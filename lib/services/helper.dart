import 'package:selavify/models/model.dart';
import 'package:uuid/uuid.dart';

class Helper {
  static List toInsertValues(List<String> lst) => lst.map((l) {
        return {
          "id": Uuid().v4(),
          "title": l,
          "createdTimestamp": DateTime.now().millisecondsSinceEpoch,
        };
      }).toList();
}
