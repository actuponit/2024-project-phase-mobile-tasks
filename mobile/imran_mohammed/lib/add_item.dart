import 'package:flutter/material.dart';
import 'package:imran_mohammed/custom_button.dart';
import 'package:imran_mohammed/models/shoe.dart';

class AddItem extends StatelessWidget {
  final Shoe? shoe;
  const AddItem({super.key, this.shoe});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _categoryController = TextEditingController();
    final TextEditingController _priceController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();

    if (shoe != null) {
      _titleController.text = shoe!.title;
      _categoryController.text = shoe!.category;
      _priceController.text = '${shoe!.price}';
      _descriptionController.text = shoe!.description;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
              shape: WidgetStatePropertyAll<OutlinedBorder>(
                CircleBorder(),
              ),
            ),
            padding: const EdgeInsets.only(left: 10),
            alignment: Alignment.center,
            icon: const Icon(Icons.arrow_back_ios, color: Color.fromRGBO(63, 81, 243, 1),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text(
            shoe==null?"Add  Product":'Update Product',
            style: const TextStyle(
              height: 1.5,
              fontSize: 16,
              fontFamily: 'Poppins',
              color: Color.fromRGBO(62, 62, 62, 1)
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: const Color.fromRGBO(243, 243, 243, 1),
                  ),
                  height: 190,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_outlined, size: 48, color: Color.fromRGBO(62, 62, 62, 1),),
                      SizedBox(height: 40,),
                      Text('Upload Images', style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        height: 1.5,
                        color: Color.fromRGBO(62, 62, 62, 1)
                      ),)
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                const Text('Name', 
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    height: 1.5,
                    color: Color.fromRGBO(62, 62, 62, 1)
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                const Text('Price', 
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    height: 1.5,
                    color: Color.fromRGBO(62, 62, 62, 1)
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _priceController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.attach_money, color: Color.fromRGBO(62, 62, 62, 1),),
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                const Text('Category', 
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    height: 1.5,
                    color: Color.fromRGBO(62, 62, 62, 1)
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: TextField(
                    controller: _categoryController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                      border: InputBorder.none
                    ),
                  ),
                ),
                const SizedBox(height: 15,),
                const Text('Description', 
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Color.fromRGBO(62, 62, 62, 1)
                  ),
                ),
                const SizedBox(height: 5,),
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(243, 243, 243, 1),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: TextField(
                    maxLines: null,
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 6),
                      border: InputBorder.none
                    ),
                  ),
                ),
                const SizedBox(height: 25,),
                CustomButton(filled: true, text: shoe==null?'ADD':'UPDATE', width: double.infinity, onPressed: (){
                  final String title = _titleController.text;
                  final String category = _categoryController.text;
                  final String price = _priceController.text;
                  final String description = _descriptionController.text;
                  if(title.isEmpty || category.isEmpty || price.isEmpty || description.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all the fields')));
                  } else if (shoe == null){
                    Navigator.of(context).pop(Shoe(price: double.parse(price), title: title, category: category, description: description));
                  } else {
                    Navigator.of(context).pop(Shoe(price: double.parse(price), title: title, category: category, description: description));
                  }
                },),
                const SizedBox(height: 10,),
                CustomButton(text: 'DELETE', width: double.infinity, onPressed: (){},)
              ],
          ), 
          ),
        ),
      ),
    );
  }
}