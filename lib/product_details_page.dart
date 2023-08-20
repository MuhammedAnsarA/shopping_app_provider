import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Map<String, Object> product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;

  void onTap() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct(
        {
          "id": widget.product["id"],
          "title": widget.product["title"],
          "price": widget.product["price"],
          "imageUrl": widget.product["imageUrl"],
          "company": widget.product["company"],
          "size": selectedSize,
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("product added succesfully!")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("select size")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            widget.product["title"] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Image.asset(widget.product["imageUrl"] as String),
          const Spacer(),
          Container(
            height: 250,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(205, 219, 234, 1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "₹${widget.product["price"]}",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product["sizes"] as List<int>).length,
                    itemBuilder: (context, index) {
                      final size =
                          (widget.product["sizes"] as List<int>)[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Chip(
                            backgroundColor: selectedSize == size
                                ? const Color.fromRGBO(254, 206, 1, 1)
                                : null,
                            label: Text(
                              size.toString(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(254, 206, 1, 1),
                        minimumSize: const Size(double.infinity, 50)),
                    onPressed: onTap,
                    label: const Text(
                      "Add To Cart",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    icon: const Icon(Icons.shopping_cart, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
