# MatrizHM

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'matrizHM'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install matrizHM

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

La clase Base es la clase Matriz,en ella se definen las operaciones básicas sobre matrices. Las clase matriz dispersa y matriz densa invalidan los métodos de la clase base.
-Métodos de la clase Matriz: Los únicos métodos que se implementaron fueron el maximo y minimo que devuelven el elemento mayor de una matriz y para el segundo caso retorna el menor elemento
 El resto de métodos son idénticos a los de la práctica Nº9. Veáse dicha práctica para obtener informacion sobre los métodos implementados en esta clase.
 
-Métodos de la clase Matriz Dispersa

to_s: Método que imprime por patalla una matriz dispersa.Internamente recorre los elementos del hash y los muestra
def +(other): Permite sumar un objeto Matriz Dispersa(self) con otro pasado por parámetro.Devuelve la suma de dichos elementos que es un objeto MatrizDispersa
def -(other): Permite restar un objeto Matriz Dispersa(self) con otro pasado por parámetro.Devuelve un objeto MatrizDispersa como resta de ambas matrices
def *(other): Permite multiplicar un objeto Matriz Dispersa(self) con otro pasado por parámetro.Devuelve un objeto MatrizDispersa como multiplicación de ambas matrices
def maximo: Devuelve el mayor elemento dentro de una matriz Dispersa. Internamente Recorre un hash y retorna el mayor elemento.
def min: Devuelve el menor elemento dentro de una matriz Dispersa. Internamente Recorre un hash y retorna el menor elemento.
