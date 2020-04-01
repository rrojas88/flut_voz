
import 'package:flut_voz/ui/Mandos.dart';
import 'package:flut_voz/ui/Funciones.dart';

class Yobi {
  bool oye = false;
  String estado = 'INICIAL';
  List <Map<String, dynamic>> mandos = [];
  String texto = '';
  dynamic mando;
  String accion = '';
  bool pideMas = false;

  Function _speak;
  Function _oir;
  Function _log;


  void buscandoMando( String _texto ){
    estado = 'BUSCANDO MANDO';
    print("\n___________________ $estado");
    log("___________________ $estado");

    _texto += '';
    texto = _texto.trim().toLowerCase();
    
    //List <Map <String, dynamic>> mandos = mandos;
    
    // Verificar primero si CANCELA
    if( texto.contains( new RegExp(r'(cancelar todo)|(parar todo)') ) ){
      print('Cancelada la ejecucion de la TAREA !!!');
      //mando = mandos.elementAt( 1 ); // fin_app
      mando = clonarMando( mandos.elementAt(1) ); // fin_app
      accion = mando['accion'];
      ejecutaMando(  );
      return;
    }
    else {

      bool hayAccion = false;

      /// Hay Mando.. recepción de Parametros
      if( accion != '' ){
        print('__> Ejecucion directa de ejecutaMando()');
        log('__> Ejecucion directa de ejecutaMando()');
        ejecutaMando(  );
        return;
      }
      else {
        for( Map m in mandos ){
          List <String> claves = m['claves'].split('|');
          //print('__> recorreMandos..');
          log('__> recorreMandos..');

          if( ! hayAccion ){

            for( String clave in claves ){
              //print('__> recorreClaves: $clave');
              
              if( accion == '' ){
                if( texto.contains( clave ) ){
                  // Encontrada la Clave
                  print( '__> Encontrada accion: ' + m['accion'] );
                  log( '__> Encontrada accion: ' + m['accion'] );
                  mando = clonarMando( m );
                  accion = m['accion'];
                  
                  ejecutaMando(  );
                  break;
                }
              }
              else{ // Hay una opcion Seleccionada
                // No DIJO NADA
                if( texto.trim() == '' ){
                  //mando = mandos.elementAt(0); // algo_mas
                  mando = clonarMando( mandos.elementAt(0) ); // algo_mas
                  accion = mando['accion'];
                  break;
                }
                else{
                  print('__>Posible mando con parametro: $texto');
                  ejecutaMando(  );
                  break;
                }
              }
            } // Fin For Claves
          }
          else{
            print('__> Ya hay accion.. vamos OK');
            break;
          }

          if( accion != '' ) break;
        }  // Fin For Mandos

        if( ! hayAccion ){
          print("\n\n"+'__> Verificar si se encontró MANDO: $accion');
          log('__> Verificar si se encontró MANDO: $accion');
        }
      }
    }
  }

  void ejecutaMando(  ){
    print("\n"+'== == == == == == == == == == >> ejecutaMando(  )');
    log('== == == == == == == == == == >> ejecutaMando(  )');
    print('TEXTO: "$texto", del MANDO =>');
    print(mando);
    pideMas = false;

    if( mando['paso'] == 0 ){
      print('Entra PASO = 0');
      log('Entra PASO = 0');
      mando['paso']++;
      mando['funcIni']();
    }
    else if( mando['paso'] <= mando['cant_pasos'] && mando['paso'] != 0 ){
      int paso = mando['paso'];
      mando['paso']++;

      if( mando['paso'] > mando['cant_pasos'] ){
        print('+ + + + Finalizara el mando: ${mando['accion']}');
        if( accion != 'algo_mas' ){
          mando['finaliza'] = false;

          pideMas = true;
        }
      }

      print('Ejecutará.. el paso: ${paso.toString()}');
      log('Ejecutará.. el paso: ${paso.toString()}');
      mando['funcPaso' + paso.toString() ]();
    }
    else{
      print('...ELSE de ejecutaMando(  ).. FIN . ACCION = $accion');
      log('...ELSE de ejecutaMando(  ).. FIN . ACCION = $accion');
      
      mando['paso'] = 0;

        // Limpio Accion para ver si hay nuevo Mando
        if( accion != 'algo_mas' && accion != 'fin_app' ){
          mando = clonarMando( mandos.elementAt(0) ); // algo_mas
          accion = mando['accion'];

          ejecutaMando();
        }
        // Limpio Accion Si ha Finalizado
        if( accion == 'fin_app' ){
          mando = clonarMando( mandos.elementAt(0) ); // algo_mas
          accion = mando['accion'];
        }

    }
  }
  
  void oir(){
    _oir();
  }
  void hablar(  ){
    _speak( texto, mando );
  }
  void log( String info ){
    _log( info );
  }
  set nuevoMando( Map mando ){
    mandos.add( mando );
  }

  Map clonarMando( Map mandoX ){
    Map<String, dynamic> clon = {};
    mandoX.forEach((clave, valor){
      clon.addAll({ clave: valor });
    });
    //print("\n mandoX Clonado !!!!!!!!!!!!!!!!!!!!!!!!!!"); print(mandoX);
    return clon;
  }


  String toString() => "Cant:${mandos.length} \n" + mandos.toString();

  void verMandos(){
    print( "Cant:${mandos.length} \n" + mandos.toString() );
  }


}


void init ( Yobi yb, Function speak, Function oir, Function log ){
  print('Inicializando.. Yobi');

  yb._speak = speak;
  yb._oir = oir;
  yb._log = log;

  iniMandos( yb );
  yb.log('Init.. Yobi');

  yb.ejecutaMando(  );

}


