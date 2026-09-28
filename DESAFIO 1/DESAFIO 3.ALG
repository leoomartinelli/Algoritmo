Algoritmo "Desafio 3"
//
//
// Descricao   : Aqui voce descreve o que o programa faz! (funcao)
// Autor(a)    : Leonardo Martinelli de Oliveira LIma
// Data atual  : 9/22/2026


const
max_produtos = 10
MAX_ENTREGAS = 30
MAX_REGIOES = 5
MAX_PERCURSO = 10
MIN_PERCURSO = 2


CENTRO = 1
NORTE = 2
SUL = 3
LESTE = 4
OESTE = 5


URGENTE = 1
PRIORITARIA = 2
NORMAL = 3
AGUARDANDO = 1
EM_TRANSPORTE = 2
ENTREGUE = 3


VALOR_KM = 2.50
PESO_FAIXA_1 = 5
PESO_FAIXA_2 = 20
PESO_FAIXA_3 = 50
PESO_MAXIMO = 1000
ACRESCIMO_PESO_1 = 0.10
ACRESCIMO_PESO_2 = 0.20
ACRESCIMO_PESO_3 = 0.35
ACRESCIMO_PRIORITARIA = 0.15
ACRESCIMO_URGENTE = 0.30

tipo

Entrega = registro
  codigo : inteiro
  destinatario : caractere
  origem : inteiro
  destino : inteiro
  peso : real
  valorMErcadoria : real
  prioridade : inteiro
  distancia : real
  status : inteiro
  custo : real
fimregistro




Var

regioes: vetor[1..5] de caractere
tabela: vetor[1..5, 1..5] de inteiro
produtos : vetor[1..max_produtos] de Entrega
i, j: inteiro

procedimento mostrar_tabela
inicio
   // Cabecalho
   escreva("Origem/Destino":15)
   para j de 1 ate 5 faca
      escreva(regioes[j]:8)
   fimpara
   escreval("")

   // Linhas
   para i de 1 ate 5 faca
      escreva(regioes[i]:15)
      para j de 1 ate 5 faca
         escreva(tabela[i,j]:8)
      fimpara
      escreval("")
   fimpara
fimprocedimento



Inicio

   // Nomes das regioes (1=Centro, 2=Norte, 3=Sul, 4=Leste, 5=Oeste)
   regioes[1] <- "Centro"
   regioes[2] <- "Norte"
   regioes[3] <- "Sul"
   regioes[4] <- "Leste"
   regioes[5] <- "Oeste"

   // Centro
   tabela[1,1] <- 0
   tabela[1,2] <- 12
   tabela[1,3] <- 15
   tabela[1,4] <- 10
   tabela[1,5] <- 14

   // Norte
   tabela[2,1] <- 12
   tabela[2,2] <- 0
   tabela[2,3] <- 25
   tabela[2,4] <- 18
   tabela[2,5] <- 20

   // Sul
   tabela[3,1] <- 15
   tabela[3,2] <- 25
   tabela[3,3] <- 0
   tabela[3,4] <- 16
   tabela[3,5] <- 19

   // Leste
   tabela[4,1] <- 10
   tabela[4,2] <- 18
   tabela[4,3] <- 16
   tabela[4,4] <- 0
   tabela[4,5] <- 22

   // Oeste
   tabela[5,1] <- 14
   tabela[5,2] <- 20
   tabela[5,3] <- 19
   tabela[5,4] <- 22
   tabela[5,5] <- 0

   mostrar_tabela
   
   
   

Fimalgoritmo