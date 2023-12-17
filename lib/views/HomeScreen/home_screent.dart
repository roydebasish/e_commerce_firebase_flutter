import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_firebase_flutter/utils/color.dart';
import 'package:e_commerce_firebase_flutter/views/Authentication/LoginScreen/logoin_screen.dart';
import 'package:e_commerce_firebase_flutter/views/ProductByCategory/product_by_category_screen.dart';
import 'package:e_commerce_firebase_flutter/views/ProductDetails/product_details_screen.dart';
import 'package:e_commerce_firebase_flutter/widgets/custom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  final firestore = FirebaseFirestore.instance;

  List slidderImage = [
    "https://bbdniit.ac.in/wp-content/uploads/2020/09/banner-background-without-image-min.jpg",
    "https://bbdniit.ac.in/wp-content/uploads/2020/09/banner-background-without-image-min.jpg",
    "https://bbdniit.ac.in/wp-content/uploads/2020/09/banner-background-without-image-min.jpg",
    "https://bbdniit.ac.in/wp-content/uploads/2020/09/banner-background-without-image-min.jpg",
  ];
  
  List firebaseSlidders = [];
  
  Future<void> getSliders() async{
    final data = await firestore.collection('banners').get().then((value){
      setState(() {
        firebaseSlidders = value.docs;
        print(value.docs);
      });
    });

  }

  List<Map<String, String>> categories = [
    {'icon': 'assets/images/1.png'},
    {'icon': 'assets/images/2.png'},
    {'icon': 'assets/images/3.png'},
    {'icon': 'assets/images/4.png'},
    {'icon': 'assets/images/5.png'},
    {'icon': 'assets/images/6.png'},
  ];


  List<Map<String, String>> products = [
    {
      'name': 'Hp Pavilion',
      'icon': 'assets/images/1.png',
      'newPrice': '100',
      'oldPrice': '100',
      'oofPercentage': '20',
    },
    {
      'name': 'Hp Probook',
      'icon': 'assets/images/1.png',
      'newPrice': '1700',
      'oldPrice': '1300',
      'oofPercentage': '30',
    },
    {
      'name': 'Xiaomi Mi 11',
      'icon': 'assets/images/1.png',
      'newPrice': '1100',
      'oldPrice': '1300',
      'oofPercentage': '22',
    },
    {
      'name': 'Lenovo',
      'icon': 'assets/images/1.png',
      'newPrice': '800',
      'oldPrice': '600',
      'oofPercentage': '20',
    },
    {
      'name': 'Dell Inspiration',
      'icon': 'assets/images/1.png',
      'newPrice': '1250',
      'oldPrice': '900',
      'oofPercentage': '30',
    },
    {
      'name': 'Acer Aspire',
      'icon': 'assets/images/1.png',
      'newPrice': '450',
      'oldPrice': '250',
      'oofPercentage': '40',
    },

  ];

  // List<Map<String,dynamic>> productsList = [
  //   {
  //     'id' : '1',
  //     'category_id' : '1',
  //     'name': 'Hp Pavilion',
  //     'image': 'https://c1.neweggimages.com/productimage/nb640/34-840-005-01.jpg',
  //     'newPrice': '100',
  //     'oldPrice': '100',
  //     'oofPercentage': '20',
  //     'variant' : ['20','25','30'],
  //     'description': 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
  //   },
  //   {
  //     'id' : '2',
  //     'category_id' : '1',
  //     'name': 'Hp Probook',
  //     'image': 'https://c1.neweggimages.com/productimage/nb640/34-840-005-01.jpg',
  //     'newPrice': '1700',
  //     'oldPrice': '1300',
  //     'oofPercentage': '30',
  //     'variant' : ['20','25','30'],
  //     'description': 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
  //   },
  //   {
  //     'id' : '3',
  //     'category_id' : '2',
  //     'name': 'Xiaomi Mi 11',
  //     'image': 'https://cdn.vox-cdn.com/thumbor/MbqQFr7Ul9_EfkWSdyoBUShCroQ=/0x0:2000x1333/1400x1400/filters:focal(1000x667:1001x668)/cdn.vox-cdn.com/uploads/chorus_asset/file/24581514/DSC04535_processed.jpg',
  //     'newPrice': '1100',
  //     'oldPrice': '1300',
  //     'oofPercentage': '22',
  //     'variant' : ['20','25','30'],
  //     'description': 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
  //   },
  //   {
  //     'id' : '4',
  //     'category_id' : '2',
  //     'name': 'I Phone 15 Pro Max',
  //     'image': 'https://cdn.vox-cdn.com/thumbor/MbqQFr7Ul9_EfkWSdyoBUShCroQ=/0x0:2000x1333/1400x1400/filters:focal(1000x667:1001x668)/cdn.vox-cdn.com/uploads/chorus_asset/file/24581514/DSC04535_processed.jpg',
  //     'newPrice': '800',
  //     'oldPrice': '600',
  //     'oofPercentage': '20',
  //     'variant' : ['20','25','30'],
  //     'description': 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
  //   },
  //   {
  //     'id' : '5',
  //     'category_id' : '3',
  //     'name': 'Apple Watch 5',
  //     'image': 'https://rukminim1.flixcart.com/image/850/1000/kfeamq80/smartwatch/f/v/r/ios-m06n3hn-a-apple-original-imafvvhrafegcfz2.jpeg',
  //     'newPrice': '1250',
  //     'oldPrice': '900',
  //     'oofPercentage': '30',
  //     'variant' : ['20','25','30'],
  //     'description': 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
  //   },
  //   {
  //     'id' : '6',
  //     'category_id' : '3',
  //     'name': 'Amazfit Bip',
  //     'image': 'https://rukminim1.flixcart.com/image/850/1000/kfeamq80/smartwatch/f/v/r/ios-m06n3hn-a-apple-original-imafvvhrafegcfz2.jpeg',
  //     'newPrice': '450',
  //     'oldPrice': '250',
  //     'oofPercentage': '40',
  //     'variant' : ['20','25','30'],
  //     'description': 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
  //   },
  //   {
  //     'id' : '7',
  //     'category_id' : '4',
  //     'name': 'Long Hand Shirt 1',
  //     'image': 'https://poshgarments.com/wp-content/uploads/2021/09/Mens-Shirt-MWS0001-450x450.jpg',
  //     'newPrice': '1250',
  //     'oldPrice': '900',
  //     'oofPercentage': '30',
  //     'variant' : ['20','25','30'],
  //     'description': 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
  //   },
  //   {
  //     'id' : '8',
  //     'category_id' : '4',
  //     'name': 'Half Shirt',
  //     'image': 'https://poshgarments.com/wp-content/uploads/2021/09/Mens-Shirt-MWS0001-450x450.jpg',
  //     'newPrice': '450',
  //     'oldPrice': '250',
  //     'oofPercentage': '40',
  //     'variant' : ['20','25','30'],
  //     'description': 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
  //   },
  //
  // ];
  //
  // Future addProduct() async{
  //   for(var product in productsList){
  //     firestore.collection('products').add(product);
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    getSliders();
    // addProduct();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppbar(
          context: context,
          title: 'HomeScreen',
          isLeading: const Icon(Icons.menu),
          action: [
            IconButton(onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) =>
                    const LoginScreen()
                  ),
                      (route) => false);
            }, icon: const Icon(Icons.logout))
          ]
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Greeting
              const Text('Hello, Mr 👋',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600
                ),
              ),
              const Text("Let's start shopping",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400
                ),
              ),

              //Slider
              firebaseSlidders.isEmpty ? const Center(
                child: CircularProgressIndicator(),
              ) : Container(
                height: 150,
                width: double.infinity,
                margin: const EdgeInsets.only(
                    top: 20,
                    bottom: 15
                ),
                child: CarouselSlider.builder(
                  itemCount: firebaseSlidders.length,
                  itemBuilder: (BuildContext context, int itemIndex,
                      int pageViewIndex) =>
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(firebaseSlidders[itemIndex]['image']),
                              fit: BoxFit.cover
                          ),
                        ),
                        // child: Text(itemIndex.toString()),
                      ),
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayCurve: Curves.easeInOut,
                      enlargeCenterPage: true
                  ),
                ),
              ),

              //Categories
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('All Categories',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                  Text('See All',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),

              StreamBuilder(
                  stream: firestore.collection('categories').snapshots(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),);
                    }else{
                      return SizedBox(
                        height: 65,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            primary: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context)=> ProductByCategoryScreen(category: snapshot.data!.docs[index],)));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10.0),
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFFD8D3F2),
                                      border: Border.all(
                                          color: Color(0xFFD8D3D3)
                                      )
                                  ),
                                  child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Image.network(
                                            snapshot.data!.docs[index]['icon']!,
                                          width: 40,
                                        ),
                                      )
                                  ),
                                ),
                              );
                            }
                        ),
                      );
                    }
                  }
              ),


              //Recent Product
              const SizedBox(
                height: 10.0,
              ),
              const Text('Recent Products',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
             StreamBuilder(
                 stream: firestore.collection('products').snapshots(),
                 builder: (context,snapshot){
                   if(snapshot.connectionState == ConnectionState.waiting){
                     return const Center(
                       child: CircularProgressIndicator(),
                     );
                   }else{
                    return GridView.builder(
                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 2,
                           crossAxisSpacing: 15,
                           mainAxisSpacing: 15,
                         ),
                         itemCount: snapshot.data!.docs.length,
                         shrinkWrap: true,
                         primary: false,
                         itemBuilder: (context, index) {
                           final data = snapshot.data!.docs[index];
                           return InkWell(
                             onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(products: data,)));
                             },
                             child: Container(
                                 height: 250.0,
                                 decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     color: const Color(0xFFD8D3F2),
                                     border: Border.all(
                                         color: Color(0xFFD8D3D3)
                                     )
                                 ),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                       children: [
                                         Container(
                                           height: 35,
                                           width: 80,
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(10),
                                               color: Color(0xFFD8D3F2),
                                               border: Border.all(
                                                   color: Color(0xFFD8D3D3)
                                               )
                                           ),
                                           child: Text("${data['oofPercentage']!}% Off",
                                             style: const TextStyle(
                                                 color: Colors.black,
                                                 fontSize: 15.0,
                                                 fontWeight: FontWeight.w600
                                             ),
                                           ),
                                         ),
                                         IconButton(
                                             onPressed: () {},
                                             icon: Icon(Icons.favorite_border)
                                         )
                                       ],
                                     ),
                                     Image.network(data['image']!,
                                       height: 60,
                                       width: double.infinity,
                                     ),
                                     Padding(
                                       padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(data['name']!,
                                             style: const TextStyle(
                                               color: Colors.black,
                                               fontSize: 15.0,
                                             ),
                                             maxLines: 1,
                                             overflow: TextOverflow.ellipsis,
                                           ),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text('\$${data['newPrice']!}',
                                                 style: const TextStyle(
                                                     color: Colors.black,
                                                     fontSize: 15.0,
                                                     fontWeight: FontWeight.bold
                                                 ),
                                               ),
                                               Text('\$${data['oldPrice']!}',
                                                 style: const TextStyle(
                                                   color: Colors.black,
                                                   fontSize: 13.0,
                                                   decoration: TextDecoration.lineThrough,
                                                 ),
                                               ),
                                             ],
                                           ),

                                         ],
                                       ),
                                     )
                                   ],
                                 )
                             ),
                           );
                         }
                     );
                   }
                 }
             )


            ],
          ),
        ),
      ),
    );
  }
}
