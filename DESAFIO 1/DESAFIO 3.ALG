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
  valor_mercadoria : real
  prioridade : inteiro
  distancia : real
  status : inteiro
  custo : real
fimregistro




Var

nomes_regioes: vetor[1..MAX_REGIOES] de caractere
matriz_distancias: vetor[1..MAX_REGIOES, 1..MAX_REGIOES] de inteiro
entregas: vetor[1..MAX_ENTREGAS] de entrega
qtd_entregas : inteiro
percurso: vetor[1..MAX_PERCURSO] de inteiro


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
//////////////////////////////////////////// #LEITURAS
procedimento ler_codigo_novo(var codigo: inteiro)
var

   posicao: inteiro

inicio
   repita
      escreva("Codigo da entrega (numero positivo): ")
      leia(codigo)
      posicao <- localizar_entrega(codigo)
      
      se (codigo <= 0) entao
         escreval("ERRO: o codigo deve ser maior que zero.")
      senao
         se (posicao <> NAO_ENCONTRADO) entao
            escreval("ERRO: codigo ", codigo, " ja cadastrado (codigo duplicado).")
         fimse
      fimse
   ate (codigo > 0) e (posicao = NAO_ENCONTRADO)

fimprocedimento



procedimento ler_destinatario(var nome: caractere)
inicio
   repita
      escreva("Nome/descricao do destinatario: ")
      leia(nome)
      se (nome = "") entao
         escreval("ERRO: o destinatario nao pode ficar em branco.")
      fimse
   ate (nome <> "")
fimprocedimento

procedimento ler_origem_destino(var orig, dest: inteiro)
inicio
   repita
      ler_regiao("Regiao de ORIGEM", orig)
      ler_regiao("Regiao de DESTINO", dest)
      se (orig = dest) entao
         escreval("ERRO: origem e destino nao podem ser a mesma regiao.")
      fimse
   ate (orig <> dest)
fimprocedimento


procedimento ler_peso(var peso_lido: real)
inicio
   repita
      escreva("Peso da carga (kg): ")
      leia(peso_lido)
      se (peso_lido <= 0) ou (peso_lido > PESO_MAXIMO) entao
         escreval("ERRO: peso invalido. Deve ser maior que 0 e no maximo ", PESO_MAXIMO, " kg.")
      fimse
   ate (peso_lido > 0) e (peso_lido <= PESO_MAXIMO)
fimprocedimento


procedimento ler_valor(var valor_lido: real)
inicio
   repita
      escreva("Valor da mercadoria (R$): ")
      leia(valor_lido)
      se (valor_lido < 0) entao
         escreval("ERRO: o valor da mercadoria nao pode ser negativo.")
      fimse
   ate (valor_lido >= 0)
fimprocedimento


procedimento ler_prioridade(var prior: inteiro)
inicio
   repita
      escreva("Prioridade (1-Urgente  2-Prioritaria  3-Normal): ")
      leia(prior)
      se (prior < URGENTE) ou (prior > NORMAL) entao
         escreval("ERRO: prioridade inexistente.")
      fimse
   ate (prior >= URGENTE) e (prior <= NORMAL)
fimprocedimento

procedimento ler_regiao(mensagem: caractere; var regiao: inteiro)
inicio
   repita
      escreval(mensagem, ":")
      exibir_legenda_regioes
      escreva("Codigo da regiao: ")
      leia(regiao)
      se (regiao < 1) ou (regiao > MAX_REGIOES) entao
         escreval("ERRO: regiao inexistente. Informe um codigo de 1 a ", MAX_REGIOES, ".")
      fimse
   ate (regiao >= 1) e (regiao <= MAX_REGIOES)
fimprocedimento

procedimento exibir_legenda_regioes
var
   r: inteiro
inicio
   para r de 1 ate MAX_REGIOES faca
      escreva(r, "-", nomes_regioes[r], "  ")
   fimpara
   escreval("")
fimprocedimento

procedimento cadastrar_entrega
var
   novo_codigo, nova_origem, novo_destino, nova_prioridade: inteiro
   novo_destinatario: caractere
   novo_peso, novo_valor: real
   
inicio

se (qtd_entregas>=MAX_ENTREGAS) entao
   escreval("Erro, capacidade maxima:",MAX_ENTREGAS,"")
senao

      ler_destinatario(novo_destinatario)
      ler_origem_destino(nova_origem, novo_destino)
      ler_peso(novo_peso)
      ler_valor(novo_valor)
      ler_prioridade(nova_prioridade)

      qtd_entregas <- qtd_entregas + 1
      entregas[qtd_entregas].codigo <- novo_codigo
      entregas[qtd_entregas].destinatario <- novo_destinatario
      entregas[qtd_entregas].origem <- nova_origem
      entregas[qtd_entregas].destino <- novo_destino
      entregas[qtd_entregas].peso <- novo_peso
      entregas[qtd_entregas].valor_mercadoria <- novo_valor
      entregas[qtd_entregas].prioridade <- nova_prioridade
      entregas[qtd_entregas].distancia <- matriz_distancias[nova_origem, novo_destino]
      entregas[qtd_entregas].status <- AGUARDANDO

      
   
      escreval("")
      escreval("Entrega cadastrada com sucesso!")
      escreval("Distancia obtida da matriz: ", entregas[qtd_entregas].distancia, " km")
      escreval("Entregas cadastradas: ", qtd_entregas, " de ", MAX_ENTREGAS)
fimse
fimprocedimento
Inicio
  inicializar_regioes
  inicializar_matriz
  exibir_matriz_distancias
  cadastrar_entrega
  


   
   
   

Fimalgoritmo