import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:jabwemate/Widgets/appbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int number = 0;
  int max = 10;
  List<String> welcomeImages = [
    'http://im.rediff.com/movies/2013/dec/13hrithik-sussanne-roshan1.jpg',
    'https://i.pinimg.com/originals/10/86/d8/1086d89ff82d597b945814ea6b58c595.jpg',
    'https://i2-prod.mirror.co.uk/incoming/article18766833.ece/ALTERNATES/s615/0_wedding-MAIN.jpg',
    'https://archive.mid-day.com/photos/plog-content/images/b-town-specials/shaadi-no.-1-the-big-fat-weddings-of-bollywood-stars/akshay-twinkle.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTtxWTrM-y5D4VkNeeevrHhY335gXMk0YCrMg&usqp=CAU',
    'https://1.bp.blogspot.com/-X0v_Lc2mX48/Tc2IjzaXaVI/AAAAAAAAAWM/8sBWlSeb13Q/s1600/Farah+Khan+%2526+Shirish+Kunder+Marriage+Ever+Seen+3.jpg',
    'https://st1.photogallery.ind.sh/wp-content/uploads/indiacom/karisma-kapoor-married-sunjay-kapoor-in-2003-201703-1489737366.jpg',
    'https://celebritynews.pk/wp-content/uploads/2019/10/Aamir-Khan-wedding-photos-6.jpg',
    'https://www.cheatsheet.com/wp-content/uploads/2018/04/Melania-Trump-walking-down-the-aisle-with-Donald-Trump.png',
    'https://i.pinimg.com/originals/c1/44/2a/c1442afb556ebc8147388605e86ddebc.jpg',
    'https://media.weddingz.in/images/2937cdee5d8d6c5f2d958dacdd202658/the-yuvraj-hazel-wedding-affair-all-you-want-to-know.jpg',
    'https://static.topyaps.com/wp-content/uploads/2018/05/son.png',
    'https://images.indianexpress.com/2018/11/deepika-ranveer-new-1.jpg',
    'https://media.weddingz.in/images/291c7117558af75d73bb6f6785c047ca/priyanka-chopra-and-nick-jonass-wedding-date-and-venue-are-out-and-i-cant-keep-calm.jpg',
    'https://cdn.images.express.co.uk/img/dynamic/106/750x445/931966.jpg',
    'https://media.architecturaldigest.in/wp-content/uploads/2017/12/Virushka-Wedding-Decor-866x487.jpg',
    'https://images.news18.com/ibnlive/uploads/2019/12/Manish-Pandey-Ashrita-Shettys-Wedding-Pictures-8.jpg?impolicy=website&width=400&height=0',
    'https://i.pinimg.com/originals/6d/43/01/6d4301f342637b296f017a07a96e7365.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    CardController controller;
    return new Scaffold(
      backgroundColor: Color(0xFFEFF7F6),
      appBar: CustomAppBar(),
      body: Column(
        children: <Widget>[
          Spacer(),
          Container(
            height: width,
            child: new TinderSwapCard(
              orientation: AmassOrientation.TOP,
              totalNum: 11,
              stackNum: 3,
              swipeEdge: 4.0,
              maxWidth: width * 0.9,
              maxHeight: width * 0.9,
              minWidth: width * 0.8,
              minHeight: width * 0.8,
              cardBuilder: (context, index) => Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      height: width * 0.65,
                      width: width * 0.9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                        child: Image.network(
                          '${welcomeImages[index]}',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              cardController: controller = CardController(),
              swipeUpdateCallback:
                  (DragUpdateDetails details, Alignment align) {
                /// Get swiping card's alignment
                if (align.x < 0) {
                  //Card is LEFT swiping
                } else if (align.x > 0) {
                  //Card is RIGHT swiping
                }
              },
              swipeCompleteCallback:
                  (CardSwipeOrientation orientation, int index) {
                /// Get orientation & index of swiped card!
                setState(() {
                  number = index;
                });
                print(orientation.toString());
                print(index.toString());
              },
            ),
          ),
          Spacer(),
          Text('Swipes Left-  ${max - number}'),
          SizedBox(
            height: width * 0.1,
          )
        ],
      ),
    );
  }
}
