
import 'package:flut_voz/ui/Yobi.dart';
import 'package:flut_voz/ui/Funciones.dart';

void iniMandos( Yobi yb )
{

  Map<String, dynamic> mando0 = {
    'claves': 'algo_mas',
    'accion': 'algo_mas',
    'finalizar': true,
    'ejecutar': true,
    'oir': false,
    'params': null,   
    'funcIni': (){
      yb.texto = 'Qué mas deseas ?';
      print( yb.texto );
      yb.hablar();
    },
    'paso': 0,
    'cant_pasos': 1, 
    'funcPaso1': (){
      yb.accion = '';
      yb.oir();
    }
  };

  Map<String, dynamic> mandoFin = {
    'claves': 'fin_app',
    'accion': 'fin_app',
    'finalizar': true,
    'ejecutar': false,
    'oir': false,
    'params': null,
    'funcIni': (){
      yb.texto = 'Hasta luego!';
      print( yb.texto );
      yb.hablar();
    },
    'paso': 0,
    'cant_pasos': 0,
    'funcPaso1': null
  };

  Map<String, dynamic> mando1 = {
    'claves': 'saludo app',
    'accion': 'saludo_app',
    'finalizar': true,
    'ejecutar': true,
    'oir': false,
    'params': null,
    'funcIni': (){
      yb.texto = 'Bienvenido!';
      print( yb.texto );
      yb.hablar();
    },
    'paso': 0,
    'cant_pasos': 2,
    'funcPaso1': (){
      yb.texto = 'Dime que deseas ?';
      print( yb.texto );
      yb.hablar();      
    },
    'funcPaso2': (){
      print( 'oyera... desde el Saludo' );
      yb.oir();
    }
  };
  
  Map<String, dynamic> mando2 = {
    'claves': 'saludar a|saluda a|saludo a',
    'accion': 'saludo_persona',
    'finalizar': true,
    'ejecutar': true,
    'oir': false,
    'params': {
      'nombre': 'xxx'
    },
    'funcIni': (){
      yb.texto = 'A quién quieres saludar ?';
      yb.hablar();
    },
    'paso': 0,
    'cant_pasos': 2,
    'funcPaso1': (){
      yb.oir();
    },
    'funcPaso2': (){
      yb.texto = 'Hola, ${yb.texto}';
      yb.hablar();
    }
  };

  Map<String, dynamic> mando3 = {
    'claves': 'dime la fecha|qué fecha es hoy|que fecha es hoy',
    'accion': 'obtener_fecha',
    'finalizar': true,
    'ejecutar': true,
    'oir': false,
    'params': null,
    'funcIni': (){
      yb.texto = 'Hoy es ${verFechaHora('fecha')}';
      yb.hablar();
    },
    'paso': 0,
    'cant_pasos': 0,
    'funcPaso1': null
  };

  Map<String, dynamic> mando4 = {
    'claves': 'dime la hora|qué hora es|que hora es',
    'accion': 'obtener_hora',
    'finalizar': true,
    'ejecutar': true,
    'oir': false,
    'params': null,
    'funcIni': (){
      yb.texto = 'Son las ${verFechaHora('hora')}';
      yb.hablar();
    },
    'paso': 0,
    'cant_pasos': 0,
    'funcPaso1': null
  };

  Map<String, dynamic> mando5 = {
    'claves': 'guardar nota|guarda nota|guardar una nota',
    'accion': 'saludo_persona',
    'finalizar': true,
    'ejecutar': true,
    'oir': false,
    'params': {
      'titulo': '',
      'nota': ''
    },
    'funcIni': (){
      yb.texto = 'Cual es el titulo de la nota ?';
      yb.hablar();
    },
    'paso': 0,
    'cant_pasos': 4,
    'funcPaso1': (){
      yb.oir();
    },
    'funcPaso2': (){
      yb.mando['params']['titulo'] = yb.texto;
      yb.texto = 'Has dicho. ${yb.mando['params']['titulo']}. Ahora dime la nota ';
      yb.hablar();
    },
    'funcPaso3': (){
      yb.oir();
    },
    'funcPaso4': (){
      yb.mando['params']['nota'] = yb.texto;
      yb.texto = 'Se ha almacenado la nota. título. ${yb.mando['params']['titulo']}. contenido de la nota. ${yb.mando['params']['nota']}';
      yb.hablar();
    }
  };

  Map<String, dynamic> mando6 = {
    'claves': 'multiplicar|sumar|restar|dividir',
    'accion': 'calculadora_basica',
    'finalizar': true,
    'ejecutar': true,
    'oir': false,
    'params': null,
    'funcIni': (){
      String frase = yb.texto;
      
      String operadores = '';
      //String operador = '';

      String separador = '';
      if( frase.contains('sumar') ){
        if( frase.contains('+') ) separador = '+';
        else if( frase.contains('mas') ) separador = 'mas';
        else if( frase.contains('más') ) separador = 'más';
        else if( frase.contains('por') ) separador = 'por';

        operadores = frase.split( 'sumar' )[1];

        double num1 = double.parse( operadores.split( separador )[0] );
        double num2 = double.parse( operadores.split( separador )[1] );

        double resultado = num1 + num2;
        yb.texto = 'El resultado de sumar ${sinCeroDecimal(num1)} + ${sinCeroDecimal(num2)} es ${sinCeroDecimal(resultado)}';
      }
      else if( frase.contains('restar') ){
        if( frase.contains('-') ) separador = '-';
        else if( frase.contains('menos') ) separador = 'menos';
        else if( frase.contains('de') ) separador = 'de';
        else if( frase.contains('a') ) separador = 'a';

        operadores = frase.split( 'restar' )[1];

        double num1 = double.parse( operadores.split( separador )[0] );
        double num2 = double.parse( operadores.split( separador )[1] );

        double resultado = num1 - num2;
        yb.texto = 'El resultado de restar ${sinCeroDecimal(num1)} menos ${sinCeroDecimal(num2)} es ${sinCeroDecimal(resultado)}';
      }
      else if( frase.contains('dividir') ){
        if( frase.contains('/') ) separador = '/';
        else if( frase.contains('entre') ) separador = 'entre';
        else if( frase.contains('en') ) separador = 'en';

        operadores = frase.split( 'dividir' )[1];

        double num1 = double.parse( operadores.split( separador )[0] );
        double num2 = double.parse( operadores.split( separador )[1] );

        double resultado = num1 / num2;
        yb.texto = 'El resultado de dividir ${sinCeroDecimal(num1)} entre ${sinCeroDecimal(num2)} es ${sinCeroDecimal(resultado)}';
      }
      else{ // Multiplicar
        if( frase.contains('*') ) separador = '*';
        else if( frase.contains('por') ) separador = 'por';

        operadores = frase.split( 'multiplicar' )[1];

        double num1 = double.parse( operadores.split( separador )[0] );
        double num2 = double.parse( operadores.split( separador )[1] );

        double resultado = num1 * num2;
        yb.texto = 'El resultado de multiplicar ${sinCeroDecimal(num1)} por ${sinCeroDecimal(num2)} es ${sinCeroDecimal(resultado)}';
      }
      
      yb.hablar();
    },
    'paso': 0,
    'cant_pasos': 0,
    'funcPaso1': null
  };

  Map<String, dynamic> mando7 = {
    'claves': 'quién es tu creador|quien es tu creador',
    'accion': 'info_creador',
    'finalizar': true,
    'ejecutar': false,
    'oir': false,
    'params': null,
    'funcIni': (){
      yb.texto = 'Mi creador es Robinson!. si necesitas algo no dudes en ponerte en contacto con él, es el mejor!';
      yb.hablar();
    },
    'paso': 0,
    'cant_pasos': 0,
    'funcPaso1': null
  };
  Map<String, dynamic> mando8 = {
    'claves': 'dile hola a michel|hola michel|quién es michel',
    'accion': 'info_creador',
    'finalizar': true,
    'ejecutar': false,
    'oir': false,
    'params': null,
    'funcIni': (){
      if( yb.texto.contains('hola') )
        yb.texto = 'Hola señorita, cómo estás ?';
      else
        yb.texto = 'Una nenita muy linda, tierna y dulce, amiga incondicional y muy buena por si quieres matar gente jejeje es la mejor!';
      yb.hablar();
    },
    'paso': 0,
    'cant_pasos': 0,
    'funcPaso1': null
  };

  yb.nuevoMando = mando0;
  yb.nuevoMando = mandoFin;
  yb.nuevoMando = mando1;
  yb.nuevoMando = mando2;
  yb.nuevoMando = mando3;
  yb.nuevoMando = mando4;
  yb.nuevoMando = mando5;
  yb.nuevoMando = mando6;
  yb.nuevoMando = mando7;
  yb.nuevoMando = mando8;


  yb.mando = mando1;

}