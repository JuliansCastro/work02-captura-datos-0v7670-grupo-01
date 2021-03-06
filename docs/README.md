## Semana 02 - Captura de datos
### preguntas de DESARROLLO
1. Para realizar el módulo de recolección de datos se tuvo que analizar los diagramas de las señales de control (pclk, vsync,href) para poder realizar   una especie de máquina de estado en la cuál utilizamos un contador que cambia entre estados 0 y  1 para saber qué byte está se está leyendo, la idea principal es que si dicho contador se encuentra en el estado 0 vamos a tomar los bits más significativos del color Rojo(R), 
y el verde(G), y si se encuentra el contador en estado 1, tomar los datos del color azul(blue), y para ahorrarnos algunos procesos intermedios llenaremos la salida (data in [7:0]) de la siguiente forma:  


		 reg contador=1'b0;
		 reg [16:0]addr=0;
		 always @ (negedge Pclk) begin
				if (Vsync==0) begin
					if (Href==1) begin
					regWrite=0;
						if (contador==0)begin
							data_in[7]=Data[7];
							data_in[6]=Data[6];
							data_in[5]=Data[5];
							data_in[4]=Data[2];
							data_in[3]=Data[1];
							data_in[2]=Data[0];
						end
		  				if (contador==1)begin
							data_in[1]=Data[4];
							data_in[0]=Data[3];
							regWrite=1;
							addr_in<=addr;
							addr=addr+1;
						end
					contador=contador+1;
				end
			end
		end

de esta forma al tiempo que hacemos la captura de datos estamos haciendo la conversión de 565 a 332 (RGB), ahorramos un tiempo de procesamiento y reducimos un proceso largo a una máquina de dos estados, y esta máquina repetirá sus procesos hasta completar la totalidad de píxeles de la imágen.

El bloque estructural para el módulo de captura de datos es el siguiente:
![archivo base .men!]( /docs/figs/Bloque_Captura.png "archivo base .men")

La siguiente figura representa el bloque funcional para dicho módulo:
![archivo base .men!]( /docs/figs/Bloque_Funcional_Captura.png "archivo base .men")

3. Se generó un nuevo PLL con Clocking Wizard. en el IDE de ISE utilizando tools -> Core Generator ... y se generó el ip con Clocking Wizard.

En este proceso se cambió el clock de entrada de 32 MHz por uno de 100 MHz ya que la fpga que estamos usando para este proyecto es la Nexys 4 y tiene un clock interno de 100 Mhz.

Los cambios realizados se pueden evidenciar en la carpeta camNexys4 el archivo clk_100MHZ_to_25M_24M_.v
## PREGUNTAS DE IMPLEMENTACIÓN
### PUEBA DEL TAMAÑO DE LA FOTO

![archivo base .men!]( /docs/figs/código_base_prueba_tamaño_foto.jpeg "archivo base .men")
inicialmente se realizó uan prueba para saber si als adapataciones hechas al código funcionaron, para ello se utilizó el mismo "color" que el profesor 
nos dio en el archivo .men, como se evidencia en esta imagen del monitor, las adaptaciones son exitosas y funciona el cargar la imagen del archivo .men
a la memoria.

posteriormente decicidoms llenar toda la memoria de un color sólido (Rojo), y únicamente dejar un recuadro de 320x240 píxeles que corresponde al tamaño de la foto, esto lo realizamos para tener un acercamiento con el funcionamiento de la pantalla VGA, gracias a este acercamiento pudimos evidenciar que la memoria en ciertos casos se suele llenar automáticamente con e color del último píxel descrito en el archivo .men, debido a esto tomamos la decisión de llenar toda la memoria como ya se menicionó, de color rojo y posteriormente crear el recuadro blanco correspondiente al tamaño de la foto.
![archivo .men!]( /docs/figs/prueba_tamaño_foto.jpeg "archivo .men")
NOTA:revisar el archivo UCF anexo para realizar estas pruebas

### CONFIGURACIÓN DE LA CAMARA 
para la configuración de la cámara se utilizó un arduino uno, jumpers y la ayuda de un código encontrado en internet, no fue posible realizar muchas pruebas pero dentro de las que se realizaron no se obtuvieron los resultados esperado, dado que se esperaba la observación de video en un tamaño 320x240, pero lo únco que se pudo observar en repetidas ocasiones fue que el recuadro de 320x240 estaba capturando solo ruido y estaba recopilando información de forma erronea, se llega a la conclsión de que es necesario revisar en primera instancia la conexión de la cámara y posteriormente el código utilizado para su configuración, pero por razones de tiempo las actualizaciones de la reparación de estos errores sera evidenciada más adelante la próxima semana.

en la siguiente imagen podemos observar el error evidenciado en una de las pruebas:  

![error.men!]( /docs/figs/error.jpg "error.men")

### ¿QUÉ FALTA PARA IMPLEMENTAR PARA TENER DE LA TOMA DE FOTOS?

Determinamos que para tener control total hace falta agregar un botón que nos permita realizar la captura de la foto, es decir, al presionarlo se accione el sistema de captura instantanea de lo que esté frente a la cámara para así guardar la imagen como tal y no esté cosntantemente capturando nuevos datos. 


