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

NAO_ENCONTRADO = 0
OPCAO_SAIR = 10
ANTES = 1
DEPOIS = 0
VALIDA = 1
INVALIDA = 0

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
opcao : inteiro


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
media : real
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
   media <- soma / quantidade
   escreval("")
   escreval("Maior distancia existente........: ", maior, " km")
   escreval("Menor distancia (diferente de 0).: ", menor, " km")
   escreval("Media das distancias entre regioes: ", media:6:2, " km")
fimprocedimento

funcao localizar_entrega(codigo_busca: inteiro): inteiro
var
   i, posicao: inteiro
inicio
   posicao <- NAO_ENCONTRADO
   i <- 1
   enquanto (i <= qtd_entregas) e (posicao = NAO_ENCONTRADO) faca
      se (entregas[i].codigo = codigo_busca) entao
         posicao <- i
      fimse
      i <- i + 1
   fimenquanto
   retorne posicao
fimfuncao

funcao calcular_custo(dist_km: real; peso_kg: real; prior: inteiro): real
var
   custo_base, percentual: real
inicio
   custo_base <- dist_km * VALOR_KM
   percentual <- 0

   se (peso_kg > PESO_FAIXA_1) e (peso_kg <= PESO_FAIXA_2) entao
      percentual <- percentual + ACRESCIMO_PESO_1
   senao
      se (peso_kg > PESO_FAIXA_2) e (peso_kg <= PESO_FAIXA_3) entao
         percentual <- percentual + ACRESCIMO_PESO_2
      senao
         se (peso_kg > PESO_FAIXA_3) entao
            percentual <- percentual + ACRESCIMO_PESO_3
         fimse
      fimse
   fimse

   se (prior = URGENTE) entao
      percentual <- percentual + ACRESCIMO_URGENTE
   senao
      se (prior = PRIORITARIA) entao
         percentual <- percentual + ACRESCIMO_PRIORITARIA
      fimse
   fimse

   retorne custo_base + (custo_base * percentual)
fimfuncao

funcao nome_prioridade(prior: inteiro): caractere
var
   texto: caractere
inicio
   se (prior = URGENTE) entao
      texto <- "URGENTE"
   senao
      se (prior = PRIORITARIA) entao
         texto <- "PRIORITARIA"
      senao
         texto <- "NORMAL"
      fimse
   fimse
   retorne texto
fimfuncao

funcao nome_status(situacao: inteiro): caractere
var
   texto: caractere
inicio
   se (situacao = AGUARDANDO) entao
      texto <- "AGUARDANDO"
   senao
      se (situacao = EM_TRANSPORTE) entao
         texto <- "EM TRANSPORTE"
      senao
         texto <- "ENTREGUE"
      fimse
   fimse
   retorne texto
fimfuncao
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

      ler_codigo_novo(novo_codigo)
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
      entregas[qtd_entregas].custo <- calcular_custo(entregas[qtd_entregas].distancia, novo_peso, nova_prioridade)

      
   
      escreval("")
      escreval("Entrega cadastrada com sucesso!")
      escreval("Distancia obtida da matriz: ", entregas[qtd_entregas].distancia, " km")
      escreval("Custo estimado: R$ ", entregas[qtd_entregas].custo:10:2)
      escreval("Entregas cadastradas: ", qtd_entregas, " de ", MAX_ENTREGAS)
fimse
fimprocedimento
procedimento pausar
var
   tecla: caractere
inicio
   escreval("")
   escreva("Pressione ENTER para voltar ao menu...")
   leia(tecla)
fimprocedimento

procedimento exibir_entrega(posicao: inteiro)
inicio
   escreval("-------------------------------------------")
   escreval("Codigo.........: ", entregas[posicao].codigo)
   escreval("Destinatario...: ", entregas[posicao].destinatario)
   escreval("Origem.........: ", nomes_regioes[entregas[posicao].origem])
   escreval("Destino........: ", nomes_regioes[entregas[posicao].destino])
   escreval("Distancia......: ", entregas[posicao].distancia, " km")
   escreval("Peso...........: ", entregas[posicao].peso:10:2, " kg")
   escreval("Valor mercad...: R$ ", entregas[posicao].valor_mercadoria:10:2)
   escreval("Prioridade.....: ", nome_prioridade(entregas[posicao].prioridade))
   escreval("Status.........: ", nome_status(entregas[posicao].status))
   escreval("Custo estimado.: R$ ", entregas[posicao].custo:10:2)
fimprocedimento

procedimento listar_entregas
var
   i: inteiro
