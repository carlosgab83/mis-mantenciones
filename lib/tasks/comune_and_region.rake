# encoding: utf-8

desc "Must delete and recreate region table before run this task"
task recreate_comunes_and_regions: :environment do

  # Create Regions
  if Region.count == 0
    Region.create name: 'I - Tarapaca'
    Region.create name: 'II - Antofagasta'
    Region.create name: 'III - Atacama'
    Region.create name: 'IV - Coquimbo'
    Region.create name: 'V - Valparaiso'
    Region.create name: 'VI - Libertador Bernardo O\'Higgins'
    Region.create name: 'VII - Maule'
    Region.create name: 'VIII - Bio-bio'
    Region.create name: 'IX - Araucania'
    Region.create name: 'X - Los Lagos'
    Region.create name: 'XI -Aysen del General Carlos Ibañez del Campo'
    Region.create name: 'XII - Magallanes'
    Region.create name: 'XIII - Metropolitana'
    Region.create name: 'XIV - Los Rios'
    Region.create name: 'XV -Arica y Parinacota'
  end

  c = Comune.find_by(desc_comuna: 'NIQUEN'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'NUNOA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'ALGARROBO'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'ALHUE'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'ALTO BIOBIO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'ALTO DEL CARMEN'); c.region_id = 3; c.save
  c = Comune.find_by(desc_comuna: 'ALTO HOSPICIO'); c.region_id = 1; c.save
  c = Comune.find_by(desc_comuna: 'ANCUD'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'ANDACOLLO'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'ANGOL'); c.region_id = 9; c.save
  # c = Comune.find_by(desc_comuna: 'ANTARTICA'); c.region_id = 12; c.save
  c = Comune.find_by(desc_comuna: 'ANTOFAGASTA'); c.region_id = 2; c.save
  c = Comune.find_by(desc_comuna: 'ANTUCO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'ARAUCO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'ARICA'); c.region_id = 15; c.save
  c = Comune.find_by(desc_comuna: 'AYSEN'); c.region_id = 11; c.save
  c = Comune.find_by(desc_comuna: 'BUIN'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'BULNES'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'CANETE'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'CABILDO'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'CABO DE HORNOS'); c.region_id = 12; c.save
  c = Comune.find_by(desc_comuna: 'CABRERO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'CALAMA'); c.region_id = 2; c.save
  c = Comune.find_by(desc_comuna: 'CALBUCO'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'CALDERA'); c.region_id = 3; c.save
  c = Comune.find_by(desc_comuna: 'LA CALERA'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'CALERA DE TANGO'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'CALLE LARGA'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'CAMARONES'); c.region_id = 1; c.save
  c = Comune.find_by(desc_comuna: 'CAMINA'); c.region_id = 1; c.save
  c = Comune.find_by(desc_comuna: 'CANELA'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'CARAHUE'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'CARTAGENA'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'CASABLANCA'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'CASTRO'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'CATEMU'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'CAUQUENES'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'CERRILLOS'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'CERRO NAVIA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'CHANARAL'); c.region_id = 3; c.save
  c = Comune.find_by(desc_comuna: 'CHAITEN'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'CHANCO'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'CHEPICA'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'CHIGUAYANTE'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'CHILE CHICO'); c.region_id = 11; c.save
  c = Comune.find_by(desc_comuna: 'CHILLAN'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'CHILLAN VIEJO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'CHIMBARONGO'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'CHOLCHOL'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'CHONCHI'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'CISNES'); c.region_id = 11; c.save
  c = Comune.find_by(desc_comuna: 'COBQUECURA'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'COCHAMO'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'COCHRANE'); c.region_id = 11; c.save
  c = Comune.find_by(desc_comuna: 'CODEGUA'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'COELEMU'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'COYHAIQUE'); c.region_id = 11; c.save
  c = Comune.find_by(desc_comuna: 'COIHUECO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'COINCO'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'COLBUN'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'COLCHANE'); c.region_id = 1; c.save
  c = Comune.find_by(desc_comuna: 'COLINA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'COLLIPULLI'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'COLTAUCO'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'COMBARBALA'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'CONCEPCION'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'CONCHALI'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'CONCON'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'CONSTITUCION'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'CONTULMO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'COPIAPO'); c.region_id = 3; c.save
  c = Comune.find_by(desc_comuna: 'COQUIMBO'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'CORONEL'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'CORRAL'); c.region_id = 14; c.save
  c = Comune.find_by(desc_comuna: 'CUNCO'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'CURACAUTIN'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'CURACAVI'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'CURACO DE VELEZ'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'CURANILAHUE'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'CURARREHUE'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'CUREPTO'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'CURICO'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'DALCAHUE'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'DIEGO DE ALMAGRO'); c.region_id = 3; c.save
  c = Comune.find_by(desc_comuna: 'DONIHUE'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'EL BOSQUE'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'EL CARMEN'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'EL MONTE'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'OLIVAR'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'EL QUISCO'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'EL TABO'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'EMPEDRADO'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'ERCILLA'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'ESTACION CENTRAL'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'FLORIDA'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'FREIRE'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'FREIRINA'); c.region_id = 3; c.save
  c = Comune.find_by(desc_comuna: 'FRESIA'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'FRUTILLAR'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'FUTALEUFU'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'FUTRONO'); c.region_id = 14; c.save
  c = Comune.find_by(desc_comuna: 'GALVARINO'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'GENERAL LAGOS'); c.region_id = 1; c.save
  c = Comune.find_by(desc_comuna: 'GORBEA'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'GRANEROS'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'GUAITECAS'); c.region_id = 11; c.save
  c = Comune.find_by(desc_comuna: 'HIJUELAS'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'HUALANE'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'HUALAIHUE'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'HUALPEN'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'HUALQUI'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'HUARA'); c.region_id = 1; c.save
  c = Comune.find_by(desc_comuna: 'HUASCO'); c.region_id = 3; c.save
  c = Comune.find_by(desc_comuna: 'HUECHURABA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'ILLAPEL'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'INDEPENDENCIA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'IQUIQUE'); c.region_id = 1; c.save
  c = Comune.find_by(desc_comuna: 'ISLA DE MAIPO'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'ISLA DE PASCUA'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'JUAN FERNANDEZ'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'LA CISTERNA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'LA CRUZ'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'LA ESTRELLA'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'LA FLORIDA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'LA GRANJA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'LA HIGUERA'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'LA LIGUA'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'LA PINTANA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'LA REINA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'LA SERENA'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'LA UNION'); c.region_id = 14; c.save
  c = Comune.find_by(desc_comuna: 'LAGO RANCO'); c.region_id = 14; c.save
  c = Comune.find_by(desc_comuna: 'LAGO VERDE'); c.region_id = 11; c.save
  c = Comune.find_by(desc_comuna: 'LAGUNA BLANCA'); c.region_id = 12; c.save
  c = Comune.find_by(desc_comuna: 'LAJA'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'LAMPA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'LANCO'); c.region_id = 14; c.save
  c = Comune.find_by(desc_comuna: 'LAS CABRAS'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'LAS CONDES'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'LAUTARO'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'LEBU'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'LICANTEN'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'LIMACHE'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'LINARES'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'LITUECHE'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'LLAY-LLAY'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'LLANQUIHUE'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'LO BARNECHEA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'LO ESPEJO'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'LO PRADO'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'LOLOL'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'LONCOCHE'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'LONGAVI'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'LONQUIMAY'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'LOS ALAMOS'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'LOS ANDES'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'LOS ANGELES'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'LOS LAGOS'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'LOS MUERMOS'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'LOS SAUCES'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'LOS VILOS'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'LOTA'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'LUMACO'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'MACHALI'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'MACUL'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'MAFIL'); c.region_id = 14; c.save
  c = Comune.find_by(desc_comuna: 'MAIPU'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'MALLOA'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'MARCHIGUE'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'MARIA ELENA'); c.region_id = 2; c.save
  c = Comune.find_by(desc_comuna: 'MARIA PINTO'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'MARIQUINA'); c.region_id = 14; c.save
  c = Comune.find_by(desc_comuna: 'MAULE'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'MAULLIN'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'MEJILLONES'); c.region_id = 2; c.save
  c = Comune.find_by(desc_comuna: 'MELIPEUCO'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'MELIPILLA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'MOLINA'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'MONTE PATRIA'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'SAN FRANCISCO DE MOSTAZAL'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'MULCHEN'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'NACIMIENTO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'NANCAGUA'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'NATALES'); c.region_id = 12; c.save
  c = Comune.find_by(desc_comuna: 'NAVIDAD'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'NEGRETE'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'NINHUE'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'NOGALES'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'NUEVA IMPERIAL'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'OHIGGINS'); c.region_id = 11; c.save
  c = Comune.find_by(desc_comuna: 'OLLAGUE'); c.region_id = 2; c.save
  c = Comune.find_by(desc_comuna: 'OLMUE'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'OSORNO'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'OVALLE'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'PADRE HURTADO'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'PADRE LAS CASAS'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'PAIHUANO'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'PAILLACO'); c.region_id = 14; c.save
  c = Comune.find_by(desc_comuna: 'PAINE'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'PALENA'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'PALMILLA'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'PANGUIPULLI'); c.region_id = 14; c.save
  c = Comune.find_by(desc_comuna: 'PANQUEHUE'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'PAPUDO'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'PAREDONES'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'PARRAL'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'PENAFLOR'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'PENALOLEN'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'PEDRO AGUIRRE CERDA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'PELARCO'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'PELLUHUE'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'PEMUCO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'PENCAHUE'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'PENCO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'PERALILLO'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'PERQUENCO'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'PETORCA'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'PEUMO'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'PICA'); c.region_id = 1; c.save
  c = Comune.find_by(desc_comuna: 'PICHIDEGUA'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'PICHILEMU'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'PINTO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'PIRQUE'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'PITRUFQUEN'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'PLACILLA'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'PORTEZUELO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'PORVENIR'); c.region_id = 12; c.save
  c = Comune.find_by(desc_comuna: 'POZO ALMONTE'); c.region_id = 1; c.save
  c = Comune.find_by(desc_comuna: 'PRIMAVERA'); c.region_id = 12; c.save
  c = Comune.find_by(desc_comuna: 'PROVIDENCIA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'PUCHUNCAVI'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'PUCON'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'PUDAHUEL'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'PUENTE ALTO'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'PUERTO MONTT'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'PUERTO OCTAY'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'PUERTO VARAS'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'PUMANQUE'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'PUNITAQUI'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'PUNTA ARENAS'); c.region_id = 12; c.save
  c = Comune.find_by(desc_comuna: 'PUQUELDON'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'PUREN'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'PURRANQUE'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'PUTAENDO'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'PUTRE'); c.region_id = 1; c.save
  c = Comune.find_by(desc_comuna: 'PUYEHUE'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'QUEILEN'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'QUELLON'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'QUEMCHI'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'QUILACO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'QUILICURA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'QUILLECO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'QUILLON'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'QUILLOTA'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'QUILPUE'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'QUINCHAO'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'QUINTA DE TILCOCO'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'QUINTA NORMAL'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'QUINTERO'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'QUIRIHUE'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'RANCAGUA'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'RANQUIL'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'RAUCO'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'RECOLETA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'RENAICO'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'RENCA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'RENGO'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'REQUINOA'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'RETIRO'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'RINCONADA'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'RIO BUENO'); c.region_id = 14; c.save
  c = Comune.find_by(desc_comuna: 'RIO CLARO'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'RIO HURTADO'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'RIO IBANEZ'); c.region_id = 11; c.save
  c = Comune.find_by(desc_comuna: 'RIO NEGRO'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'RIO VERDE'); c.region_id = 12; c.save
  c = Comune.find_by(desc_comuna: 'ROMERAL'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'SAAVEDRA'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'SAGRADA FAMILIA'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'SALAMANCA'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'SAN ANTONIO'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'SAN BERNARDO'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'SAN CARLOS'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'SAN CLEMENTE'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'SAN ESTEBAN'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'SAN FABIAN'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'SAN FELIPE'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'SAN FERNANDO'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'SAN GREGORIO'); c.region_id = 12; c.save
  c = Comune.find_by(desc_comuna: 'SAN IGNACIO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'SAN JAVIER'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'SAN JOAQUIN'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'SAN JOSE DE MAIPO'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'SAN JUAN DE LA COSTA'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'SAN MIGUEL'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'SAN NICOLAS'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'SAN PABLO'); c.region_id = 10; c.save
  c = Comune.find_by(desc_comuna: 'SAN PEDRO'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'SAN PEDRO DE ATACAMA'); c.region_id = 2; c.save
  c = Comune.find_by(desc_comuna: 'SAN PEDRO DE LA PAZ'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'SAN RAFAEL'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'SAN RAMON'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'SAN ROSENDO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'SAN VICENTE'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'SANTA BARBARA'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'SANTA CRUZ'); c.region_id = 6; c.save
  c = Comune.find_by(desc_comuna: 'SANTA JUANA'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'SANTA MARIA'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'SANTIAGO'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'SANTO DOMINGO'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'SIERRA GORDA'); c.region_id = 2; c.save
  c = Comune.find_by(desc_comuna: 'TALAGANTE'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'TALCA'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'TALCAHUANO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'TALTAL'); c.region_id = 2; c.save
  c = Comune.find_by(desc_comuna: 'TEMUCO'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'TENO'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'TEODORO SCHMIDT'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'TIERRA AMARILLA'); c.region_id = 3; c.save
  c = Comune.find_by(desc_comuna: 'TIL-TIL'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'TIMAUKEL'); c.region_id = 12; c.save
  c = Comune.find_by(desc_comuna: 'TIRUA'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'TOCOPILLA'); c.region_id = 2; c.save
  c = Comune.find_by(desc_comuna: 'TOLTEN'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'TOME'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'TORRES DEL PAINE'); c.region_id = 12; c.save
  c = Comune.find_by(desc_comuna: 'TORTEL'); c.region_id = 11; c.save
  c = Comune.find_by(desc_comuna: 'TRAIGUEN'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'TREHUACO'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'TUCAPEL'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'VALDIVIA'); c.region_id = 14; c.save
  c = Comune.find_by(desc_comuna: 'VALLENAR'); c.region_id = 3; c.save
  c = Comune.find_by(desc_comuna: 'VALPARAISO'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'VINA DEL MAR'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'VICHUQUEN'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'VICTORIA'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'VICUNA'); c.region_id = 4; c.save
  c = Comune.find_by(desc_comuna: 'VILCUN'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'VILLA ALEGRE'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'VILLA ALEMANA'); c.region_id = 5; c.save
  c = Comune.find_by(desc_comuna: 'VILLARRICA'); c.region_id = 9; c.save
  c = Comune.find_by(desc_comuna: 'VITACURA'); c.region_id = 13; c.save
  c = Comune.find_by(desc_comuna: 'YERBAS BUENAS'); c.region_id = 7; c.save
  c = Comune.find_by(desc_comuna: 'YUMBEL'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'YUNGAY'); c.region_id = 8; c.save
  c = Comune.find_by(desc_comuna: 'ZAPALLAR'); c.region_id = 5; c.save
end
