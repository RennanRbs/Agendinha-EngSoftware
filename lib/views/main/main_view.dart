import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trabalho_eng_software/services/database.dart';
import 'package:trabalho_eng_software/views/add_edit_contact/add_edit_contact_view.dart';
import 'package:trabalho_eng_software/views/main/controller/main_controller.dart';
import 'package:trabalho_eng_software/widgets/custom_list_item.dart';

class MainView extends StatefulWidget {
  const MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  final MainController controller = Get.put(MainController());

  @override
  void initState() {
    controller.initScrollController(setState);
    super.initState();
  }

  String getFilterTextFieldDescription(int value) {
    switch (value) {
      case 0: return "Contatos com nome contendo...";
      case 1: return "Contatos com email contendo...";
      case 2: return "Contatos no grupo...";
      default: return "Contatos com endereço contendo...";
    }
  }

  Widget getFilterSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
      child: PopupMenuButton(
        child: Icon(Icons.filter_list,
          color: Colors.black,
          size: 30,
        ),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(value: 0, child: Text("Filtrar por nome")),
            PopupMenuItem(value: 1, child: Text("Filtrar por email")),
            PopupMenuItem(value: 2, child: Text("Filtrar por grupo de contato")),
            PopupMenuItem(value: 3, child: Text("Filtrar por endereço"))
          ];
        },
        onSelected: (value) {
          TextEditingController filterController = TextEditingController();
          Get.dialog(AlertDialog(
            title: Text(getFilterTextFieldDescription(value)),
            content: TextField(
              controller: filterController,
            ),
            actions: [
              TextButton(onPressed: () {
                Get.back();
              }, child: Text("Cancelar")),
              TextButton(onPressed: () {
                setState(() {
                  controller.filterType = value;
                  controller.filterText = filterController.text;
                });
                Get.back();
              }, child: Text("Confirmar")),
            ],
          ));
          print(1);
        },
      ),
    );
  }

  Widget getRemoveFilter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
      child: InkWell(
        child: Icon(Icons.remove,
          size: 30,
          color: Colors.black,
        ),
        onTap: () {
          setState(() {
            controller.filterType = -1;
          });
          print(2);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AnimatedContainer(
            height: controller.showAppBar ? 100.0 : 0.0,
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
                color: Colors.transparent
            ),
            child: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text('Contatos',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                ),
              ),
              shadowColor: controller.scrollViewController.hasClients ? (controller.scrollViewController.position.atEdge ? Colors.transparent : Colors.black) : Colors.transparent,
              backgroundColor: Color(0xFFFAFAFA),
              actions: <Widget>[
                controller.filterType == -1 ? getFilterSelector() : getRemoveFilter(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
                  child: InkWell(
                    child: Icon(Icons.logout,
                      color: Colors.black,
                      size: 30,
                    ),
                    onTap: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('userEmail');
                      FirebaseAuth.instance.signOut();
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GetX<MainController>(
              init: Get.put<MainController>(MainController()),
              builder: (MainController mainController) {
                if (mainController.contacts == null || mainController.contacts.length == 0) {
                  return Center(child: Text("Nenhum contato!",
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ));
                }
                if (mainController != null && mainController.contacts != null) {
                  return ListView.builder(
                    controller: controller.scrollViewController,
                    itemCount: mainController.contacts.length,
                    itemBuilder: (_, index) {
                      if (controller.filterMatch(mainController.contacts[index])) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Dismissible(
                            key: Key(mainController.contacts[index].id),
                            onDismissed: (direction) {
                              Database().deleteContact(mainController.contacts[index].id);
                            },
                            child: CustomListItem(
                              email: mainController.contacts[index].email,
                              name: mainController.contacts[index].name,
                              onClick: () {
                                Get.to(() => AddEditContactView(contactID: mainController.contacts[index].id,));
                              },
                            ),
                          ),
                        );
                      } else {
                        return Container(width: 0, height: 0,);
                      }
                    }
                  );
                } else {
                  return Text("Loading...");
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: 170, height: 50),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
            )
          ),
          child: Row(
            children: [
              Icon(Icons.account_circle_rounded, size: 40,),
              Text("Adicionar",
                style: TextStyle(
                  fontSize: 20
                ),
              )
            ],
          ),
          onPressed: () {
            Get.to(() => AddEditContactView());
            //Get.to(() => AddUserPage());
          },
        ),
      ),
    );
  }
}