inicio
   escreval("============ LISTA DE ENTREGAS ============")
   se (qtd_entregas = 0) entao
      escreval("Nenhuma entrega cadastrada.")
   senao
      para i de 1 ate qtd_entregas faca
         exibir_entrega(i)
      fimpara
      escreval("-------------------------------------------")
      escreval("Total: ", qtd_entregas, " entrega(s).")
   fimse
fimprocedimento

procedimento consultar_entrega
var
   codigo_busca, posicao: inteiro
inicio
   escreval("============ CONSULTAR ENTREGA ============")
   escreva("Informe o codigo da entrega: ")
   leia(codigo_busca)
   posicao <- localizar_entrega(codigo_busca)
   se (posicao = NAO_ENCONTRADO) entao
      escreval("Entrega nao encontrada.")
   senao
      exibir_entrega(posicao)
   fimse
fimprocedimento

funcao deve_preceder(a, b: inteiro): inteiro
var
   resultado: inteiro
inicio
   resultado <- DEPOIS
   se (entregas[a].status = AGUARDANDO) xou (entregas[b].status = AGUARDANDO) entao
      se (entregas[a].status = AGUARDANDO) entao
         resultado <- ANTES
      fimse
   senao
      se (entregas[a].prioridade < entregas[b].prioridade) entao
         resultado <- ANTES
      senao
         se (entregas[a].prioridade = entregas[b].prioridade) e (entregas[a].valor_mercadoria > entregas[b].valor_mercadoria) entao
            resultado <- ANTES
         senao
            se (entregas[a].prioridade = entregas[b].prioridade) e (entregas[a].valor_mercadoria = entregas[b].valor_mercadoria) e (entregas[a].peso > entregas[b].peso) entao
               resultado <- ANTES
            senao
               se (entregas[a].prioridade = entregas[b].prioridade) e (entregas[a].valor_mercadoria = entregas[b].valor_mercadoria) e (entregas[a].peso = entregas[b].peso) e (entregas[a].codigo < entregas[b].codigo) entao
                  resultado <- ANTES
               fimse
            fimse
         fimse
      fimse
   fimse
   retorne resultado
fimfuncao

procedimento trocar_entregas(a, b: inteiro)
var
   aux_inteiro: inteiro
   aux_real: real
   aux_texto: caractere
inicio
   aux_inteiro <- entregas[a].codigo
   entregas[a].codigo <- entregas[b].codigo
   entregas[b].codigo <- aux_inteiro

   aux_texto <- entregas[a].destinatario
   entregas[a].destinatario <- entregas[b].destinatario
   entregas[b].destinatario <- aux_texto

   aux_inteiro <- entregas[a].origem
   entregas[a].origem <- entregas[b].origem
   entregas[b].origem <- aux_inteiro

   aux_inteiro <- entregas[a].destino
   entregas[a].destino <- entregas[b].destino
   entregas[b].destino <- aux_inteiro

   aux_real <- entregas[a].peso
   entregas[a].peso <- entregas[b].peso
   entregas[b].peso <- aux_real

   aux_real <- entregas[a].valor_mercadoria
   entregas[a].valor_mercadoria <- entregas[b].valor_mercadoria
   entregas[b].valor_mercadoria <- aux_real

   aux_inteiro <- entregas[a].prioridade
   entregas[a].prioridade <- entregas[b].prioridade
   entregas[b].prioridade <- aux_inteiro

   aux_inteiro <- entregas[a].distancia
   entregas[a].distancia <- entregas[b].distancia
   entregas[b].distancia <- aux_inteiro

   aux_inteiro <- entregas[a].status
   entregas[a].status <- entregas[b].status
   entregas[b].status <- aux_inteiro

   aux_real <- entregas[a].custo
   entregas[a].custo <- entregas[b].custo
   entregas[b].custo <- aux_real
fimprocedimento

procedimento ordenar_entregas
var
   i, j: inteiro
inicio
   para i de qtd_entregas ate 2 passo -1 faca
      para j de 1 ate i - 1 faca
         se (deve_preceder(j + 1, j) = ANTES) entao
            trocar_entregas(j, j + 1)
         fimse
      fimpara
   fimpara
fimprocedimento

procedimento exibir_fila_despacho
var
   i, posicao_fila: inteiro
