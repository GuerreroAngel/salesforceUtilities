/**
* ───────────────────────────────────────────────────────────────────────────────────────────────────────┐
* @nameClass			Util_ContratosTest
* @author       		Guerrero Chávez Angel   <angel.gch@hotmail.com>
* @version      		1.0
* @date        			06-Mayo-2021
* @description 			Clase TEST
* ───────────────────────────────────────────────────────────────────────────────────────────────────────┘
**/
@isTest
private class Util_ContratosTest {

    @isTest
    static void testUnidadesYDecenas() {
        // Test unidades
        String resUnidad = Util_Contratos.numALetra('5', false);
        // El método agrega ",00" automáticamente
        System.assertEquals('cinco  00/100 M.N.', resUnidad, 'Fallo en unidad (5)');

        // Test decenas (caso especial 10-19)
        String resDecena1 = Util_Contratos.numALetra('15', false);
        System.assertEquals('quince  00/100 M.N.', resDecena1, 'Fallo en decena (15)');

        // Test decenas (caso 20-29) - Nota: Tu array tiene "veititrés"
        String resDecena2 = Util_Contratos.numALetra('23', false);
        System.assertEquals('veititrés 00/100 M.N.', resDecena2, 'Fallo en decena (23)');

        // Test decenas (caso 30-99)
        String resDecena3 = Util_Contratos.numALetra('48', false);
        System.assertEquals('cuarenta y ocho  00/100 M.N.', resDecena3, 'Fallo en decena (48)');

        // Test decena exacta
        String resDecena4 = Util_Contratos.numALetra('30', false);
        System.assertEquals('treinta  00/100 M.N.', resDecena4, 'Fallo en decena (30)');
    }

    @isTest
    static void testCentenas() {
        // Test 100 (caso especial "cien")
        String resCien = Util_Contratos.numALetra('100', false);
        System.assertEquals(' cien  00/100 M.N.', resCien, 'Fallo en centena (100)');

        // Test centenas normales
        String resCiento = Util_Contratos.numALetra('101', false);
        System.assertEquals('ciento un  00/100 M.N.', resCiento, 'Fallo en centena (101)');

        String resCientos = Util_Contratos.numALetra('578', false);
        System.assertEquals('quinientos setenta y ocho  00/100 M.N.', resCientos, 'Fallo en centena (578)');
    }

    @isTest
    static void testMiles() {
        // Test 1000 (mil)
        String resMil = Util_Contratos.numALetra('1000', false);
        System.assertEquals('mil  00/100 M.N.', resMil, 'Fallo en miles (1000)');

        // Test miles complejos (usa "veititrés" de tu array)
        String resMiles = Util_Contratos.numALetra('123456', false);
        System.assertEquals('ciento veititrés mil cuatrocientos cincuenta y seis  00/100 M.N.', resMiles, 'Fallo en miles (123456)');
    }

    @isTest
    static void testMillones() {
        // Test 1 millon
        String resMillon = Util_Contratos.numALetra('1000000', false);
        System.assertEquals('un millon  00/100 M.N.', resMillon, 'Fallo en millon (1000000)');

        // Test varios millones
        String resMillones = Util_Contratos.numALetra('5000000', false);
        System.assertEquals('cinco millones  00/100 M.N.', resMillones, 'Fallo en millones (5000000)');

        // Test millones complejos (usa "veititrés" de tu array)
        String resComplejo = Util_Contratos.numALetra('123456789', false);
        String esperado = 'ciento veititrés millones cuatrocientos cincuenta y seis mil setecientos ochenta y nueve  00/100 M.N.';
        System.assertEquals(esperado, resComplejo, 'Fallo en millones complejos (123456789)');
    }

    @isTest
    static void testDecimalesYMayusculas() {
        // Test con decimal usando coma
        String resDecimalComa = Util_Contratos.numALetra('25,50', false);
        System.assertEquals('veinticinco  50/100 M.N.', resDecimalComa, 'Fallo en decimal con coma');

        // Test con decimal usando punto (debe reemplazarlo)
        String resDecimalPunto = Util_Contratos.numALetra('19.99', false);
        System.assertEquals('diecinueve  99/100 M.N.', resDecimalPunto, 'Fallo en decimal con punto');

        // Test de cero
        String resCero = Util_Contratos.numALetra('0.01', false);
        System.assertEquals('cero  01/100 M.N.', resCero, 'Fallo en cero con decimal');

        // Test con mayúsculas (true)
        String resMayus = Util_Contratos.numALetra('123.45', true);
        System.assertEquals('CIENTO VEITITRÉS  45/100 M.N.', resMayus, 'Fallo en mayúsculas');
    }

    @isTest
    static void testInvalidInput() {
        // Test con letras
        String resNulo1 = Util_Contratos.numALetra('abc', false);
        System.assertEquals(null, resNulo1, 'Fallo en input inválido (abc)');

        // Test formato incorrecto (más de 2 decimales)
        String resNulo2 = Util_Contratos.numALetra('123,456', false);
        System.assertEquals(null, resNulo2, 'Fallo en input inválido (123,456)');

        // Test número demasiado grande (regex soporta hasta 9 dígitos enteros)
        String resNulo3 = Util_Contratos.numALetra('1000000000,00', false);
        System.assertEquals(null, resNulo3, 'Fallo en input inválido (numero muy grande)');
    }
}
