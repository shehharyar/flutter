import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import "../widgets/app_drawer.dart";
import './edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "/user-products";
  const UserProductsScreen({super.key});
Future<void> _refreshProducts(BuildContext context) async{
  await Provider.of<Products>(context, listen: false).fetchAndSetProduct();
}
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      // backgroundColor: Color.fromARGB(255, 83, 83, 83),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh:() => _refreshProducts(context) ,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (_, i) => Column(
              children: [
                UserProductItem(
                   productData.items[i].id!,
                    productData.items[i].title, productData.items[i].imageUrl),
                const Divider(),
              ],
            ),
            itemCount: productData.items.length,
          ),
        ),
      ),
    );
  }
}
