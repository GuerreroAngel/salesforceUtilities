/**
* ───────────────────────────────────────────────────────────────────────────────────────────────────────┐
* @nameClass			Util_Contratos
* @author       		Guerrero Chávez Angel   <angel.gch@hotmail.com>
* @version      		1.0
* @date        			06-Mayo-2021
* @description 			Clase de utilidades para los contratos
* ───────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
public without sharing class Util_Contratos {

    static String[] UNIDADES = new String[]{'', 'un ', 'dos ', 'tres ', 'cuatro ', 'cinco ', 'seis ', 'siete ', 'ocho ', 'nueve '};
    static String[] DECENAS = new String[]{'diez ', 'once ', 'doce ', 'trece ', 'catorce ', 'quince ', 'dieciséis ',
        'diecisiete ', 'dieciocho ', 'diecinueve ', 'veinte ', 'veintiuno','veintidós','veititrés','veinticuatro','veinticinco','veintiséis','veintisiete','veintiocho','veintinueve','treinta ', 'cuarenta ', 'cincuenta ', 'sesenta ', 'setenta ', 'ochenta ', 'noventa '};
    static String[] CENTENAS = new String[]{'', 'ciento ', 'doscientos ', 'trecientos ', 'cuatrocientos ', 'quinientos ', 'seiscientos ',
        'setecientos ', 'ochocientos ', 'novecientos '};

    /**
    * ─────────────────────────────────────────────────────────────────────────────────────────────────┐
    * @nameMethod			numALetra
    * @author	       		Un compa de Internet nomas adapte el código dde Java a Apex. (http://convetirnumerosaletras.blogspot.com/)
    * @date        			06-Mayo-2021
    * @description			Recibe String de la cantidad con o sin decimales y comas y lo transforma a Letras
    * @param fieldName 		número : String
    * @param fieldName 		mayúsculas : Boolean
    * ─────────────────────────────────────────────────────────────────────────────────────────────────┘
    **/
    public static String numALetra(String numero, Boolean mayusculas){
        String literal = '';
        String parte_decimal;
        //si el numero utiliza (.) en lugar de (,) -> se reemplaza
        numero = numero.replace('.', ',');
        //si el numero no tiene parte decimal, se le agrega ,00
        if (numero.indexOf(',') == -1) {
            numero = numero + ',00';
        }
        //se valida formato de entrada -> 0,00 y 999 999 999,00
        if (Pattern.matches('\\d{1,9},\\d{1,2}', numero)) {
            //se divide el numero 0000000,00 -> entero y decimal
            String[] Num = numero.split(',');
            //de da formato al numero decimal
            parte_decimal = ' ' + Num[1] + '/100 M.N.';
            //se convierte el numero a literal
            if (Integer.valueOf(Num[0]) == 0) {//si el valor es cero
                literal = 'cero ';
            } else if (Integer.valueOf(Num[0]) > 999999) {//si es millon
                literal = getMillones(Num[0]);
            } else if (Integer.valueOf(Num[0]) > 999) {//si es miles
                literal = getMiles(Num[0]);
            } else if (Integer.valueOf(Num[0]) > 99) {//si es centena
                literal = getCentenas(Num[0]);
            } else if (Integer.valueOf(Num[0]) > 9) {//si es decena
                literal = getDecenas(Num[0]);
            } else {//sino unidades -> 9
                literal = getUnidades(Num[0]);
            }
            //devuelve el resultado en mayusculas o minusculas
            if (mayusculas) {
                return (literal + parte_decimal).toUpperCase();
            } else {
                return (literal + parte_decimal);
            }
        } else {//error, no se puede convertir
            return literal = null;
        }

    }
    /* funciones para convertir los numeros a literales */
    private static String getUnidades(String numero) {// 1 - 9
        //si tuviera algun 0 antes se lo quita -> 09 = 9 o 009=9
        String num = numero.substring(numero.length() - 1);
        return UNIDADES[Integer.valueOf(num)];
    }

    private static String getDecenas(String num) {// 99
        Integer n = Integer.valueOf(num);
        if (n < 10) {//para casos como -> 01 - 09
            return getUnidades(num);
        } else if (n > 29) {//para 30...99
            String u = getUnidades(num);
            if (u.equals('')) { //para 30,40,50,60,70,80,90
                return DECENAS[Integer.valueOf(num.substring(0, 1)) + 17];
            } else {
                return DECENAS[Integer.valueOf(num.substring(0, 1)) + 17] + 'y ' + u;
            }
        } else {//numeros entre 11 y 19
            return DECENAS[n - 10];
        }
    }

    private static String getCentenas(String num) {// 999 o 099
        if (Integer.valueOf(num) > 99) {//es centena
            if (Integer.valueOf(num) == 100) {//caso especial
                return ' cien ';
            } else {
                return CENTENAS[Integer.valueOf(num.substring(0, 1))] + getDecenas(num.substring(1));
            }
        } else {//por Ej. 099
            //se quita el 0 antes de convertir a decenas
            return getDecenas(Integer.valueOf(num) + '');
        }
    }

    private static String getMiles(String numero) {// 999 999
        //obtiene las centenas
        String c = numero.substring(numero.length() - 3);
        //obtiene los miles
        String m = numero.substring(0, numero.length() - 3);
        String n = '';
        //se comprueba que miles tenga valor entero
        if (Integer.valueOf(m) > 0) {
            n = getCentenas(m);
            return n + 'mil ' + getCentenas(c);
        } else {
            return '' + getCentenas(c);
        }

    }

    private static String getMillones(String numero) { //000 000 000
        //se obtiene los miles
        String miles = numero.substring(numero.length() - 6);
        //se obtiene los millones
        String millon = numero.substring(0, numero.length() - 6);
        String n = '';
        if (millon.length() > 1) {
            n = getCentenas(millon) + 'millones ';
        } else {
            n = getUnidades(millon) + 'millon ';
        }
        return n + getMiles(miles);
    }
}
