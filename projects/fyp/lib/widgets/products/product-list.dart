
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fyp/provider/cart.dart';
// import 'package:fyp/provider/cart.dart';
import 'package:fyp/widgets/products/product-item.dart';

// class ProductList extends StatefulWidget {
//  ProductList({super.key});

//   @override
//   State<ProductList> createState() => _ProductListState();
// }

// class _ProductListState extends State<ProductList> {
//  DatabaseReference dbRef= FirebaseDatabase.instance.ref('products');
// bool _isLoadng= false;
// // final Stream<List<Product>> Function() getProductsStream;
//   @override
//   Widget build(BuildContext context) {
    

//     // if(_isLoadng){
//     //   return Center(child: const CircularProgressIndicator());
//     // }
//     return FirebaseAnimatedList(query: dbRef, itemBuilder: (context, snapshot, animation, index) {
//             return ProductItem(id: snapshot.child('id').value.toString(), 
//             title: snapshot.child('title').value.toString(), 
//             cost: snapshot.child('Cost').value.toString(),
//             price: snapshot.child('price').value.toString(), 
//             imageUrl: snapshot.child('imageUrl').value.toString());
//   }
//   ); 
     
          
//       }
// }



class ProductList extends ConsumerStatefulWidget {
  const ProductList({super.key, required this.shopId });
  final String shopId;
  @override
  ConsumerState<ProductList> createState() => _ProductListState();
}

class _ProductListState extends ConsumerState<ProductList> {
 DatabaseReference data= FirebaseDatabase.instance.ref();
     void _confirmDelete(BuildContext context, String productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this product?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteProduct(productId);
                Navigator.of(context).pop();
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _deleteProduct(String productId) {
    DatabaseReference productRef = FirebaseDatabase.instance.ref('products').child(productId);
    productRef.remove();
  }
  

  @override
  Widget build(BuildContext context) {
    final Carts =ref.watch(cartProvider.notifier);
    print("Shop Id ==> " + widget.shopId);
    return StreamBuilder(stream: data.child('products').orderByChild('shopId').equalTo(widget.shopId).onValue, builder: (context, productSnapshots) {
        if( productSnapshots.connectionState == ConnectionState.waiting ){
            return const Center(
              child: CircularProgressIndicator(
              ),
            );
}

if (!productSnapshots.hasData || productSnapshots.data!.snapshot.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Image.asset(
                    'assets/images/products-fallback.png',
                    fit: BoxFit.cover,
                  ),
                ),
              const Text(
                  "No Products added yet. Try adding some",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sans Serif',
                    color: Color.fromARGB(255, 239, 154, 154),
                  ),
                ),
              ],
            ),
          );
        }
      if(! productSnapshots.hasData ||  productSnapshots.data!.snapshot.value == null){
        return const Center( 
          child: Text("No Products added yet!."),);
      }
      if(productSnapshots.hasError){
        return const Center(
          child: Text("Something went wrong!"),
        );
      }
     

       
        final data = productSnapshots.data!.snapshot.value;
        final List<dynamic> loadedProducts = data == null ? [] : List.from((data as Map<dynamic, dynamic>).values);

      // print(productData);

     
    //     final List<Map<Object, Object>> loadedProducts =
    //         productData != null ? List.from(productData as Iterable) : [];
    return ListView.builder(itemBuilder: (ctx, i) => 
    ProductItem(id: loadedProducts[i]['id'] as String? ?? '', 
    title:loadedProducts[i]['title']as String? ?? '', 
    stock: loadedProducts[i]['stock'].toString(),
    cost: loadedProducts[i]['Cost']as String? ?? '', 
    others:loadedProducts[i]['Others'] as String? ?? "",
    price: loadedProducts[i]['price']as String? ?? '', imageUrl: loadedProducts[i]['imageUrl']as String? ?? '',
    onLongPress: () => _confirmDelete(context,loadedProducts[i]['id']),
    ),
    
    itemCount: loadedProducts.length,
    );
       }
    
    );
  }
}