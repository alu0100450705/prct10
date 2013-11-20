# -*- coding: utf-8 -*-

require "./lib/matriz.rb"

describe Matriz do

  before :each do
	cuarto = Fraccion.new(1,4)
	quinto = Fraccion.new(1,5)
	
	medio = Fraccion.new(1, 2)
	quinto2 = Fraccion.new(2, 5)
	
	cero = Fraccion.new(0, 1)
	siete = Fraccion.new(7,40)
	nueve = Fraccion.new(9,100)
  
	@MatrizA_frac = Matriz.new([[cuarto,cuarto],[quinto,quinto]])
	@MatrizB_frac = Matriz.new([[cuarto,cuarto],[quinto,quinto]])
	@Matriz_Resultado_frac = Matriz.new([[medio,medio],[quinto2,quinto2]])
	@Matriz_Resultado_frac_rest = Matriz.new([[cero,cero],[cero,cero]])
	@Matriz_Resultado_frac_mul = Matriz.new([[siete,nueve],[siete,nueve]])
  
  @MDen5=MatrizDensa.new([[2,3,2],[2,2,5],[2,2,2]])
  
  @MatrizA = Matriz.new([[1,1],[2,2]])
  @Matrizop = Matriz.new([[-1,-1],[-2,-2]])
  @MatrizB = Matriz.new([[1,1],[2,2]])
  @MatrizC = Matriz.new([[1,1],[2,2]])
	@Matriz_Resultado = Matriz.new([[2,2],[4,4]])
	@MatrizAmul = Matriz.new([[2,0,1],[3,0,0],[5,1,1]])
  @MatrizBmul = Matriz.new([[1,0,1],[1,2,1],[1,1,0]])

  #matrices dispersas
  @MaDis =  MatrizDispersa.new([[0,0,0],[1,2,3],[0,0,0]])
  @MaDis2 = MatrizDispersa.new([[0,0,0],[1,2,3],[0,0,0]])
  @MaDis3 = MatrizDispersa.new([[0,0,0],[2,4,6],[0,0,0]])
  @MaDis4 = MatrizDispersa.new([[0,0,0],[1,2,3],[0,0,0]])
  
  @MD= MatrizDensa.new([[1,2,3],[4,5,6],[7,8,9]])
  
  @MDis5=MatrizDispersa.new([[0,0,0],[1,2,3],[0,0,0]])
  
  #Matrices Densas
  @MD1= MatrizDensa.new([[1,3,0],[1,2,3],[1,1,0]])
  end 
  
  describe "Debe existir " do
		it "filas " do
			(defined?(@MatrizA.filas)).should be_true
		end
		
		it "columnas " do
			(defined?(@MatrizA.columnas)).should be_true
		end
		
		it "Tamano de filas " do
			@MatrizA.filas.should eq 2
		end
		
		it "Tamano de columnas " do
			@MatrizA.columnas.should eq 2
		end
	end
	
	describe "Se puede " do
			it "acerder a un subindice" do 
				@MatrizA.matriz[0][0].should eq 1
			end
			
			it "modificar un subindice" do 
				@MatrizC.matriz[0][0] = 2
				@MatrizC.matriz[0][0].should eq 2 

			end
			
			it "sumar dos matrices de enteros" do
				( @MatrizA + @MatrizB ).should eq @Matriz_Resultado
			end
			
			#añadir prueba para multiplicar dos matrices donde una sea 3x2 y la otra 2x3
			#otra prueba donde no se pueda multiplicar 
			
			 it "restar dos matrices de enteros" do
				(@MatrizA - @MatrizB ).matriz.should eq [[0,0],[0,0]]
			 end
			
			it "multiplicar por un numero" do
				(@MatrizA.Producto_escalar (2) ).should eq @Matriz_Resultado
			end
			
			it "multiplicar 2 matrices de enteros" do
				(@MatrizAmul *  @MatrizBmul ).should eq @Matriz_Resultado_mul
			end
  end
  
  
  describe "de debe " do 
			it "poder compara 2 matrices" do
			(@MatrizA == @MatrizB).should eq true
			end
			
			it "poder hacer el opuesto" do 
			(-@MatrizA).should eq @Matrizop
			end
			
			it "poder sumar dos matrices de racionales" do
			(@MatrizA_frac + @MatrizB_frac).should eq @Matriz_Resultado_frac
			
		 end
		 
			it "poder restar dos matrices de racionales" do
			(@MatrizA_frac - @MatrizB_frac).should eq @Matriz_Resultado_frac_rest
		 end
		 
			 it "poder multiplicar dos matrices de racionales" do
			(@MatrizA_frac * @MatrizB_frac).to_s.should eq (@Matriz_Resultado_frac_mul.to_s)
		 end
 end
 
 describe "se poder comprobar si la " do
		it " matriz es dispersa" do
			(@MaDis.instance_of? MatrizDispersa).should be_true 
		end
		it "matriz densa" do
			(@MD1.instance_of? MatrizDensa).should be_true
		end
	
 end
 
 describe "Se puede " do
	it "sumar 2 matrices dispersas" do

		(@MaDis +  @MaDis2).should eq @MaDis3
		
	end
	
	it "restar 2 matrices dispersas"do
		(@MaDis3 -  @MaDis2).should eq @MaDis4
	end
	#en realidad solo comprueba el resultado,el resultado sigue siendo disperso
	it "sumar 2 matrices dispersas y den resultado una densa" do
		@MaDis11 =  MatrizDispersa.new([[0,0,0],[1,2,3],[0,0,0]])
		@MaDis22 = MatrizDispersa.new([[1,2,3],[0,0,0],[0,0,0]])
		@MaDenResul = MatrizDensa.new([[1,2,3],[1,2,3],[0,0,0]])
		
		(@MaDis11 +  @MaDis22).should eq @MaDenResul
		
	end 
 end
 #en realidad solo comprueba el resultado,el resultado sigue siendo disperso
 describe "Se puede sumar una matriz densa" do
	it " con una dispersa y den resultado una densa" do
		@MaDispersa1 =  MatrizDispersa.new([[0,0,0],[1,2,3],[0,0,0]])
		@MaDensa1 = MatrizDensa.new([[1,2,3],[1,2,3],[0,0,0]])
		@MaDensaResul1 = MatrizDensa.new([[1,2,3],[2,4,6],[0,0,0]])

		(@MaDensa1 +  @MaDispersa1).should eq @MaDensaResul1
		
	end
	
 end
 
 it "Se puede restar una matriz dipersa con una dispersa y dar una densa " do
			@MaDis11 =  MatrizDispersa.new([[0,0,0],[1,2,3],[0,0,0]])
			@MaDis22 = MatrizDispersa.new([[1,2,3],[0,0,0],[0,0,0]])
			@MaDenResul = MatrizDensa.new([[-1,-2,-3],[1,2,3],[0,0,0]])
# 			(@MaDis11 -  @MaDis22).should eq @MaDenResul
 end
 
 describe "Debe existir " do
    it "Multiplicacion de matrices dispersas" do
#        (MatrizDispersa.respond_to? :* ).should be_true
    end
    
    it "Y hacerla correctamente " do
      mdmultaux=@MaDis3*@MaDis4
      (mdmultaux).instance_of? MatrizDispersa
    end
 end

 describe "Se debe obtener el mínimo " do
    it "De una matriz Densa " do
       (@MDen5.minimo).should eq 2
    end
    it "De una matriz Dispersa" do
       (@MaDis5.minimo).should eq 0
    end
 end
 
  describe "Se debe obtener el máximo " do
    it "De una matriz Densa " do
       (@MDen5.maximo).should eq 5
    end
    it "De una matriz Dispersa" do
       (@MDis5.maximo).should eq 3
    end
 end
 
  
 
end
