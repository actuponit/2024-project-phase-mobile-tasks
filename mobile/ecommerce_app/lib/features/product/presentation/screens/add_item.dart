import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/product.dart';
import '../blocs/product/product_bloc.dart';
import '../widgets/custom_button.dart';
import '../widgets/snack_bar.dart';

class AddItem extends StatefulWidget {
  final Product? product;
  final ImagePicker imagePicker;
  const AddItem({super.key, this.product, required this.imagePicker});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  File? _image;

  Future getImage(ImagePicker imagePicker) async {
    
    final image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }
    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _categoryController = TextEditingController();
    final TextEditingController _priceController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();

    if (widget.product != null) {
      _titleController.text = widget.product!.name;
      _categoryController.text = widget.product!.name;
      _priceController.text = '${widget.product!.price}';
      _descriptionController.text = widget.product!.description;
    }

    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is LoadedSingleProductState) {
          if (widget.product == null) {
            showSnackBar(context, Colors.green, 'Product added successfully');
            Navigator.of(context).popAndPushNamed('single_product',
                arguments: state.product.id);
          } else {
            Navigator.of(context).pop();
            showSnackBar(context, Colors.green, 'Product updated successfully');
          }
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: SafeArea(
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
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color.fromRGBO(63, 81, 243, 1),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
            title: Text(
              widget.product == null ? 'Add  Product' : 'Update Product',
              style: const TextStyle(
                  height: 1.5,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  color: Color.fromRGBO(62, 62, 62, 1)),
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
                    child: _image == null ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          key: const Key('image'),
                          onPressed: () => getImage(widget.imagePicker),
                          icon: const Icon(
                            Icons.image_outlined,
                            size: 48,
                            color: Color.fromRGBO(62, 62, 62, 1),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'Upload Images',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              height: 1.5,
                              color: Color.fromRGBO(62, 62, 62, 1)),
                        )
                      ],
                    ) 
                    : 
                    Image.file(_image!, fit: BoxFit.fill,),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Name',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        height: 1.5,
                        color: Color.fromRGBO(62, 62, 62, 1)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(243, 243, 243, 1),
                        borderRadius: BorderRadius.circular(6)),
                    child: TextField(
                      key: const Key('name'),
                      controller: _titleController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 6),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Price',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        height: 1.5,
                        color: Color.fromRGBO(62, 62, 62, 1)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(243, 243, 243, 1),
                        borderRadius: BorderRadius.circular(6)),
                    child: TextField(
                      key: const Key('price'),
                      keyboardType: TextInputType.number,
                      controller: _priceController,
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.attach_money,
                          color: Color.fromRGBO(62, 62, 62, 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Category',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        height: 1.5,
                        color: Color.fromRGBO(62, 62, 62, 1)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(243, 243, 243, 1),
                        borderRadius: BorderRadius.circular(6)),
                    child: TextField(
                      key: const Key('category'),
                      controller: _categoryController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 6),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Description',
                    style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Color.fromRGBO(62, 62, 62, 1)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(243, 243, 243, 1),
                        borderRadius: BorderRadius.circular(6)),
                    child: TextField(
                      key: const Key('description'),
                      maxLines: null,
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 6),
                          border: InputBorder.none),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CustomButton(
                    buttonKey: 'addButton',
                    filled: true,
                    text: widget.product == null ? 'ADD' : 'UPDATE',
                    width: double.infinity,
                    onPressed: () {
                      debugPrint('fafdafadfadfafd');
                      final String title = _titleController.text;
                      final String category = _categoryController.text;
                      final String price = _priceController.text;
                      final String description = _descriptionController.text;
                      if (title.isEmpty ||
                          category.isEmpty ||
                          price.isEmpty ||
                          description.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill all the fields')));
                      } else if (widget.product == null) {
                        if (_image == null) {
                          showSnackBar(context, Colors.red, 'Please upload image');
                          return;
                        }
                        BlocProvider.of<ProductBloc>(context).add(
                            CreateProductEvent(
                                name: title,
                                price: price,
                                description: description,
                                imageUrl: _image!.path));
                        // Navigator.of(context).pop();
                      } else {
                        BlocProvider.of<ProductBloc>(context).add(
                            UpdateProductEvent(
                                name: title,
                                price: price,
                                description: description,
                                id: widget.product!.id,
                                imageUrl: ''));
                        // Navigator.of(context).pop();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: 'DELETE',
                    width: double.infinity,
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
