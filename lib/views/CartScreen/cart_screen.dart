import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase_flutter/utils/color.dart';
import 'package:e_commerce_firebase_flutter/widgets/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  List<QueryDocumentSnapshot> cartItems = [];

  double totalAmount = 0.0;

  double calculateTotalAmount(){

    double finalAmount = 0.0;

    for(var data in cartItems){
      double price = double.parse(data['price']);
      int quantity = data['quantity'];
      finalAmount += price * quantity;
      totalAmount = finalAmount;
      // print(finalAmount);
    }
    return finalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.collection('users')
          .doc(user!.email)
          .collection('cart')
          .snapshots(),
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else{
          cartItems = snapshot.data!.docs;
          final amount = calculateTotalAmount();
          totalAmount = amount;
          return Scaffold(
            appBar: CustomAppbar(
                context: context,
                title: "My Cart"),
            body: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        final data = snapshot.data!.docs[index];
                        // final QueryDocumentSnapshot<Map<String, dynamic>> product = firestore.collection('products').where('id',isEqualTo: data['product_id']).snapshots();
                        return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              height: 90,
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xFFD8D3F2),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      child: Center(
                                        child: Image.network(data['image']),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data['name'],
                                          style: TextStyle(
                                              color: Colors.black.withOpacity(.5),
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        Text("\$ ${data['price']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Size : ${data['variant']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.normal
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          height: 35,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: AppColors.primaryColor,
                                                  width: 1.5
                                              )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                      onTap: (){
                                                        if(data['quantity'] > 1) {
                                                          firestore.collection('users')
                                                              .doc(user!.email)
                                                              .collection('cart')
                                                              .doc(data.id)
                                                              .update({
                                                            'quantity': data['quantity'] -
                                                                1,
                                                          });
                                                        }else{
                                                          firestore.collection('users')
                                                              .doc(user!.email)
                                                              .collection('cart')
                                                              .doc(data.id)
                                                              .delete();
                                                        }
                                                      },
                                                      child: Icon(data['quantity'] == 1 ?Icons.delete : Icons.remove)
                                                  ),
                                                  Text(data['quantity'].toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15.0,
                                                        fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: (){
                                                      firestore.collection('users')
                                                          .doc(user!.email)
                                                          .collection('cart')
                                                          .doc(data.id)
                                                          .update({
                                                        'quantity' : data['quantity'] + 1
                                                      });
                                                    },
                                                    child: Icon(Icons.add),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                        );
                      }
                  ),
            bottomNavigationBar: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('\$ ${totalAmount}',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    CustomButton(
                        buttonTitle: "Buy Now",
                      onTap: () async {

                          List<Map<String,dynamic>> cartData = cartItems.map((item) => item.data() as Map<String,dynamic>).toList();

                          FirebaseFirestore.instance.collection('orders').add({
                            'email':user!.email,
                            'time' : Timestamp.now(),
                            'items': cartData,
                            'amount': totalAmount,
                            'gateway_name' : 'Cash On Delivery',
                            'status':'On Processing'
                          }).then((value) async {
                            final cart = await FirebaseFirestore.instance.collection('users')
                                .doc(user!.email).collection('cart').get();

                            for(var item in cart.docs){
                              await item.reference.delete();
                            }

                          });
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
