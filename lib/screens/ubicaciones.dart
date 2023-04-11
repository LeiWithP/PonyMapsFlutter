import 'package:flutter/material.dart';
import 'package:ponymapscross/cards/ubicacionCard.dart';


class Ubicaciones extends StatelessWidget {
  final List<Map<String, String>> items;

  const Ubicaciones({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return UbicacionCard(
          title: items[index]['building'] ?? 'Desconocido', // Use the 'name' value as the title
          subtitle: items[index]['name'] ?? '', // Use the 'description' value as the subtitle
          areas: items[index]['areas'] ?? '0 - Direccion\n1 - Departamento De Vinculacion\n2 - Oficina De Oficialidad Paqueteria\n3 - Departamento De Desarrollo Academico\n4 - Recursos Humanos\n5 - Servicio Medico\n6 - Departamento De Servicios Escolares\n7 - Departamento de Comunicacion y Difusion\n8 - Recursos Financieros\n9 - DEP: Division de Estudios Profesionales\n10 - DEPI: Division de Estudios de Posgrado e Investigacion"',
          imagePath: 'assets/pony_plaza.jpg',
        );
      },
    );
  }
}
