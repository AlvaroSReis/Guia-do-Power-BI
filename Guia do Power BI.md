# Guia de instalação e utilização do Power BI.

Resumo: Neste guia sera explicado como instalar o Power BI e sua utilização com um servidor local do PostgreSQL criado atraves do Pgadmin4, pode haver diferenças na instalação dependendo do sistema operacional e/ou hardware, informações sobre o meu estão abaixo apos os metodos de instalação.

## Para instalação do Power BI realizemos as seguintes etapas.

### Etapa 1

Faça o download do power bi acessando a pagina [clicando aqui](https://powerbi.microsoft.com/pt-br/desktop/) e realize a instalação.
OBS: Para escolher opções de idioma ou especificamente a versão 32 bits(x86) ou 64 bits, clique em "Veja as opções de download e idioma".

### Etapa 2

Agora para conectar o Power Bi a um servidor local PostgreSQL precisará baixar o Npgsql. [Clique aqui](https://github.com/npgsql/npgsql/releases/tag/v4.0.10) para acessar a pagina de download(baixe o arquivo .msi).
OBS: habilite a opção Npgsql GAC installation no instalador. E apos isto baixe o Pgadmin4 para criação do banco de dados de forma local, acesse a pagina [clicando aqui](https://www.pgadmin.org/download/).
Lembre-se do nome de usuario definido por você.

### Etapa 3

Um banco de dados de demonstração junto ao povoamento do pgadmin 4 estará disponivel para download [aqui](https://github.com/AlvaroSReis/Guia-do-Power-BI/blob/master/SQLBancoDeDadosEPovoamento.sql). Apos isto, inicie o pgadmin, precisaremos inserir o sql no banco.
Apos iniciar o pgadmin4, crie um novo servidor e banco de dados local, selecione o novo banco de dados e clique no icone do raio para poder inserir o sql, apos isto copie o sql do banco de dados de demonstração para o
pgadmin4 e execute(apertando F5 ou no outro icone do raio acima do lugar que há para inserir o texto) o query(consulta).

### Etapa 4

Finalmente vamos conectar o power bi ao nosso banco local.

1. Acesse o power bi.
2. Clique em obter dados
3. Selecione o Banco de dados postgreSQL
4. Coloque o servidor localhost e o banco de dados com o nome do banco de dados criado anteriormente por você.
5. Apos isto, coloque o nome de usuario definido por você na instalação do pgadmin4 e senha de acesso ao banco
 definida por você na criação do mesmo.
6. Apos isto você pode gerenciar e ver o modelo esquematico do banco atravess do power bi, você pode atribuir os dados do banco a graficos para melhor vizualisação.

## Observações

Uma breve descriçaõ do meu sistema operacional e hardware.

Windows 7(x64) 4 GB de memoria RAM, Processador Intel(R) Core(TM) i3-4130 CPU @ 3.40 GHz. 
