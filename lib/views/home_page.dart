
import 'package:flutter/material.dart';
import 'package:flutter_app/services/firebase_service.dart';


class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Flutter + Firebase'),
      ),
      body: FutureBuilder(
          future: getPromociones(),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              return ListView.builder(itemCount: snapshot.data?.length,
              itemBuilder: ((context, index) {
                return Text(snapshot.data?[index]['Titulo']);
              }));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),),
    );
  }
}
