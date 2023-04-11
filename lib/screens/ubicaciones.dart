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
          areas: items[index]['areas'] ?? '- Direccion\n- Departamento De Vinculacion\n- Oficina De Oficialidad Paqueteria\n- Departamento De Desarrollo Academico\n- Recursos Humanos\n- Servicio Medico\n- Departamento De Servicios Escolares\n- Departamento de Comunicacion y Difusion\n- Recursos Financieros\n- DEP: Division de Estudios Profesionales\n- DEPI: Division de Estudios de Posgrado e Investigacion"',
          imagePath: 'assets/pony_plaza.jpg',
        );
      },
    );
  }
}
