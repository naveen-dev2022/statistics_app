import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartpointer/app/modules/accounts/controllers/accounts_controller.dart';
import 'package:smartpointer/app/modules/accounts/models/accounts_model.dart';
import 'package:smartpointer/values/utils/reusable_components.dart';

class AccountDetailsBlock extends StatelessWidget {
  AccountDetailsBlock(
      {Key? key, this.data, this.BGColor, this.cardType, this.controller})
      : super(key: key);

  ResponseData? data;
  Color? BGColor;
  Color? cardType;
  AccountsController? controller;

  Widget detailBuilder(String? title, String? subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppWidgets.buildText(
            text: title!.toUpperCase(),
            fontSize: 11,
            color: Colors.grey.shade400,
            fontFamily: 'montserrat_regular'),
        const SizedBox(
          height: 3,
        ),
        AppWidgets.buildText(text: subtitle, fontSize: 12),
        const SizedBox(
          height: 2,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: SizedBox(
        height: currentOrientation == Orientation.portrait
            ? height / 3.6
            : height / 1.6,
        width: width,
        child: Card(
          color: BGColor,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 22,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/account.png'),
                      backgroundColor: Colors.transparent,
                      radius: 30,
                    ),
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22),
                    child: Container(
                      decoration: BoxDecoration(
                          color: cardType,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12),
                          )),
                      height: 50,
                      width: width / 2.5,
                      child: Center(
                        child: AppWidgets.buildText(
                            text: data!.cardType!.toUpperCase(),
                            fontSize: 13,
                            color: const Color.fromRGBO(93, 122, 196, 1.0)),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              SizedBox(
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: AppWidgets.buildText(
                        text: data!.name!.toUpperCase(),
                        fontSize: 18,
                        fontFamily: 'montserrat_bold'),
                  )),
              const SizedBox(
                height: 3,
              ),
              SizedBox(
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: AppWidgets.buildText(
                        text: data!.email,
                        fontSize: 12,
                        color: Colors.grey.shade400,
                        fontFamily: 'montserrat_regular'),
                  )),
              const SizedBox(
                height: 3,
              ),
              SizedBox(
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: AppWidgets.buildText(
                        text: data!.phone,
                        fontSize: 12,
                        color: Colors.grey.shade400,
                        fontFamily: 'montserrat_regular'),
                  )),
              Expanded(child: Container()),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    detailBuilder('DOB',
                        '${DateTime.parse(data!.dOB!).day} ${DateFormat.MMMM().format(DateTime.parse(data!.dOB!))} ${DateTime.parse(data!.dOB!).year}'),
                    detailBuilder('Card Features', data!.cardFeatures),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
