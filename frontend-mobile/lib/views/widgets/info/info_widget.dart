import 'dart:math';

import 'package:diplom/utils/app_colors.dart';
import 'package:diplom/utils/app_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_style.dart';
import '../../screens/article/article_screen.dart';

class InfoData {
  final String label;
  final String subLabel;
  final List<String> article;

  InfoData(
      {required this.label, required this.subLabel, required this.article});
}

class InfoWiget extends StatefulWidget {
  const InfoWiget({super.key});

  @override
  State<InfoWiget> createState() => _InfoWigetState();
}

class _InfoWigetState extends State<InfoWiget> {
  final int min = AppConstants.minColorValue;
  final int diff = AppConstants.diffColorValue;

  final List<InfoData> infoData = [
    InfoData(
      label: 'Что такое НЭО?',
      subLabel: 'Особенности заболевания',
      article: [
        'Чем отличается НЭО?'
        'Как ставится диагноз?',
        'Почему оно появляется?',
        'Когда  стоит подозревать заболевание?',
      ],
    ),
    InfoData(
      label: 'Где можно получить лечение?',
      subLabel: 'Медицинские учредения, дающие необходимое лечение',
      article: [
        'Сделать КТ',
        'Сдать МРТ',
        'Пройти курс химиотерапии',
        'Получить лекарства',
        ],
    ),
    InfoData(
      label: 'Мне нужна поддержка',
      subLabel: 'Психологические аспекты заболевания',
      article: [
        'Кружки онкобольных',
        'Специализированные психологи',
        'Специальная литература'
      ],
    ),
    InfoData(
      label: 'Как получить помощь',
      subLabel: 'Сайты и учреждения, дающие социальную помощь',
      article: [
        'Фонд помощи онкобольным',
        'Онкологическое сообщество',
        'Сайт министерства здравоохранения',
      ],
    ),
    InfoData(
      label: 'Виды НЭО',
      subLabel: 'Какие виды заболевания встречаются у людей',
      article: [
        'Список заболеваний по МКБ',
        'Частота встречи заболевания',
      ],
    ),
  ];

  Color bgRandomizer() {
    return Color.fromRGBO(
      min + Random().nextInt(diff),
      min + Random().nextInt(diff),
      min + Random().nextInt(diff),
      1,
    );
  }

  Color textRandomizer() {
    return Color.fromRGBO(
      Random().nextInt(diff),
      Random().nextInt(diff),
      Random().nextInt(diff),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Инфо'),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: infoData.length,
          itemBuilder: (BuildContext conterxt, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: _InfoSpaceWidget(
                cardColor: bgRandomizer(),
                textColor: textRandomizer(),
                label: infoData[index].label,
                subLabel: infoData[index].subLabel,
                articles: infoData[index].article,
              ),
        
            );
          },
        ),
      ),
    );
  }
}

class _InfoSpaceWidget extends StatelessWidget {
  final Color cardColor;
  final Color textColor;
  final String label;
  final String subLabel;
  final List<String> articles;

  const _InfoSpaceWidget({
    required this.cardColor,
    required this.textColor,
    required this.label,
    required this.subLabel,
    required this.articles,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.activeColor,
          ),
        ),
        Text(
          subLabel,
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.activeColor,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 110,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  child: _InfoCardWidget(
                    title: articles[index],
                    textColor: textColor,
                    cardColor: cardColor,
                  ),
                );
              }),
        )
      ],
    );
  }
}

class _InfoCardWidget extends StatelessWidget {
  final String title;
  final Color textColor;
  final Color cardColor;

  const _InfoCardWidget({
    super.key,
    required this.title,
    required this.textColor,
    required this.cardColor,
  });

  void _getToArticle() {
    Get.to(() => const ArticleScreen());
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 110,
        maxWidth: 150,
      ),
      child: Stack(
        children: [
          AppStyleCard(
            backgroundColor: cardColor,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  color: textColor,
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _getToArticle,
              overlayColor:
                  const MaterialStatePropertyAll(AppColors.overlayColor),
              splashColor: AppColors.splashColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
