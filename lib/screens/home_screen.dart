import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_app/Universals/floatingActionButton.dart';
import 'package:grocery_app/providers/auth_provider.dart';
import 'package:grocery_app/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  static const String id = 'home-screen';
  @override
  Widget build(BuildContext context) {

    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 500,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Images/banner.jpg'),
                  fit: BoxFit.cover
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    colors: [
                      Colors.black.withOpacity(.8),
                      Colors.black.withOpacity(.2)
                    ]
                  )
                ),
             width: 500,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     'Our New Products',
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 40.0,
                       fontWeight: FontWeight.bold
                     ),
                   ),
                 Padding(
                   padding: const EdgeInsets.only(bottom: 15.0),
                   child: Row(
                     children: [
                       TextButton(
                         onPressed: (){

                         },
                         child: Text('Explore',
                         style: TextStyle(
                           color: Colors.white,
                           fontSize: 20.0
                         ),
                         ),
                       ),
                       IconButton(
                           icon: Icon(
                             Icons.arrow_forward_ios,
                             color: Colors.white,
                           ), onPressed: (){

                       })
                     ],
                   ),
                 )
                 ],
               ),
             ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    TextButton(
                      onPressed:(){

                      },
                        child: Text('All'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  makeCategory(
                    image: 'Images/product1.jpg',
                    title: 'Shoes'
                  ),

                  makeCategory(
                      image: 'Images/product1.jpg',
                      title: 'Shoes'
                  ),

                  makeCategory(
                      image: 'Images/product1.jpg',
                      title: 'Shoes'
                  ),

                  makeCategory(
                      image: 'Images/product1.jpg',
                      title: 'Shoes'
                  ),

                  makeCategory(
                      image: 'Images/product1.jpg',
                      title: 'Shoes'
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    TextButton(
                      onPressed:(){

                      },
                      child: Text('All'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  makeCategory(
                      image: 'Images/product1.jpg',
                      title: 'Shoes'
                  ),

                  makeCategory(
                      image: 'Images/product1.jpg',
                      title: 'Shoes'
                  ),

                  makeCategory(
                      image: 'Images/product1.jpg',
                      title: 'Shoes'
                  ),

                  makeCategory(
                      image: 'Images/product1.jpg',
                      title: 'Shoes'
                  ),

                  makeCategory(
                      image: 'Images/product1.jpg',
                      title: 'Shoes'
                  )
                ],
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
      floatingActionButton: FloatingButton()
    );
  }
  Widget makeCategory({image, title}){
    return AspectRatio(
      aspectRatio: 2 / 2.2,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover
          )
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.0),
              ]
            )
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
            ),
          ),
        ),
      ),
    );
  }
}
