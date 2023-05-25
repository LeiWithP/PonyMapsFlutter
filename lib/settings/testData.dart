const List<Map<String, String>> buildings = [
{"id": "1", "building": "A", "name": "Edificio Administrativo", "areas": '- Direccion\n- Departamento De Vinculacion\n- Oficina De Oficialidad Paqueteria\n- Departamento De Desarrollo Academico\n- Recursos Humanos\n- Servicio Medico\n- Departamento De Servicios Escolares\n- Departamento de Comunicacion y Difusion\n- Recursos Financieros\n- DEP: Division de Estudios Profesionales\n- DEPI: Division de Estudios de Posgrado e Investigacion' , "photo": 'assets/A.jpeg'},
{"id": "2", "building": "B", "name": "Laboratorio De Química Analítica", "photo": 'assets/B.jpeg'},
{"id": "3", "building": "C", "name": "Coordinación De Ingles", "areas": '- C1 C2 C3 C4 C5\n- Centro de lenguas extranjeras' ,"photo": 'assets/C.jpeg'},
{"id": "4", "building": "CH", "name": "Departamento De Ingeniera Industrial Y Bioquímica", "areas": '- CH1 CH2 CH3 CH4 CH5 CH6\n- Cubiculos Ingenieria Industrial\n- Capitulos Estudiantiles\n- Sala de Usos Multiples\n- Sala Memorial\n- Sala de Tutorias\n- Laboratorio de Ingenieria Industrial' , "photo": 'assets/CH.jpeg'},
{"id": "5", "building": "D", "name": "Laboratorio De Ingeniera Bioquímica", "areas": '- D1 D2 D3 D4 D5 D6', "photo": 'assets/D.jpeg'},
{"id": "6", "building": "E", "name": "Aulas Y Taller De Dibujo", "areas": '- E1 E2 E3 E4 E5 E6\n- Laboratorio de Dibujo Tecnico Mecanica', "photo": 'assets/E.jpeg'},
{"id": "7", "building": "F", "name": "Sala Audiovisual No. 1 Y Aulas", "areas": '- F1 F2 F3 F4 F5 F6\n- Sala Audiovisual\n- Oficina de Titulacion', "photo": 'assets/F.jpeg'},
{"id": "8", "building": "G", "name": "Laboratorio Ing. Mecánica Y Eléctrica", "areas": '- Laboratorio de Electrica\n- Laboratorio de Mecanica', "photo": 'assets/G.jpeg'},
{"id": "9", "building": "H", "name": "Unidad Deportiva Y Tribunas", "photo": 'assets/H.jpeg'},
{"id": "10", "building": "I", "name": "Departamento De Sistemas Y Computación", "areas": '- Nodo de Internet\n- Titulacion\n- Residencias Profesionales\n- Creditos Complementarios\n- Comision Dictaminadora\n- Jefatura Sistemas\n- Sala de Juntas\n- Cubiculos Sistemas\n- Laboratorio de Ingenieria de Software\n- Laboratorio de Tecnologias Web\n- Laboratorio de Redes', "photo": 'assets/I.jpeg'},
{"id": "11", "building": "J", "name": "Aulas De Titulación Y PADHIE", "areas": '- J0 J1 J2 J3\n- J4 - FAS\n- Sala 1 y 2\n- Campana de Titulacion', "photo": 'assets/J.jpeg'},
{"id": "12", "building": "K", "name": "Aulas Y Delegación Sindical", "areas": '- K1 K2 K3 K4 K5 K6 K7 K8 K9\n- Delegacion Sindical', "photo": 'assets/K.jpeg'},
{"id": "13", "building": "L", "name": "Aulas Licenciatura Administración", "areas": '- L1 L2 L3 L4 L5\n- L6 L7 L8 L9 L10 L11', "photo": 'assets/L.jpeg'},
{"id": "14", "building": "LL", "name": "Centro de Negocios", "areas": '- Sala A\n- Sala B\n- Sala C\n- Jefe de Departamento\n- Centro de Incubacion e Inovacion Empresarial\n- Oficina de Servicio Social y Desarrollo Comunitario', "photo": 'assets/LL.jpeg'},
{"id": "15", "building": "M", "name": "Departamento Económico Administrativo", "areas": '- M1 M2\n- Banco de Proyectos Licenciatura en Administracion\n- DEA Jefatura de Proyectos de Vinculacion\n- DCEA Depertamento de Ciencias Economico Administrativas', "photo": 'assets/M.jpeg'},
{"id": "16", "building": "N", "name": "Laboratorios De Ingeniería Bioquímica", "areas": '- Archivo De Concentracion\n- Laboratorio De Operaciones Unitarias\n- Departamento De Mantenimiento De Equipo', "photo": 'assets/N.jpeg'},
{"id": "17", "building": "Ñ", "name": "Laboratorio Instrumentación Analítica", "areas": '- Ñ1 Ñ2 Ñ3 Ñ4 Ñ5', "photo": 'assets/N_.jpeg'},
{"id": "18", "building": "O", "name": "Laboratorio Químico Biológico", "areas": '- Laboratorio De Bioquimica\n- Anexo Laboratorio Quimico Biologicas'},
{"id": "19", "building": "P", "name": "Laboratorio De Física", "areas": '- Laboratorio De Electromagnetismo\n- Laboratorio De Estatica Y Dinamica', "photo": 'assets/P.jpeg'},
{"id": "20", "building": "Q", "name": "Aulas Electrónica"},
{"id": "21", "building": "R", "name": "Cafetería", "photo": 'assets/R.jpeg'},
{"id": "22", "building": "S", "name": "Departamento De Recursos Materiales Y Servicios", "photo": 'assets/S.jpeg'},
{"id": "23", "building": "S1", "name": "Consejo Estudiantil", "photo": 'assets/S1.jpeg'},
{"id": "24", "building": "S2", "name": "Comedor para trabajadores", "photo": 'assets/S2.jpeg'},
{"id": "25", "building": "S3", "name": "Caldera Demostrativa (laboratorio)" , "photo": 'assets/S3.jpeg'},
{"id": "26", "building": "T", "name": "Laboratorio De Ingeniería Mecánica II", "photo": 'assets/T.jpeg'},
{"id": "27", "building": "U", "name": "Gimnasio Auditorio", "photo": 'assets/U.jpeg'},
{"id": "28", "building": "V", "name": "Departamento De Actividades Extraescolares", "photo": 'assets/V.jpeg'},
{"id": "29", "building": "W", "name": "Editorial"},
{"id": "30", "building": "X", "name": "Comedor Estudiantil", "photo": 'assets/X.jpeg'},
{"id": "31", "building": "Y", "name": "Departamento De Ing. Electrónica" , "photo": 'assets/Y.jpeg'},
{"id": "32", "building": "Z", "name": "Aulas de Ing. Eléctrica" , "photo": 'assets/Z.jpeg'},
{"id": "33", "building": "AA", "name": "Departamento de Ingeniería Eléctrica" , "photo": 'assets/AA.jpeg'},
{"id": "34", "building": "AB", "name": "Cubículos de Ing. Electrónica" , "photo": 'assets/AB.jpeg'},
{"id": "35", "building": "AC", "name": "Depto. de Ciencias Básicas", "photo": 'assets/AC.jpeg'},
{"id": "36", "building": "AD", "name": "Cubículos para Prof. de Ciencias Básicas"},
{"id": "37", "building": "AE", "name": "Laboratorios de Maestría en Electrónica" , "photo": 'assets/AE.jpeg'},
{"id": "38", "building": "AF", "name": "Centro de Información" , "photo": 'assets/AF.jpeg'},
{"id": "39", "building": "AG", "name": "Educ. a Dist, Aulas de Computo, Posgrado Mecánica", "areas": '- AGPG\n- LC1 LC2 LC3\n- AG1 AG2 AG3 AG4 AG5 AG6 AG7 AG8\n- Laboratorio AG\n- Apoyo Psicologico\n- Centro de Computo\n- Coordinacion de Laboratorios\n- Oficinas Posgrado Mecanica\n- Laboratorio de Modelacion Computacional' , "photo": 'assets/AG.jpeg'},
{"id": "40", "building": "AH", "name": "Depto. de Bioquímica y Laboratorios", "photo": 'assets/AH.jpeg'},
{"id": "41", "building": "2A", "name": "Depto. Ing. Mecánica y Posg. en Materiales", "photo": 'assets/2A.jpeg'},
{"id": "42", "building": "2B", "name": "Laboratorio de Fusión al Vacío", "photo": 'assets/2B.jpeg'},
{"id": "43", "building": "2C", "name": "Almacén de Materias Primas", "photo": 'assets/2C.jpeg'},
{"id": "44", "building": "2D", "name": "Laboratorio de Fundición y trat. Térmicos", "photo": 'assets/2D.jpeg'},
{"id": "45", "building": "2E", "name": "Aula", "photo": 'assets/2E.jpeg'},
{"id": "46", "building": "2F", "name": "Depto. de Ing. en Materiales", "photo": 'assets/2F.jpeg'},
{"id": "47", "building": "2G", "name": "Lab. de análisis Químicos y Fisicoquímica", "photo": 'assets/2G.jpeg'},
{"id": "48", "building": "2H", "name": "Laboratorio de Materiales", "photo": 'assets/2H.jpeg'},
{"id": "49", "building": "2J", "name": "Laboratorio de Rayos X", "photo": 'assets/2J.jpeg'},
{"id": "50", "building": "2K", "name": "Aulas"},
{"id": "51", "building": "3A", "name": "Laboratorio de Posgrado en Eléctrica"},
{"id": "52", "building": "3B", "name": "Cubículos Doctorado en Eléctrica"},
];

