# coding: utf-8
module Operatoria
     
   #Funcion que asigna un valor k a una posicion i,j dentro de la matriz
   def []=(i, j, k)
      matriz[i][j] = k
   end
  
    #Sobrecargado el + para poder sumar 2 matrices
   def +(other)
      raise ArgumentError, "La longitud de las matrices no coincide." unless @filas == other.filas && @columnas == other.columnas       
      sum = Matriz.new(matriz)  #inicializas el vector sum con el primer con el primer
      self.filas.times do |i|   
         self.columnas.times do |j|
            sum.matriz[i][j] = self.matriz[i][j] + other.matriz[i][j]             
         end
      end
      return sum #devuelve un tipo array modificando el objeto m1 si se hace m3=m1+m2 -> Se necesita q sea tipo Matriz
   end
   
   #Sobrecargado el - para poder restar 2 matrices
   def -(other)
      raise ArgumentError, "La longitud de las matrices no coincide." unless @filas == other.filas && @columnas == other.columnas
      resta = Matriz.new(matriz)
      self.filas.times do |i|  
         self.columnas.times do |j|
            resta.matriz[i][j] = self.matriz[i][j] - other.matriz[i][j]             
         end
      end
      return resta  #devuelve un tipo matriz modificando el objeto m1 si se hace m3=m1+m2
   end
   

   def Producto_escalar (other)
      mul = Matriz.new(matriz)
      self.filas.times do |i|  
         self.columas.times do |j|
            mul.matriz[i][j] = self.matriz[i][j] * other
         end
      end
      return mul
   end
   
   #Para comprobar que dos matrices son equivalentes,primero se comprueba sus dimensiones. Si tienen las mismas dimensiones se comprueba que el valor de ambas matrices sean iguales en las mismas posiciones,si esto es así se devuelve true,false en otro caso.
   def ==(other)
      dev=true
      if ((self.filas.size==other.filas.size) && (self.columnas.size==other.columnas.size))
         self.filas.times do |i| 
            self.columnas.times do |j|
               if (self.matriz[i,j] != other.matriz[i,j])
	          dev=false
	       else
	       end
	    end
	 end
      else
         dev=false
      end
      return dev
   end
   
   
   #Realiza el opuesto de una matriz
   def -@ 
   op = Matriz.new(matriz)
      self.filas.times do |i|   		
         self.columas.times do |j|
            op.matriz[i][j] = -self.matriz[i][j]
         end
      end
      return op
   
   end
   
   #Dos matrices son multiplicables si el numero de columnas de A coincide con el numero de filas de B
   def * (other)
      raise ArgumentError, "La longitud de las matrices no coincide." unless @columnas == other.filas
      elemento = Array.new
      acumulado = 0
      self.filas.times do |i|
         elemento_fila = Array.new
         other.columnas.times do |j|
            acumulado = 0
            self.columnas.times do |k|
               suma = @matriz[i][k] * other.matriz[k][j]
               acumulado = suma + acumulado
            end
            elemento_fila << acumulado
         end
         elemento << elemento_fila
      end
      Matriz.new(elemento)
   end
end
  
#Clase Base que contiene el metodo initilize y los getters. Además contiene el to_s y el método [] 
class Matriz
   require "gcd.rb"   #definicion del metodo maximo comun divisor
   require "racional.rb" #definicion de la clase racional
   include Operatoria
   attr_reader :matriz, :filas, :columnas
   
   def initialize(matriz)
      @matriz = Array.new(matriz)
      @filas = matriz.size
      @columnas = matriz[0].size
   end
   
      #Imprime la matrices
   def to_s
      self.columnas.times do |i|   
         self.filas.times do |j|
            print "#{matriz[i][j]}  "
         end
	 puts
      end
      puts 
   end
      
#    
#       muestra la matriz (los indices empiezan por 0) seleccionando en el primer elemento el subarray al que pertenece el elemento que se quiere mostrar ,luego con el otro atributo seleccionamos la posicion que ocupa dicho elemento en este subvector.
#       ejemplo:  m1=[ [1,2,3] , [4,5,6] ]
#       puts m1[0,1] -> 2
#       puts m1[1,1] -> 6
#    
   def [](i,j)
      matriz[i][j]
   end
   
end

#matriz normal
class MatrizDensa < Matriz
  
end

class MatrizDispersa < Matriz
    #modificar el initialize,pues no necesito almacenar los '0' guardar los indices donde se encuentran dichos ceros
    #metodo que dado una fila y columna y un porcentaje de ceros prc,construye una matriz aleatoria
    attr_reader :hash_ceros,:array_ceros
    def initialize(f,c,prc)    
       raise ArgumentError, 'El primer argumento no es numerico' unless f.is_a? Numeric
       raise ArgumentError, 'El segundo argumento no es numerico' unless c.is_a? Numeric
       raise ArgumentError, 'El tercer argumento no es un numero flotante' unless prc.is_a? Float            
       @filas = f
       @columnas = c
       n_elementos= f*c  
       if (prc<0.6) || (prc>0.99)
          raise RuntimeError, "el porcentaje de ceros 'prc' debe estar en el intervalo [60,100],incluido los extremos"
       else
          n_ceros= (n_elementos*prc).round #round redonde al entero mas proximo	    
# 	  puts "valor de n_ceros= #{n_ceros}"
          #contruyo la estructura donde me indique las posiciones en las que hay 0
	  @array_ceros=Array.new
	  @array_no_ceros=Array.new
	  #itero hasta el numero de ceros y los guardo en un vector
	  n_ceros.times do |i|
# 	     puts i
	     pos_cero=rand(n_elementos)  #me da una posicion de las posibles filas*columnas(se repite a veces,buscar mejora)
	     @array_ceros << pos_cero
	  end
	  i=0
	  while (i < ((@filas*@columnas)-n_ceros))  do
             @array_no_ceros << rand(n_elementos)   
          end
# 	  puts "tamaño del vector ceros #{array_ceros.size}"
# 	  puts array_ceros
# 	  @hash_ceros = {:posicion_ceros => array_ceros}

       end
    end

    def to_s
       self.filas.times |i| do
          self.columnas.times |j| do
	     begin
	        k=i+j
	        if (self.array_ceros.include? k)  #si la posicion k esta dentro del array_ceros es que debo mostrar un cero en esa posicion
                   print "0  "
	        else
	           print "#{self.array_no_ceros[k]} " 
	        end
	     end
	  end
       end
#        @hash_ceros.each do |clave,valor|
#           print "#{clave} : #{valor} "
#        end
       puts
    end
    
    #Necesito un metodo que dada una posion i,j dentro del vector me devuelva true si esa posicion es un 0 para realizar las operaciones  conforme a ello.
#     def es_cero(i,j)
#        if (matriz[i][j]==0)
#           return true
#        else 
#           return false
#        end
#     end
end

# m1 = Matriz.new([[2,0,1],[3,0,0],[5,1,1]])
# m2 = Matriz.new([[1,0,1],[1,2,1],[1,1,0]])
# puts m3=m1+m2
md1=MatrizDispersa.new(3,3,0.60)
puts md1
