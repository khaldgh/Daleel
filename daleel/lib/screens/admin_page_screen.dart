import 'package:daleel/widgets/admin-page_widgets/admin_form_field.dart';
import 'package:daleel/widgets/home_widgets/image_card.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  static const routename = 'admin-page';
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'https://www.mysqltutorial.org/wp-content/uploads/2009/12/MySQL-create-trigger-example.jpg',
      'https://media.nationalgeographic.org/assets/photos/399/508/1e0e416d-c089-43a9-9c50-682a1ce9aa54.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQd3TOwHv78_ya1mWEvU05P7sUQZ7IJB6aSVA&usqp=CAU'
    ];
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text('title here'),
                leading:
                    CircleAvatar(backgroundImage: Image.network(images[index]).image),
                subtitle: Text('user here'),
                onTap: () {
                  Navigator.of(context).pushNamed(AdminFormField.routename);
                },
              )),
    );
  }
}