const List<Map<String, String>> schoolEvents = [
  {
    'title': 'Science Fair',
    'date': 'April 1, 2023',
    'location': 'School Gym',
    'description':
    'The annual science fair is a showcase of our students\' research projects and experiments. Come see the amazing work they\'ve done!',
    'imageUrl': 'assets/images/science_fair.jpg',
  },
  {
    'title': 'Math Olympiad',
    'date': 'May 15, 2023',
    'location': 'School Auditorium',
    'description':
    'Our top math students will compete against each other and students from other schools in this prestigious competition. Come cheer them on!',
    'imageUrl': 'assets/images/math_olympiad.jpg',
  },
  {
    'title': 'Spelling Bee',
    'date': 'June 2, 2023',
    'location': 'School Library',
    'description':
    'Our best spellers will face off against each other in this annual competition. Who will be the champion this year?',
    'imageUrl': 'assets/images/spelling_bee.jpg',
  },
  {
    'title': 'Art Exhibition',
    'date': 'July 10, 2023',
    'location': 'School Art Room',
    'description':
    'Come see the beautiful artwork our students have created this year! The exhibition will showcase a variety of mediums and styles.',
    'imageUrl': 'assets/images/art_exhibition.jpg',
  },
  {
    'title': 'Music Festival',
    'date': 'August 20, 2023',
    'location': 'School Auditorium',
    'description':
    'Our talented musicians will perform a variety of genres in this annual music festival. Come enjoy an evening of entertainment!',
    'imageUrl': 'assets/images/music_festival.jpg',
  },
];

