# coding: utf-8
require "racional.rb" #definicion de la clase racional

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
         self.columnas.times do |j|
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
               if (self.matriz[i][j] != other.matriz[i][j])
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
         self.columnas.times do |j|
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
    
   include Operatoria
   attr_accessor :matriz, :filas, :columnas
   
   def initialize(matriz)
      @matriz = Array.new(matriz)
      @filas = matriz.size
      @columnas = matriz[0].size
      @n_elementos= (matriz.size * matriz[0].size)*0.6 
       n_ceros=0
      filas.times do |i|
         columnas.times do |j|
	    if (matriz[i][j]==0)  
	       n_ceros=n_ceros+1
			end
      end
      end
      if n_ceros > @n_elementos
         raise RuntimeError, 'La Matriz no es densa'
      end
     
   end
   
   def comprobar (matriz)
   
    n_ceros=0
      filas.times do |i|
         columnas.times do |j|
	    if (matriz[i][j]==0)  
	       n_ceros=n_ceros+1
			end
      end
      end
      if n_ceros > @n_elementos
         raise RuntimeError, 'La Matriz no es densa'
      end
   end
   
      #Imprime la matrices
   def to_s
      filas.times do |i|   
         columnas.times do |j|
            print "#{matriz[i][j]}  "
         end
				puts
      end
      puts 
   end
      

   def [](i,j)
      matriz[i][j]
   end
   
end

#matriz normal
class MatrizDensa < Matriz

	def +(other) 
		suma=MatrizDensa.new(Array.new(@filas,1){Array.new(@columnas,1)})
		filas.times do |i|
         columnas.times do |j|
						if (other.hash_no_ceros.key?("#{i}#{j}"))
							suma.matriz[i][j] = other.hash_no_ceros["#{i}#{j}"] + matriz[i][j]
						else
							suma.matriz[i][j] =  matriz[i][j]
						end
					end
       end
       return suma		
	end
  
end

class MatrizDispersa < Matriz
    #modificar el initialize,pues no necesito almacenar los '0' guardar los indices donde se encuentran dichos ceros
    #metodo que dado una fila y columna y un porcentaje de ceros prc,construye una matriz aleatoria
    attr_accessor :hash_no_ceros, :filas, :columnas
    
   def initialize(matriz)
      @filas = matriz.size
      @columnas = matriz[0].size
      @hash_no_ceros={}
       
     #comprobamos que la matriz es dispersa o no
     @n_elementos= (matriz.size * matriz[0].size)*0.6 
     n_ceros=0
      filas.times do |i|
         columnas.times do |j|
						if (matriz[i][j]==0)  
							 n_ceros=n_ceros+1
						else
							 pos_no_cero="#{i}#{j}"
							 @hash_no_ceros[pos_no_cero]=matriz[i][j] 
						end
					end
      end
      
      if n_ceros < @n_elementos
         raise RuntimeError, 'La Matriz no es dispersa'
      else
      end
      
   end
   
   
   def comprobar (hash)
	if hash.length  > ((@filas * @columnas)*0.4)
		false
	else
		true
   end
   end
    
    def to_s
       filas.times do |i|
         columnas.times do |j|
	    if (hash_no_ceros.key?("#{i}#{j}"))
	       print hash_no_ceros["#{i}#{j}"]
	       print "  "
	    else
	       print "0  "
	    end
	 end
	 puts
       end
    end #def to_s
    
    
    def +(other)
      raise TypeError, "La matriz other no es dispersa" unless other.instance_of? MatrizDispersa
      raise ArgumentError, "La longitud de las matrices no coincide." unless @filas == other.filas && @columnas == other.columnas
      suma=MatrizDispersa.new(Array.new(@filas,0){Array.new(@columnas,0)})
      suma.hash_no_ceros = (hash_no_ceros.merge(other.hash_no_ceros){|key,oldval,newval| oldval+newval}).clone
      if comprobar(suma.hash_no_ceros)
					return suma
      else
					m = Array.new(@filas,0){Array.new(@columnas,0)}
					suma.hash_no_ceros.each {|key, value| m[(key[0]).to_i][(key[1]).to_i] = value }
					sum = MatrizDensa.new(m)
		return sum
      end
      
			
    end
    
     def -(other)
      raise TypeError, "La matriz other no es dispersa" unless other.instance_of? MatrizDispersa
      raise ArgumentError, "La longitud de las matrices no coincide." unless @filas == other.filas && @columnas == other.columnas
      resta=MatrizDispersa.new(Array.new(@filas,0){Array.new(@columnas,0)})
      resta.hash_no_ceros = (self.hash_no_ceros.merge(other.hash_no_ceros){|key,oldval,newval| oldval-0-newval}).clone      
      if comprobar(resta.hash_no_ceros)
					return resta
      else
					puts resta.hash_no_ceros
					m = Array.new(@filas,0){Array.new(@columnas,0)}
					resta.hash_no_ceros.each {|key, value| m[(key[0]).to_i][(key[1]).to_i] = value }
					res = MatrizDensa.new(m)
					return res
			end
		end
    
   def ==(other)
			hash_no_ceros == other.hash_no_ceros
   end
    
   
end


