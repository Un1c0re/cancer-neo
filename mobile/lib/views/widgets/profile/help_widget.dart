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
              children: [
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Elementum tempus egestas sed sed risus pretium quam vulputate dignissim. In fermentum posuere urna nec. Imperdiet nulla malesuada pellentesque elit eget gravida. Mauris vitae ultricies leo integer malesuada nunc. Quis risus sed vulputate odio ut. Nibh venenatis cras sed felis eget velit aliquet. Posuere urna nec tincidunt praesent semper. Interdum consectetur libero id faucibus nisl tincidunt eget nullam. Ultrices in iaculis nunc sed. Ac tortor dignissim convallis aenean et tortor. Scelerisque felis imperdiet proin fermentum leo vel orci porta. Et tortor consequat id porta nibh venenatis. Lobortis feugiat vivamus at augue eget arcu dictum varius duis. Orci a scelerisque purus semper eget.Venenatis tellus in metus vulputate eu scelerisque felis imperdiet. Morbi tempus iaculis urna id volutpat lacus laoreet non curabitur. Egestas integer eget aliquet nibh praesent. A iaculis at erat pellentesque adipiscing commodo elit at. Eu turpis egestas pretium aenean pharetra magna ac placerat vestibulum. Nec feugiat nisl pretium fusce id. Sed odio morbi quis commodo odio. Enim eu turpis egestas pretium aenean. Neque aliquam vestibulum morbi blandit cursus risus at ultrices mi. Eleifend quam adipiscing vitae proin sagittis nisl rhoncus mattis. Ornare quam viverra orci sagittis eu volutpat. Aenean euismod elementum nisi quis eleifend. Feugiat nibh sed pulvinar proin. Ipsum dolor sit amet consectetur adipiscing. Non diam phasellus vestibulum lorem. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc consequat. Eget mi proin sed libero enim sed. Faucibus purus in massa tempor nec feugiat nisl. Eleifend mi in nulla posuere sollicitudin aliquam ultrices sagittis. Facilisi etiam dignissim diam quis enim. Vitae justo eget magna fermentum iaculis eu non diam phasellus. Tellus cras adipiscing enim eu turpis egestas. Egestas congue quisque egestas diam. Commodo ullamcorper a lacus vestibulum sed arcu non. Gravida quis blandit turpis cursus in hac. Platea dictumst vestibulum rhoncus est pellentesque elit ullamcorper dignissim. Curabitur vitae nunc sed velit dignissim sodales ut eu sem. Elit ullamcorper dignissim cras tincidunt lobortis feugiat vivamus at augue. Aliquam purus sit amet luctus venenatis. Rhoncus urna neque viverra justo. Sed blandit libero volutpat sed cras ornare. Tortor condimentum lacinia quis vel eros donec ac. Diam volutpat commodo sed egestas. Quam id leo in vitae turpis. Neque sodales ut etiam sit amet nisl purus in mollis. Euismod in pellentesque massa placerat duis. Ipsum faucibus vitae aliquet nec ullamcorper sit amet risus. Velit egestas dui id ornare arcu odio ut sem. Nisi lacus sed viverra tellus in hac habitasse platea. Fermentum leo vel orci porta non pulvinar neque laoreet. Vel facilisis volutpat est velit. At urna condimentum mattis pellentesque id. Leo vel fringilla est ullamcorper. Facilisis leo vel fringilla est ullamcorper eget nulla. Dictumst quisque sagittis purus sit. Ut eu sem integer vitae justo eget magna. Nunc pulvinar sapien et ligula ullamcorper malesuada. Lorem dolor sed viverra ipsum nunc aliquet bibendum enim facilisis. Tincidunt nunc pulvinar sapien et ligula ullamcorper malesuada. Dolor sed viverra ipsum nunc aliquet bibendum enim facilisis gravida. A lacus vestibulum sed arcu non odio euismod lacinia at. Morbi leo urna molestie at elementum eu facilisis sed. Faucibus ornare suspendisse sed nisi lacus sed viverra tellus. Sed vulputate mi sit amet mauris commodo. Pellentesque habitant morbi tristique senectus et netus et. Senectus et netus et malesuada. Commodo elit at imperdiet dui accumsan sit amet nulla facilisi. Pellentesque diam volutpat commodo sed. Justo eget magna fermentum iaculis eu. A erat nam at lectus urna duis convallis convallis tellus. Sit amet luctus venenatis lectus magna fringilla urna.',
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
