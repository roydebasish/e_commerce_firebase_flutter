import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase_flutter/utils/color.dart';
import 'package:e_commerce_firebase_flutter/widgets/custom_appbar.dart';
import 'package:e_commerce_firebase_flutter/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ProductDetailsScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> products;
  const ProductDetailsScreen({super.key, required this.products});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  final user = FirebaseAuth.instance.currentUser;
  
  List<String> productvariant = [
    "25",
    "30",
    "35",
    "40",
    "45",
    "50",
  ];

  int selectedIndex = 0;
  String? selectedVariant;

  void changeSelectedValue(){
    setState(() {
      selectedVariant = widget.products['variant'][0];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeSelectedValue();
  }

  @override
  Widget build(BuildContext context) {
    // print("Selected variant : $selectedVariant");
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppbar(context: context,backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * .3,
              width: double.infinity,
              color: Color(0xFFD8D3F2),
              child: Center(
                child: Image.network(widget.products['image']!,
                height: 200,
                fit: BoxFit.cover,),
              ),
            ),

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Text(widget.products['name']!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star,color: Colors.orange,size: 20.0,),
                      Icon(Icons.star,color: Colors.orange,size: 20.0,),
                      Icon(Icons.star,color: Colors.orange,size: 20.0,),
                      Icon(Icons.star,color: Colors.orange,size: 20.0,),
                      Icon(Icons.star,color: Colors.orange,size: 20.0,),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$${widget.products['newPrice']!}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('\$${widget.products['oldPrice']!}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ],
                      ),
                      Text('Available in stock',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("About",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.products['description'] ?? "No description is available",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 15.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 150,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  primary:false,
                  itemCount: widget.products['variant'].length,
                  itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        setState(() {
                          selectedIndex = index;
                          selectedVariant = widget.products['variant'][index];
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 40,
                        decoration: BoxDecoration(
                            color: selectedIndex == index ? AppColors.primaryColor : null,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: selectedIndex == index ? Colors.transparent : const Color(0xFFD8D3F2),
                              width: 1.5,
                            )
                        ),
                        child: Center(
                          child: Text(widget.products['variant'][index],
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ),
            CustomButton(
                buttonTitle: "Add To Cart",
              onTap: () async {
                  // print(user!.email);
                  // print(user!.uid);
                await FirebaseFirestore.instance.collection('users')
                    .doc(user!.email)
                    .collection('cart')
                    .add({
                  'user_email' : user!.email,
                  'product_id' : widget.products['id'],
                  'name' : widget.products['name'],
                  'price' : widget.products['newPrice'],
                  'category_id' : widget.products['category_id'],
                  'image' : widget.products['image'],
                  'variant' : selectedVariant,
                  'quantity' : 1,
                }).then((value){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Product successfully added to cart"),)
                  );
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
