

String verMes ( String numMes ){
  String mes = '';
  switch( numMes ){
    case '1': 
    case '01': 
      mes = 'Enero'; break;
    case '2': 
    case '02': 
      mes = 'Febrero'; break;
    case '3': 
    case '03': 
      mes = 'Marzo'; break;
    case '4': 
    case '04': 
      mes = 'Abril'; break;
    case '5': 
    case '05': 
      mes = 'Mayo'; break;
    case '6': 
    case '06': 
      mes = 'Junio'; break;
    case '7': 
    case '07': 
      mes = 'Julio'; break;
    case '8': 
    case '08': 
      mes = 'Agosto'; break;
    case '9': 
    case '09': 
      mes = 'Septiembre'; break; 
    case '10': 
      mes = 'Octubre'; break; 
    case '11': 
      mes = 'Noviembre'; break; 
    case '12': 
      mes = 'Diciembre'; break;
  }
  return mes;
}

String diaSemana (String numDia ){
  String dia = 'Lunes';
  switch( numDia ){
    case '2': dia = 'Martes'; break;
    case '3': dia = 'Miércoles'; break;
    case '4': dia = 'Jueves'; break;
    case '5': dia = 'Viernes'; break;
    case '6': dia = 'Sábado'; break;
    case '7': dia = 'Domingo'; break;
  }
  return dia;
}


String verFechaHora( String opcion ){
  DateTime ahora_ = new DateTime.now();
  String ahora = ahora_.toString();
  String fecha_ = ahora.split(' ')[0];
  String hora_ = ahora.split(' ')[1];

  String retorno = '';

  if( opcion == 'fecha' ){
    List<String> vFecha = fecha_.split('-');

    String dia = ( vFecha[2].contains( new RegExp(r'(01)|(02)|(03)|(04)|(05)|(06)|(07)|(08)|(09)|') ) ) ? vFecha[2].replaceAll('0', '') : vFecha[2];

    retorno = ' '+diaSemana( ahora_.weekday.toString() )+' '+ dia +' de '+ verMes( vFecha[1] ) +' de '+vFecha[0];
  }
  else{
    List<String> vHora = hora_.substring(0, 5).split(':');
    String hora = vHora[0];    
    String min = vHora[1];

    if( int.parse(hora) > 12 ){
      int horaOk = int.parse(hora) - 12;
      String horario = ( horaOk >= 7 )? 'noche' : 'tarde';
      retorno = ' $horaOk y $min minutos de la $horario';
    }
    else{
      String horario = ( int.parse(hora) >= 4 )? 'mañana' : 'madrugada';
      retorno = ' $hora y $min minutos de la $horario';
    }
  }

  return retorno;
}

String sinCeroDecimal( double numero ){
  String num = numero.toString();
  if( num.contains('.0') ) num = num.replaceAll('.0', '');
  return num;
}

int validaNumero ( String numero ) {
  numero = numero.toLowerCase();
  int num = 1;
  if( numero == 'dos' || numero == '2' ) num = 2;
  else if( numero == 'tres' || numero == '3' ) num = 3;
  else if( numero == 'cuatro' || numero == '4' ) num = 4;
  else if( numero == 'cinco' || numero == '5' ) num = 5;
  else if( numero == 'seis' || numero == '6' || numero == 'face' ) num = 6;
  else if( numero == 'siete' || numero == '7' ) num = 7;
  else if( numero == 'ocho' || numero == '8' ) num = 8;
  else if( numero == 'nueve' || numero == '9' ) num = 9;
  else if( numero == 'diez' || numero == '10' ) num = 10;
  else if( numero == 'once' || numero == '11' ) num = 11;
  else if( numero == 'doce' || numero == '12' ) num = 12;
  return num;
}

