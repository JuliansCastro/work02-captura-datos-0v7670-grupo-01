## Semana 02 - Captura de datos

3. Se generó un nuevo PLL con Clocking Wizard. en el IDE de ISE utilizando tools -> Core Generator ... y se generó el ip con Clocking Wizard.

En este proceso se cambió el clock de entrada de 32 MHz por uno de 100 MHz ya que la fpga que estamos usando para este proyecto es la Nexys 4 y tiene un clock interno de 100 Mhz.

Los cambios realizados se pueden evidenciar en la carpeta camNexys4 el archivo clk_100MHZ_to_25M_24M_.v
