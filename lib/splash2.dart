import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
 
void main() => runApp(Splash2());
 
class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: '/',
      // title: new Text('cupping',textScaleFactor: 5.5,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontFamily: 'AkzidenzGrotesk',),),
      image: Image.network('https://lh3.googleusercontent.com/proxy/f7AuVYmeD0RSLa0b-qFYTlgQUkqSNNWEdNdE8JwzWr_hEmi5rn07_aSyVaWrwTVKIT_h8_4xy6PQ9qB-vQNGKcMAT9FFkAXQxzaHGBw_PeYIpXdcwHh1xvLKldQ',color: Color(0xff8BB4F8),),
      imageBackground: NetworkImage('https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/rm23-adj-04_1.jpg?w=800&dpr=1&fit=default&crop=default&q=65&vib=3&con=3&usm=15&bg=F4F4F3&ixlib=js-2.2.1&s=e9aabdabb520c3be75e9e5b2c8c96840',),
      photoSize: 150.0,
      loaderColor: Color(0xff5DB5C1),
    );
  }
}