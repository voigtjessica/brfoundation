
#Script para projeto do Brazil Foundation submetido em 09/2017

library(dplyr)

obras <- read.csv(url("http://simec.mec.gov.br/painelObras/download.php"), sep=";")

filtro_google_situacao <- c("Inacabada",
                            "Planejamento pelo proponente",
                            "Execução",
                            "Paralisada",
                            "Contratação",
                            "Licitação",
                            "Em Reformulação")


filtro_fora_google <- c("Escola com projeto elaborado pelo concedente",
                        "Escola com Projeto elaborado pelo proponente",
                        "Escola de Educação Infantil Tipo A",
                        "Escola de Educação Infantil Tipo B",
                        "Escola de Educação Infantil Tipo C",
                        "Espaço Educativo - 08 Salas",
                        "Espaço Educativo Ensino Médio Profissionalizante",
                        "MI - Escola de Educação Infantil Tipo B",
                        "MI - Escola de Educação Infantil Tipo C",
                        "Projeto Tipo B - Bloco Estrutural",
                        "Projeto Tipo C - Bloco Estrutural")



obras_fora_google <- obras %>%
  filter(Tipo.do.Projeto %in% filtro_fora_google ) %>%
  filter(Situação %in% filtro_google_situacao) 

#Adicionando os cronogramas adicionais ampliaria nosso app em 11.048 obras

grande_sp <- c("Caieiras","São Paulo",
               "Cajamar",
               "Francisco Morato", "Franco da Rocha", "Mairiporã",
               "Arujá", "Biritiba-Mirim", "Ferraz de Vasconcelos", 
               "Guararema", "Guarulhos", "Itaquaquecetuba", "Mogi das Cruzes", 
               "Poá", "Salesópolis", "Santa Isabel", "Suzano",
               "Diadema", "Mauá", "Ribeirão Pires", "Rio Grande da Serra", 
               "Santo André", "São Bernardo do Campo", "São Caetano do Sul", 
               "Cotia", "Embu das Artes", "Embu-Guaçu", "Itapecerica da Serra", 
               "Juquitiba", "São Lourenço da Serra", "Taboão da Serra", 
               "Vargem Grande Paulista", "Barueri", "Carapicuíba", "Itapevi", 
               "Jandira", "Osasco", "Pirapora do Bom Jesus", "Santana de Parnaíba")

obras_fora_google_sp <- obras_fora_google %>%
  filter(UF == "SP",
         Município %in% grande_sp) %>%
  group_by(Município) %>%
  summarise(obras = n())

obras_fora_google_sp %>%
  summarise(obras = sum(obras)) #138 obras

setwd("C:\\Users\\jvoig\\OneDrive\\Documentos\\Brazil foundation")
write.table(obras_fora_google_sp, file="obras_fora_google_sp.csv", row.names = FALSE,
            sep=";")