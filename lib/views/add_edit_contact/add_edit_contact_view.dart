import 'package:fitted_text_field_container/fitted_text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trabalho_eng_software/models/contact_model.dart';
import 'package:trabalho_eng_software/services/database.dart';
import 'package:trabalho_eng_software/views/add_edit_contact/controller/add_edit_contact_controller.dart';
import 'package:trabalho_eng_software/widgets/contact_group_list.dart';
import 'package:trabalho_eng_software/widgets/custom_fitted_textfield_container.dart';
import 'package:trabalho_eng_software/widgets/custom_textfield.dart';
import 'package:trabalho_eng_software/widgets/list_separator_with_name.dart';

class AddEditContactView extends StatefulWidget {

  final String contactID;

  const AddEditContactView({Key key, this.contactID}) : super(key: key);

  @override
  _AddEditContactViewState createState() => _AddEditContactViewState();
}

class _AddEditContactViewState extends State<AddEditContactView> {

  final AddEditContactController controller = Get.put(AddEditContactController());

  @override
  void initState() {
    super.initState();
    if (widget.contactID != null) {
      controller.populateFields(widget.contactID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contactID == null ? "Adicionar contato" : "Visualizar/editar contato",
          style: TextStyle(
              fontSize: 17,
              color: Colors.black
          ),
        ),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Center(
              child: Icon(
                Icons.person,
                size: 125,
              )
            ),
            SizedBox(height: 10,),
            CustomFittedTextFieldContainer(
              calculator: FittedTextFieldCalculator.fitVisibleWithRange(275, 400),
              child: TextField(
                textAlign: TextAlign.center,
                controller: controller.nameController,
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.w500
                ),
                decoration: InputDecoration(
                  hintText: "Nome do contato",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      borderSide: BorderSide(width: 20)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    borderSide: BorderSide(width: 1, color: Colors.orange),
                  ),
                ),
              )
            ),
            SizedBox(height: 20,),
            ListSeparatorWithName(title: "Dados do contato",),
            CustomTextField(upperText: "E-mail", hintText: "abc@def.com", controller: controller.mailController,),
            CustomTextField(upperText: "Telefone", hintText: "(xx) xxxxx-xxxx", controller: controller.phoneController,),
            CustomTextField(upperText: "Endereço", hintText: "Rua X, 123", controller: controller.addressController,),
            CustomTextField(upperText: "CEP", hintText: "XXXXX-XXX", controller: controller.CEPController,),
            ListSeparatorWithName(title: "Grupos do contato",),
            ContactGroupList(
              observableList: controller.contactGroupList,
            ),
          ],
        ),
      ),
        bottomNavigationBar: BottomAppBar(
            child: Row(
              children: [
                Expanded(
                    child: InkWell(
                      onTap: () async {
                        if (widget.contactID == null) {
                          Database().addContact(
                            new ContactModel(
                              name: controller.nameController.text,
                              email: controller.mailController.text,
                              address: controller.addressController.text,
                              cep: controller.CEPController.text,
                              phone: controller.phoneController.text,
                              contactGroup: controller.contactGroupList.value
                            )
                          );
                        } else {
                          Database().updateContact(widget.contactID, new ContactModel(
                            contactGroup: controller.contactGroupList.value,
                            phone: controller.phoneController.text,
                            cep: controller.CEPController.text,
                            address: controller.addressController.text,
                            email: controller.mailController.text,
                            name: controller.nameController.text,
                          ));
                        }
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Text(widget.contactID == null ? "Adicionar contato" : "Confirmar alterações",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    )
                ),
              ],
            )
        )
    );
  }
}
