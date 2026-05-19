import 'package:flutter/material.dart';
import 'package:flutter_app/views/widgets/textField.dart';
import 'package:flutter_app/services/firebase_service.dart';


class AddPromocionesPage extends StatefulWidget{
  const AddPromocionesPage({super.key});

  @override
  State<AddPromocionesPage> createState() => _AddPromocionPageState();
  }

class _AddPromocionPageState extends State<AddPromocionesPage> {
  TextEditingController tituloEditingController = TextEditingController();
  TextEditingController descripcionEditingController = TextEditingController();
  TextEditingController fechaEditingController = TextEditingController();
  TextEditingController estadoEditingController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva promocion'),
      ),
      body: Column(
        children: [
          TextFieldInput(
            textEditingController: tituloEditingController,
            hintText: 'Ingresar titulo',
            isPass: false,
          ),
          TextFieldInput(
            textEditingController: descripcionEditingController,
            hintText: 'Ingresar descripcion',
            isPass: false,
          ),
          TextFieldInput(
            textEditingController: fechaEditingController,
            hintText: 'Ingresar fecha',
            isPass: false,
          ),
          TextFieldInput(
            textEditingController: estadoEditingController,
            hintText: 'Ingresar estado',
            isPass: false,
          ),
          ElevatedButton(onPressed:() async {
            await addPromocion({
              'Titulo': tituloEditingController.text,
              'Descripcion': descripcionEditingController.text,
              'Fecha': fechaEditingController.text,
              'Estado': estadoEditingController.text
            });
          }, child: const Text('Guardar'))
        ]
      ),
    );
  }
}





// class _AddPromocionPageState extends State<AddPromocionesPage> {
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Nueva promocion'),
//       ),
//       body: Column(
//         children: [
//           const TextField(
//             decoration: InputDecoration(
//               hintText: 'Ingresar titulo',
//             ),
//           ),
//           ElevatedButton(onPressed:(){}, child: const Text('Guardar'))
//         ]
//       ),
//     );
//   }
// }
