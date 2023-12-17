import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase_flutter/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class ProductByCategoryScreen extends StatelessWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> category;
  ProductByCategoryScreen({super.key,required this.category});

  final firestore = FirebaseFirestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(context: context,title: category['name']),
      body: StreamBuilder(
        stream: firestore.collection('products').where('category_id',isEqualTo: category['id']).snapshots(),
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,index){
                  final data = snapshot.data!.docs[index];
                  return Card(
                    child: ListTile(
                      title: Text(data['name']),
                      subtitle: Text("\$ ${data['newPrice']}"),
                    ),
                  );
                }
            );
          }
        },
      ),
    );
  }
}
