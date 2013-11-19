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
	
  @MatrizA = Matriz.new([[1,1],[2,2]])
  @Matrizop = Matriz.new([[-1,-1],[-2,-2]])
  @MatrizB = Matriz.new([[1,1],[2,2]])
  @MatrizC = Matriz.new([[1,1],[2,2]])
	@Matriz_Resultado = Matriz.new([[2,2],[4,4]])
	#@Matriz_Resultado1 = Matriz.new([[0,0],[0,0]])
	@MatrizAmul = Matriz.new([[2,0,1],[3,0,0],[5,1,1]])
  @MatrizBmul = Matriz.new([[1,0,1],[1,2,1],[1,1,0]])
  @Matriz_Resultado_mul = Matriz.new([[3,1,2],[3,0,3],[7,3,6]])
  
  
  #matrices dispersas
  @MaDis =  MatrizDispersa.new([[0,0,0],[1,2,3],[0,0,0]])
  @MaDis2 = MatrizDispersa.new([[0,0,0],[1,2,3],[0,0,0]])
  @MaDis3 = MatrizDispersa.new([[0,0,0],[2,4,6],[0,0,0]])
  @MaDis4 = MatrizDispersa.new([[0,0,0],[1,2,3],[0,0,0]])
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
			it "accerdera un subindice" do 
				@MatrizA.matriz[0][0].should eq 1
			end
			
			it "modificar un subindice" do 
				@MatrizC.matriz[0][0] = 2
				@MatrizA.matriz[0][0].should eq 1
			end
			
			it "sumar dos matrices de enteros" do
				( @MatrizA + @MatrizB ).should eq @Matriz_Resultado
			end
			
			 it "restar dos matrices de enteros" do
				#(@MatrizA - @MatrizB ).should eq @Matriz_Resultado1
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
			MatrizDispersa.new([[0,0,0],[1,2,3],[0,0,0]])
		end
		it "matriz densa" do
			MatrizDensa.new([[0,0,0],[1,2,3],[1,1,0]])
		end
	
 end
 
 describe "Se puede " do
	it "sumar 2 matrices dispersas" do

		(@MaDis +  @MaDis2).should eq @MaDis3
		
	end
	
	it "restar 2 matrices dispersas"do
		(@MaDis3 -  @MaDis2).should eq @MaDis4
	end
	
	it "sumar 2 matrices dispersas y den resultado una densa" do
		@MaDis11 =  MatrizDispersa.new([[0,0,0],[1,2,3],[0,0,0]])
		@MaDis22 = MatrizDispersa.new([[1,2,3],[0,0,0],[0,0,0]])
		@MaDenResul = MatrizDensa.new([[1,2,3],[1,2,3],[0,0,0]])
		
		(@MaDis11 +  @MaDis22).should eq @MaDenResul
		
	end 
 end
 
 describe "Se puede sumar una matriz densa" do
	it " con una dispersa y den resultado una densa" do
		@MaDispersa1 =  MatrizDispersa.new([[0,0,0],[1,2,3],[0,0,0]])
		@MaDensa1 = MatrizDensa.new([[1,2,3],[1,2,3],[0,0,0]])
		@MaDensaResul1 = MatrizDensa.new([[1,2,3],[2,4,6],[0,0,0]])

		(@MaDensa1 +  @MaDispersa1).should eq @MaDensaResul1
		
	end
 end
 
 
  
 
end
