import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  const Carousel({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CarouselSlider(
          items: [
            //1st Image of Slider
            Container(
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                    spreadRadius: 8.00,
                    offset: Offset(
                      20,
                      20,
                    ),
                  )
                ],
                image: const DecorationImage(
                    image: NetworkImage(
                        'https://uploads-ssl.webflow.com/5be759f8b95161d833ce8139/617980507e74a181607b1b6b_Guest%20Post%20Templates-128.png'),
                    fit: BoxFit.cover,
                    scale: 1),
              ),
            ),

            //2nd Image of Slider
            Container(
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                    spreadRadius: 8.00,
                    offset: Offset(
                      20,
                      20,
                    ),
                  )
                ],
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://uploads-ssl.webflow.com/5be759f8b95161d833ce8139/617980507e74a181607b1b6b_Guest%20Post%20Templates-128.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //3rd Image of Slider
            Container(
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                    spreadRadius: 8.00,
                    offset: Offset(
                      20,
                      20,
                    ),
                  )
                ],
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://uploads-ssl.webflow.com/5be759f8b95161d833ce8139/617980507e74a181607b1b6b_Guest%20Post%20Templates-128.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //4th Image of Slider
            Container(
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0,
                    spreadRadius: 8.00,
                    offset: Offset(
                      20,
                      20,
                    ),
                  )
                ],
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://uploads-ssl.webflow.com/5be759f8b95161d833ce8139/617980507e74a181607b1b6b_Guest%20Post%20Templates-128.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //5th Image of Slider
            Container(
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 219, 219, 219),
                    blurRadius: 10.0,
                    spreadRadius: 8.00,
                    offset: Offset(
                      20,
                      20,
                    ),
                  )
                ],
                image: const DecorationImage(
                    image: NetworkImage(
                        'https://uploads-ssl.webflow.com/5be759f8b95161d833ce8139/617980507e74a181607b1b6b_Guest%20Post%20Templates-128.png'),
                    fit: BoxFit.cover,
                    scale: 1.0),
              ),
            ),
          ],

          //Slider Container properties
          options: CarouselOptions(
            height: 180.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
        ),
      ],
    );
  }
}