inicio
   escreval("============ FILA DE DESPACHO ============")
   ordenar_entregas
   posicao_fila <- 0
   para i de 1 ate qtd_entregas faca
      se (entregas[i].status = AGUARDANDO) entao
         posicao_fila <- posicao_fila + 1
         escreval(posicao_fila, "o | Cod: ", entregas[i].codigo, " | ", nome_prioridade(entregas[i].prioridade), " | Valor: R$ ", entregas[i].valor_mercadoria:10:2, " | Peso: ", entregas[i].peso:8:2, " kg | ", entregas[i].destinatario)
      fimse
   fimpara
   se (posicao_fila = 0) entao
      escreval("Nenhuma entrega aguardando transporte.")
   fimse
fimprocedimento

funcao transicao_valida(status_atual, novo_status: inteiro): inteiro
var
   resultado: inteiro
inicio
   resultado <- INVALIDA
   se ((status_atual = AGUARDANDO) e (novo_status = EM_TRANSPORTE)) ou ((status_atual = EM_TRANSPORTE) e (novo_status = ENTREGUE)) entao
      resultado <- VALIDA
   fimse
   retorne resultado
fimfuncao

procedimento alterar_status(novo_status: inteiro)
var
   codigo_busca, posicao, status_atual: inteiro
inicio
   escreva("Informe o codigo da entrega: ")
   leia(codigo_busca)
   posicao <- localizar_entrega(codigo_busca)
   se (posicao = NAO_ENCONTRADO) entao
      escreval("ERRO: Entrega nao encontrada.")
   senao
      status_atual <- entregas[posicao].status
      se (transicao_valida(status_atual, novo_status) = VALIDA) entao
         entregas[posicao].status <- novo_status
         escreval("Status alterado: ", nome_status(status_atual), " -> ", nome_status(novo_status))
      senao
         se (status_atual = ENTREGUE) entao
            escreval("ERRO: a entrega ja foi concluida e nao pode ser modificada.")
         senao
            se (status_atual = AGUARDANDO) e (novo_status = ENTREGUE) entao
               escreval("ERRO: a entrega ainda esta AGUARDANDO. Inicie o transporte antes de finalizar.")
            senao
               escreval("ERRO: a entrega ja foi enviada (EM TRANSPORTE).")
            fimse
         fimse
      fimse
   fimse
fimprocedimento

procedimento iniciar_transporte
inicio
   escreval("============ INICIAR TRANSPORTE ============")
   alterar_status(EM_TRANSPORTE)
fimprocedimento

procedimento finalizar_entrega
inicio
   escreval("============ FINALIZAR ENTREGA ============")
   alterar_status(ENTREGUE)
fimprocedimento

procedimento exibir_estatisticas
var
   i, r: inteiro
   qtd_aguardando, qtd_transporte, qtd_entregues: inteiro
   qtd_urgentes, qtd_prioritarias, qtd_normais: inteiro
   pos_maior_valor, pos_maior_peso, pos_maior_distancia, regiao_top: inteiro
   peso_total, valor_total, custo_total: real
   entregas_por_regiao: vetor[1..MAX_REGIOES] de inteiro
