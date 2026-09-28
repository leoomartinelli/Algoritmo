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

nomes_regioes: vetor[1..MAX_REGIOES] de caractere
matriz_distancias: vetor[1..MAX_REGIOES, 1..MAX_REGIOES] de inteiro
tabela: vetor[1..5, 1..5] de inteiro
produtos : vetor[1..max_produtos] de Entrega
i, j: inteiro


procedimento inicializar_regioes
inicio

   nomes_regioes[CENTRO] <- "Centro"
   nomes_regioes[NORTE] <- "Norte"
   nomes_regioes[SUL] <- "Sul"
   nomes_regioes[LESTE] <- "Leste"
   nomes_regioes[OESTE] <- "Oeste"

fimprocedimento

procedimento inicializar_matriz
var

   i,j:inteiro

inicio

    matriz_distancias[CENTRO, NORTE] <- 12
    matriz_distancias[CENTRO, SUL] <- 15
    matriz_distancias[CENTRO, LESTE] <- 10
    matriz_distancias[CENTRO, OESTE] <- 14
    matriz_distancias[NORTE, SUL] <- 25
    matriz_distancias[NORTE, LESTE] <- 18
    matriz_distancias[NORTE, OESTE] <- 20
    matriz_distancias[SUL, LESTE] <- 16
    matriz_distancias[SUL, OESTE] <- 19
    matriz_distancias[LESTE, OESTE] <- 22
    
    para i de 1 ate MAX_REGIOES faca
         para j de 1 ate MAX_REGIOES faca
              se (i=j) entao
                 matriz_distancias[i,j]<- 0
              senao
                 se (i>j) entao
                    matriz_distancias[i,j]<-matriz_distancias[j,i]
                 fimse
              fimse
         fimpara
    fimpara
    
fimprocedimento


procedimento exibir_matriz_distancias
var
i,j,r,maior,menor,soma,quantidade : inteiro
inicio
   maior<-0
   menor<-0
   soma<-0
   quantidade<-0
    para r de 1 ate MAX_REGIOES faca
      escreva(r, "-", nomes_regioes[r], "  ")
   fimpara
   escreval("")
   escreva("     ")
   para j de 1 ate MAX_REGIOES faca
      escreva(j:6)
   fimpara
   escreval("")
   
   para i de 1 ate MAX_REGIOES faca
        escreva(i:3,"  ")
        para j de 1 ate MAX_REGIOES faca
             escreva(matriz_distancias[i, j]:6)
             
             se (matriz_distancias[i,j]>maior) entao
                maior<-matriz_distancias[i,j]
             fimse
             
             se (i <> j) entao
                soma <- soma + matriz_distancias[i, j]
                quantidade <- quantidade + 1

                se (matriz_distancias[i, j] > 0) e ((menor = 0) ou (matriz_distancias[i, j] < menor)) entao
                   menor <- matriz_distancias[i, j]
                fimse
                
             fimse
        fimpara
        escreval("")
    fimpara
fimprocedimento
Inicio
  inicializar_regioes
  inicializar_matriz
  exibir_matriz_distancias

   
   
   

Fimalgoritmo