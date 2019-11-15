## Semana 02 - Captura de datos
1. Para realizar el módulo de recolección de datos se tuvo que analizar los diagramas de las señales de control (pclk, vsync,href) para poder realizar   una especie de máquina de estado en la cuál utilizamos un contador que cambia entre estados 0 y  1 para saber qué byte está se está leyendo, la idea principal es que si dicho contador se encuentra en el estado 0 vamos a tomar los bits más significativos del color Rojo(R), 
y el verde(G), y si se encuentra el contador en estado 1, tomar los datos del color azul(blue), y para ahorrarnos algunos procesos intermedios llenaremos la salida (data in [7:0]) de la siguiente forma:  


		wire contador=0;  
		always @ (negedge Pclk) begin  
			if	(Vsync==0) begin  

				if    (Href==1) begin  
					if	(contador==0)begin
					assign data_in[7:5]={Data[7:5]};
					assign data_in[4:2]={Data[2:0]};
					contador=1;
					end
						if	(contador==1)begin
						assign data_in[1:0]={Data[4:3]};
						contador=0;
						end
				end
			end

		end

de esta forma al tiempo que hacemos la captura de datos estamos haciendo la conversión de 565 a 332 (RGB), ahorramos un tiempo de procesamiento y reducimos un proceso largo a una máquina de dos estados, y esta máquina repetirá sus procesos hasta completar la totalidad de píxeles de la imágen.

3. Se generó un nuevo PLL con Clocking Wizard. en el IDE de ISE utilizando tools -> Core Generator ... y se generó el ip con Clocking Wizard.

En este proceso se cambió el clock de entrada de 32 MHz por uno de 100 MHz ya que la fpga que estamos usando para este proyecto es la Nexys 4 y tiene un clock interno de 100 Mhz.

Los cambios realizados se pueden evidenciar en la carpeta camNexys4 el archivo clk_100MHZ_to_25M_24M_.v
### PUEBA DEL TAMAÑO DE LA FOTO

![archivo base .men!]( /docs/figs/código_base_prueba_tamaño_foto.jpeg "archivo base .men")
inicialmente se realizó uan prueba para saber si als adapataciones hechas al código funcionaron, para ello se utilizó el mismo "color" que el profesor 
nos dio en el archivo .men, como se evidencia en esta imagen del monitor, las adaptaciones son exitosas y funciona el cargar la imagen del archivo .men
a la memoria.

posteriormente decicidoms llenar toda la memoria de un color sólido (Rojo), y únicamente dejar un recuadro de 320x240 píxeles que corresponde al tamaño de la foto, esto lo realizamos para tener un acercamiento con el funcionamiento de la pantalla VGA, gracias a este acercamiento pudimos evidenciar que la memoria en ciertos casos se suele llenar automáticamente con e color del último píxel descrito en el archivo .men, debido a esto tomamos la decisión de llenar toda la memoria como ya se menicionó, de color rojo y posteriormente crear el recuadro blanco correspondiente al tamaño de la foto.
![archivo .men!]( /docs/figs/prueba_tamaño_foto.jpeg "archivo .men")
