enum DataType { datetime, int, double, string, bool, boolint, clas }

dynamic makeClass(Map<String, dynamic> data, String type) {
  switch (type) {
    case 'String':
      return data.toString();
    // case 'DataRefreshRequest':
    //   return DataRefreshRequest.fromJson(data);

  }
}

List<Type> convertDataList<Type>(
    Map<String, dynamic> data, String key, String classType) {
  if (data.containsKey(key) == false ||
      data[key] == null ||
      data[key].isEmpty) {
    return [];
  } else {
    List<Type> temp = [];
    for (int j = 0; j < data[key].length; j++) {
      temp.add(makeClass(data[key][j], classType));
    }
    return temp;
  }
}

List<Type> convertDataListRaw<Type>(List<dynamic> data, String classType) {
  List<Type> temp = [];
  for (int j = 0; j < data.length; j++) {
    temp.add(makeClass(data[j], classType));
  }
  return temp;
}

DataType foundData(Type type) {
  switch (type) {
    case DateTime:
      return DataType.datetime;
    case String:
      return DataType.string;
    case int:
      return DataType.int;
    case double:
      return DataType.double;
    case bool:
      return DataType.bool;
    default:
      return DataType.clas;
  }
}

dynamic convertData<Type>(Map<String, dynamic> data, String key, DataType type,
    {bool haveTo = false, String? classType}) {
  switch (type) {
    case DataType.clas:
      if (data.containsKey(key) == false || data[key] == null) {
        return null;
      } else {
        return makeClass(data[key], classType!);
      }
    case DataType.datetime:
      if (data.containsKey(key) == false || data[key] == null) {
        return !haveTo ? null : DateTime.now();
      } else {
        DateTime? dd = DateTime.tryParse(data[key].toString());
        return dd ?? DateTime.now();
      }
    case DataType.int:
      if (data.containsKey(key) == false || data[key] == null) {
        return !haveTo ? null : 0;
      } else {
        return int.parse(data[key].toString());
      }
    case DataType.double:
      if (data.containsKey(key) == false || data[key] == null) {
        return !haveTo ? null : 0.0;
      } else {
        return double.parse(data[key].toString());
      }
    case DataType.string:
      if (data.containsKey(key) == false || data[key] == null) {
        return !haveTo ? null : '';
      } else {
        return data[key].toString();
      }
    case DataType.bool:
      if (data.containsKey(key) == false || data[key] == null) {
        return !haveTo ? null : false;
      } else {
        return data[key];
      }
    case DataType.boolint:
      if (data.containsKey(key) == false || data[key] == null) {
        return !haveTo ? null : false;
      } else {
        return int.parse(data[key].toString()) == 1 ? true : false;
      }
  }
}

dynamic convertDataRaw(dynamic data, DataType type,
    {bool haveTo = false, String? classType}) {
  switch (type) {
    case DataType.clas:
      if (data == null) {
        return null;
      } else {
        return makeClass(data, classType!);
      }
    case DataType.datetime:
      if (data == null) {
        return !haveTo ? null : DateTime.now();
      } else {
        DateTime? dd = DateTime.tryParse(data.toString());
        return dd ?? DateTime.now();
      }
    case DataType.int:
      if (data == null) {
        return !haveTo ? null : 0;
      } else {
        return int.parse(data.toString());
      }
    case DataType.double:
      if (data == null) {
        return !haveTo ? null : 0.0;
      } else {
        return double.parse(data.toString());
      }
    case DataType.string:
      if (data == null) {
        return !haveTo ? null : '';
      } else {
        return data.toString();
      }
    case DataType.bool:
      if (data == null) {
        return !haveTo ? null : false;
      } else {
        return data;
      }
    case DataType.boolint:
      if (data == null) {
        return !haveTo ? null : false;
      } else {
        return int.parse(data.toString()) == 1 ? true : false;
      }
  }
}

BigInt Big(source) {
  return BigInt.parse(source.toString());
}

double Dob(source) {
  return double.parse(source.toString());
}

int Int(data) {
  return int.parse(data.toString());
}
