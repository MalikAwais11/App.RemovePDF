import 'package:get/get.dart';
import '../model/historyModel.dart';
import '../source/local/DataBase_Helper.dart';

class historyController extends GetxController{


  List<historyModel> items = <historyModel>[];

  var isLoading = true.obs;

  var itemsLength = 0.obs;


  getItems() async {
    isLoading.value = true;
    final data = await SQLHelper.getItems();
    print(data);
    items = <historyModel>[];
    data.forEach((i) {
      items.add(historyModel(id: i["id"], toolName: i["toolName"], date: i["date"], filePath: i["filepath"], fileSize:i["fileSize"],  splitPaths:i["splitPaths"] ));
    });
    isLoading.value = false;
    itemsLength.value = items.length;
  }



  deleteItem(int id,) async {
    await SQLHelper.deleteItem(id);
    getItems();
  }

  deleteAll() async {
    await SQLHelper.deleteAll();
    getItems();
  }


}