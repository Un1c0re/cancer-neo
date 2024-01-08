import 'package:diplom/frontend/Theme/app_widgets.dart';
import 'package:flutter/material.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({super.key});

  final String articleText = 'Lorem ipsum dolor sit amet\n\nconsectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nascetur ridiculus mus mauris vitae. Vestibulum mattis ullamcorper velit sed ullamcorper morbi tincidunt ornare. Suspendisse faucibus interdum posuere lorem. Vel facilisis volutpat est velit egestas dui id ornare. Venenatis a condimentum vitae sapien pellentesque. Ultrices eros in cursus turpis massa tincidunt dui ut. Nulla facilisi nullam vehicula ipsum a. Non quam lacus suspendisse faucibus interdum posuere lorem. Amet commodo nulla facilisi nullam vehicula ipsum. Eget magna fermentum iaculis eu non diam phasellus vestibulum lorem. Congue eu consequat ac felis donec. Molestie at elementum eu facilisis sed odio morbi quis. Tristique nulla aliquet enim tortor at. Tellus in metus vulputate eu scelerisque felis imperdiet proin fermentum. Aliquet eget sit amet tellus cras adipiscing enim eu. Ut tellus elementum sagittis vitae et leo duis. Nulla pharetra diam sit amet nisl suscipit. Id aliquet risus feugiat in ante metus dictum. Amet risus nullam eget felis eget. Eget lorem dolor sed viverra. Purus ut faucibus pulvinar elementum integer. A arcu cursus vitae congue mauris rhoncus. Purus sit amet luctus venenatis lectus. Mi bibendum neque egestas congue quisque egestas diam. Dolor morbi non arcu risus quis varius quam quisque. Faucibus nisl tincidunt eget nullam non nisi est sit. Nulla facilisi nullam vehicula ipsum a arcu cursus vitae congue. Platea dictumst vestibulum rhoncus est pellentesque elit ullamcorper. Mauris commodo quis imperdiet massa. Mollis nunc sed id semper risus in. Arcu risus quis varius quam quisque. Risus commodo viverra maecenas accumsan lacus vel facilisis volutpat. Pulvinar neque laoreet suspendisse interdum. Aliquet eget sit amet tellus cras. Porttitor rhoncus dolor purus non enim praesent elementum facilisis leo. Scelerisque mauris pellentesque pulvinar pellentesque. Proin sagittis nisl rhoncus mattis rhoncus urna. Sed risus ultricies tristique nulla aliquet enim. Vitae aliquet nec ullamcorper sit amet risus. At volutpat diam ut venenatis tellus. Est ultricies integer quis auctor elit sed vulputate. Commodo sed egestas egestas fringilla phasellus faucibus scelerisque. Faucibus scelerisque eleifend donec pretium vulputate sapien nec.';

  @override
  Widget build(BuildContext context) {
    return AppStyleCard(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Text(
          articleText, 
          softWrap: true, 
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}