import 'package:flutter/material.dart';

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


String verFechaHora( String opcion ){
  DateTime ahora_ = new DateTime.now(); print(ahora_);
  String ahora = ahora_.toString();
  String fecha_ = ahora.split(' ')[0];
  String hora_ = ahora.split(' ')[1];

  String retorno = '';
  print(ahora_);

  if( opcion == 'fecha' ){
    List<String> vFecha = fecha_.split('-');

    retorno = ' '+vFecha[2]+' de '+ verMes( vFecha[1] ) +' de '+vFecha[0];
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