inicio
   escreval("============ ESTATISTICAS ============")
   se (qtd_entregas = 0) entao
      escreval("Nenhuma entrega cadastrada.")
   senao
      qtd_aguardando <- 0
      qtd_transporte <- 0
      qtd_entregues <- 0
      qtd_urgentes <- 0
      qtd_prioritarias <- 0
      qtd_normais <- 0
      peso_total <- 0
      valor_total <- 0
      custo_total <- 0
      pos_maior_valor <- 1
      pos_maior_peso <- 1
      pos_maior_distancia <- 1
      para r de 1 ate MAX_REGIOES faca
         entregas_por_regiao[r] <- 0
      fimpara

      para i de 1 ate qtd_entregas faca
         se (entregas[i].status = AGUARDANDO) entao
            qtd_aguardando <- qtd_aguardando + 1
         senao
            se (entregas[i].status = EM_TRANSPORTE) entao
               qtd_transporte <- qtd_transporte + 1
            senao
               qtd_entregues <- qtd_entregues + 1
            fimse
         fimse

         se (entregas[i].prioridade = URGENTE) entao
            qtd_urgentes <- qtd_urgentes + 1
         senao
            se (entregas[i].prioridade = PRIORITARIA) entao
               qtd_prioritarias <- qtd_prioritarias + 1
            senao
               qtd_normais <- qtd_normais + 1
            fimse
         fimse

         peso_total <- peso_total + entregas[i].peso
         valor_total <- valor_total + entregas[i].valor_mercadoria
         custo_total <- custo_total + entregas[i].custo

         se (entregas[i].valor_mercadoria > entregas[pos_maior_valor].valor_mercadoria) entao
            pos_maior_valor <- i
         fimse
         se (entregas[i].peso > entregas[pos_maior_peso].peso) entao
            pos_maior_peso <- i
         fimse
         se (entregas[i].distancia > entregas[pos_maior_distancia].distancia) entao
            pos_maior_distancia <- i
         fimse

         entregas_por_regiao[entregas[i].destino] <- entregas_por_regiao[entregas[i].destino] + 1
      fimpara

      regiao_top <- 1
      para r de 2 ate MAX_REGIOES faca
         se (entregas_por_regiao[r] > entregas_por_regiao[regiao_top]) entao
            regiao_top <- r
         fimse
      fimpara

      escreval("Total de entregas.........: ", qtd_entregas)
      escreval("Aguardando................: ", qtd_aguardando)
      escreval("Em transporte.............: ", qtd_transporte)
      escreval("Entregues.................: ", qtd_entregues)
      escreval("Urgentes..................: ", qtd_urgentes)
      escreval("Prioritarias..............: ", qtd_prioritarias)
      escreval("Normais...................: ", qtd_normais)
      escreval("Peso total transportado...: ", peso_total:10:2, " kg")
      escreval("Media de peso.............: ", (peso_total / qtd_entregas):10:2, " kg")
      escreval("Valor total mercadorias...: R$ ", valor_total:10:2)
      escreval("Valor medio mercadorias...: R$ ", (valor_total / qtd_entregas):10:2)
      escreval("Custo total estimado......: R$ ", custo_total:10:2)
      escreval("Custo medio das entregas..: R$ ", (custo_total / qtd_entregas):10:2)
      escreval("Entrega de maior valor....: cod ", entregas[pos_maior_valor].codigo, " (R$ ", entregas[pos_maior_valor].valor_mercadoria:10:2, ")")
      escreval("Entrega de maior peso.....: cod ", entregas[pos_maior_peso].codigo, " (", entregas[pos_maior_peso].peso:8:2, " kg)")
      escreval("Entrega de maior distancia: cod ", entregas[pos_maior_distancia].codigo, " (", entregas[pos_maior_distancia].distancia, " km)")
      escreval("Regiao com mais entregas..: ", nomes_regioes[regiao_top], " (", entregas_por_regiao[regiao_top], " entrega(s))")
   fimse
fimprocedimento

procedimento exibir_menu
inicio
   limpatela
   escreval("==================================================")
   escreval("   SISTEMA DE GERENCIAMENTO DE ENTREGAS")
   escreval("==================================================")
   escreval(" 1 - Cadastrar entrega")
   escreval(" 2 - Listar entregas")
   escreval(" 3 - Consultar entrega")
   escreval(" 4 - Exibir fila de despacho")
   escreval(" 5 - Iniciar transporte")
   escreval(" 6 - Finalizar entrega")
   escreval(" 7 - Exibir matriz de distancias")
   escreval(" 8 - Exibir estatisticas")
   escreval("10 - Encerrar sistema")
   escreval("==================================================")
   escreva("Opcao: ")
fimprocedimento

Inicio
   limpatela
   escreval("==================================================")
   escreval("   SISTEMA DE GERENCIAMENTO DE ENTREGAS")
   escreval("==================================================")
   escreval(" 1 - Cadastrar entrega")
   escreval(" 2 - Listar entregas")
   escreval(" 3 - Consultar entrega")
   escreval(" 4 - Exibir fila de despacho")
   escreval(" 5 - Iniciar transporte")
   escreval(" 6 - Finalizar entrega")
   escreval(" 7 - Exibir matriz de distancias")
   escreval(" 8 - Exibir estatisticas")
   escreval("10 - Encerrar sistema")
   escreval("==================================================")
   escreva("Opcao: ")
fimprocedimento

inicio
   qtd_entregas <- 0
   inicializar_regioes
   inicializar_matriz

   repita
      exibir_menu
      leia(opcao)
      limpatela
      escolha opcao
         caso 1
            cadastrar_entrega
         caso 2
            listar_entregas
         caso 3
            consultar_entrega
         caso 4
            exibir_fila_despacho
         caso 5
            iniciar_transporte
         caso 6
            finalizar_entrega
         caso 7
            exibir_matriz_distancias
         caso 8
            exibir_estatisticas
         caso 10
            escreval("Sistema encerrado. Ate logo!")
         outrocaso
            escreval("ERRO: opcao invalida! Escolha uma opcao de 1 a ", OPCAO_SAIR, ".")
      fimescolha
      se (opcao <> OPCAO_SAIR) entao
         pausar
      fimse
   ate (opcao = OPCAO_SAIR)
Fimalgoritmo