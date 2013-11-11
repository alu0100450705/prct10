# -*- coding: utf-8 -*-

require "./lib/matriz.rb"

describe Matriz do

  before :each do
	cuarto = Fraccion.new(1, 4)
	quinto = Fraccion.new(1, 5)
	
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
	@Matriz_Resultado1 = Matriz.new([[0,0],[0,0]])
	@MatrizAmul = Matriz.new([[2,0,1],[3,0,0],[5,1,1]])
    @MatrizBmul = Matriz.new([[1,0,1],[1,2,1],[1,1,0]])
    @Matriz_Resultado_mul = Matriz.new([[3,1,2],[3,0,3],[7,3,6]])
  end
	it "Deben existir filas " do
		(defined?(@MatrizA.filas)).should be_true
	end
	
	it "Deben existir columnas " do
		(defined?(@MatrizA.columnas)).should be_true
	end
	
	it "Tamano de filas " do
		@MatrizA.filas.should eq 2
	end
	
	it "Tamano de columnas " do
		@MatrizA.columnas.should eq 2
	end
	
	it "Se puede accerdera un subindice" do 
		@MatrizA.matriz[0][0].should eq 1
	end
	
	it "Se puede modificar un subindice" do 
		@MatrizC.matriz[0][0] = 2
		@MatrizA.matriz[0][0].should eq 1
	end
	
	it "Se debe poder sumar dos matrices de enteros" do
		( @MatrizA + @MatrizB ).should eq @Matriz_Resultado
	end
  
   it "Se debe poder restar dos matrices de enteros" do
    (@MatrizA - @MatrizB ).should eq @Matriz_Resultado1
   end
  
  it "Se debe poder multiplicar por un numero" do
    (@MatrizA.Producto_escalar (2) ).should eq @Matriz_Resultado
  end
  
  it "Se debe poder multiplicar 2 matrices de enteros" do
    (@MatrizAmul *  @MatrizBmul ).should eq @Matriz_Resultado_mul
  end
  
  it "Se debe poder compara 2 matrices" do
	(@MatrizA == @MatrizB).should eq true
  end
  
  it "Se debe poder hacer el opuestngth' for 2:Fio" do 
	(-@MatrizA).should eq @Matrizop
  end
  
  it "Se debe poder sumar dos matrices de racionales" do
	(@MatrizA_frac + @MatrizB_frac).should eq @Matriz_Resultado_frac
	
 end
 
  it "Se debe poder restar dos matrices de racionales" do
	(@MatrizA_frac - @MatrizB_frac).should eq @Matriz_Resultado_frac_rest
 end
 
   it "Se debe poder multiplicar dos matrices de racionales" do
	(@MatrizA_frac * @MatrizB_frac).to_s.should eq (@Matriz_Resultado_frac_mul.to_s)
 end
 
 
end
