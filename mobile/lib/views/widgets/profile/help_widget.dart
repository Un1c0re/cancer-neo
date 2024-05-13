import 'package:cancerneo/utils/app_widgets.dart';
import 'package:cancerneo/utils/constants.dart';
import 'package:flutter/material.dart';

class HelpWidget extends StatelessWidget {
  const HelpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DeviceScreenConstants.screenHeight * 0.9,
      child: const AppStyleCard(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Документы',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  '- Выберите тип документа;\n'
                  '- Добавтье документ выбранного типа;',
                  style: TextStyle(fontSize: 20),
                ),
                Image(
                  image: AssetImage('assets/images/docs_add.png'),
                ),
                Text(
                  '- Загрузите pdf или изображение документа;\n'
                  '- Укажите название документа, дату получения и место выдачи.\n\n'
                  'Вы можете редактировать и удалять имеющиеся документы.\n'
                  'Вы можете отфильтровать отображаемый список документов по дате их получения.',
                  style: TextStyle(fontSize: 20),
                ),
                Image(
                  image: AssetImage('assets/images/docs_filter.png'),
                ),
                SizedBox(height: 20),

                ///////////////////////////////////////////////////////////////

                Text(
                  'Контроль',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Симптомы делятся на следующие категории:\n'
                  '\t • Условные (низкая, средняя, высокая степень проявления);\n'
                  '\t • Двухуровневые (либо есть, либо нет);\n'
                  '\t • Численные (нужно вводить число);\n'
                  '\t • Маркеры (специфичные показатели для пациента);\n'
                  '\t • Пользовательские (Численные симптомы, добавленные пользователем).\n\n'
                  'Если вы пропустили день, вы можете его выбрать в верхней панели приложения.',
                  style: TextStyle(fontSize: 20),
                ),
                Image(
                  image: AssetImage('assets/images/control_filter.png'),
                ),
                Text(
                  'Пользовательские симптомы можно редактировать (изменить имя), либо удалить вовсе.\n'
                  'В самом низу страницы вы можете вести заметки за текущий день.\n'
                  'Отмечайте симптомы каждый день, чтобы прослеживать изменения в своем самочувствии в разделе ДИНАМИКА.\n',
                  style: TextStyle(fontSize: 20),
                ),

                ///////////////////////////////////////////////////////////////

                Text(
                  'Динамика',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  '- На экране динамики отображаются графики симптомов и маркеров, отмечаемых вами в разделе КОНТРОЛЬ;\n'
                  '- Каждая "карточка" графика отображает лишь часть симптомов. '
                  'Чтобы посмотреть остальные, необходимо использоваь переключатель в левом верхнем углу "карточки";',
                  style: TextStyle(fontSize: 20),
                ),
                Image(
                  image: AssetImage('assets/images/dynamic_card.png'),
                ),
                Text(
                  '- Вы можете выбрать, за какой месяц просмотреть динамику;',
                  style: TextStyle(fontSize: 20),
                ),
                Image(
                  image: AssetImage('assets/images/dynamic_filter.png'),
                ),
                Text(
                  '- Графики с численными симптомами не всегда информативны. '
                  'Но вы можете зажать выбранную точку на графике и увидеть, какое число она означает;',
                  style: TextStyle(fontSize: 20),
                ),
                Image(
                  image: AssetImage('assets/images/dynamic_numchart.png'),
                ),
                Text(
                  '- Нажмите на кнопку ЭКСПОРТ ОТЧЕТА внизу страницы, '
                  'чтобы сформироать документ, ссылку и qr-код на него, за выбранный вами месяц.\n'
                  '- По сформированной ссылке и qr-коду документ доступен в течение двух недель.\n',
                  style: TextStyle(fontSize: 20),
                ),

                ///////////////////////////////////////////////////////////////
                
                Text(
                  'Все о НЭО',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Информационный раздел приложения. '
                  'В нем вы можете узнать больше о своем заболевании и о том, как с ним справляться.\n'
                  'ВНИМАНИЕ: раздел недоступен без подключения к интернету.\n',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Профиль',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                ///////////////////////////////////////////////////////////////
                
                Text(
                  'В профиле содержится информация о пациенте: ФИО, дата рождения, история болезни, история лечения. '
                  'Информацию о пациенте нужно заполнить самостоятельно!\n'
                  'Также в профиле доступен список сообществ и организаций, которые оказывают поддержку пациентам с НЭО.\n',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          )),
    );
  }
}
