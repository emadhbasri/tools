
// import 'my_drop_down.dart';

// class MyInputMaker<T> extends StatelessWidget {
//   const MyInputMaker({Key? key, this.data}) : super(key: key);
//   final data;
//   final ValueChanged<T?> onChanged;
//   @override
//   Widget build(BuildContext context) {
//     if(data is MyDropDownData){
//       return MyDropDown(onChanged: onChanged, data: data,);
//     }

//     else {
//       const SizedBox.shrink();
//     }
//   }
// }

class ToolsDataDropDown<T> {
  List<String> titles;
  late List<T> values;
  T? value;
  ToolsDataDropDown(this.titles, this.value, {List<T>? values, bool titleValueSame = true}) {
    if (titleValueSame) {
      this.values = titles.cast<T>();
    } else {
      this.values = values!;
    }
  }
  clear(){
    value=null;
  }
}

class ToolsDataPopUp<T> {
  List<String> titles;
  late List<T> values;
  List<T> enables = [];
  T? initialValue;
  ToolsDataPopUp(this.titles, this.initialValue, {List<T>? values, bool titleValueSame = true, this.enables = const []}) {
    if (titleValueSame) {
      this.values = titles.cast<T>();
    } else {
      this.values = values!;
    }
  }
  clear(){
    values.clear();
  }
}

class ToolsDataTwoRange<T> {
  T start, end;

  ToolsDataTwoRange({required this.start, required this.end});
}

class ToolsDataTwo<T> {
  T data1, data2;

  ToolsDataTwo(this.data1, this.data2);
}
