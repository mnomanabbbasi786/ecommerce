import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecommerce/database/CategoryRepostry.dart';
import 'package:ecommerce/provider/CategoryProvider.dart';
import 'package:ecommerce/screens/home/components/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';

class Categories extends StatelessWidget {

  List<String> icon = [
    'assets/icons/drinks.svg',
    'assets/icons/technology.svg',
    'assets/icons/Shop Icon.svg',
    'assets/icons/Flash Icon.svg',
    'assets/icons/drinks.svg',
    'assets/icons/technology.svg',
    'assets/icons/Shop Icon.svg',
    'assets/icons/Flash Icon.svg',
    'assets/icons/drinks.svg',
    'assets/icons/technology.svg',
    'assets/icons/Shop Icon.svg',
    'assets/icons/Flash Icon.svg',
    'assets/icons/drinks.svg',
    'assets/icons/technology.svg',
    'assets/icons/Shop Icon.svg',
    'assets/icons/Flash Icon.svg',
    'assets/icons/drinks.svg',
    'assets/icons/technology.svg',
    'assets/icons/Shop Icon.svg',
    'assets/icons/Flash Icon.svg',
    'assets/icons/drinks.svg',
    'assets/icons/technology.svg',
    'assets/icons/Shop Icon.svg',
  ];


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),

      child: Column(
        children: [
          SectionTitle(title: "Categories", press: () {}),
          SizedBox(height: getProportionateScreenWidth(10)),
          FutureBuilder(
            future: CategoryRepostry.fetchCategory(),
            builder: (context,snapShot){
              if(snapShot.hasData){
                return SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapShot.data!.length,
                    itemBuilder: (context,index){
                      return CategoryCard(text: snapShot.data![index].name, press: (){},icon: icon[index]);
                    }
                  ),
                );
              }else{
                return Container();
              }
            }
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
   CategoryCard({
    Key? key,
    required this.text,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final String text;
  final GestureTapCallback press;
  String icon;

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async{
         await categoryProvider.setLength(categoryName: text);

          if(categoryProvider.length<20){

            categoryProvider.setProduct(categoryName: text, start: 0, end: categoryProvider.length);
          }else{
            categoryProvider.setProduct(categoryName: text, start: 0, end: 20);
          }


        },
        child: SizedBox(
          width: getProportionateScreenWidth(55),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                height: getProportionateScreenWidth(55),
                width: getProportionateScreenWidth(55),
                decoration: BoxDecoration(
                  color: Color(0xFFFFECDF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(icon),
              ),
              SizedBox(height: 5),
              AutoSizeText(text!, textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,)
            ],
          ),
        ),
      ),
    );
  }
}
