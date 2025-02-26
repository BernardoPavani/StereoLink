🎵 Plataforma de Visibilidade para Novos Artistas
📖 Visão Geral
A Plataforma de Visibilidade para Novos Artistas é um sistema dedicado a músicos independentes que desejam compartilhar suas criações e alcançar o público que merecem. Criada para enfrentar os desafios do mainstream, onde os algoritmos frequentemente priorizam grandes nomes da indústria, esta plataforma oferece um espaço exclusivo para a promoção de novos talentos musicais.

🚀 Funcionalidades Principais
- Para Músicos Cadastro de Artista: Solicitação de cadastro como músico para obter acesso às ferramentas. CRUD de Álbum e Músicas:

- Para Ouvintes Navegação e Busca: Pesquisar músicas filtrando por artista, faixa ou álbum. Exploração de Novos Talentos: Descobrir novos artistas independentes.


🔒 Segurança
- Criptografia de Dados: Login e senha armazenados de forma criptografada no banco de dados. Toda comunicação entre o frontend e o backend é criptografada para garantir a segurança dos dados dos usuários.

👥 Tipos de Usuários
- Músicos: Usuários que criam álbuns e músicas.
- Ouvintes: Usuários que exploram e consomem as músicas disponíveis na plataforma. Administradores: Usuários com permissão para gerenciar o conteúdo da plataforma.

📚 Regras e Padrões para Uso do Git
- Commits: Redigir mensagens de commit de forma clara e objetiva, empregando o gerúndio para indicar a ação realizada (ex.: "Adicionando suporte à funcionalidade Y").Garantir que cada commit represente uma alteração isolada e coesa, sem misturar múltiplas modificações não relacionadas. Associar cada commit às issues correspondentes no backlog para manter o rastreamento adequado.Evitar commits genéricos, como "Ajustes" ou "Correções", fornecendo um contexto mais detalhado sobre a mudança.
- Branches: Realizar a integração de branches na branch "main" somente após a aprovação dos testes e validação das novas implementações. Criar branches específicas e bem identificáveis para correções urgentes, garantindo uma abordagem organizada para a resolução de problemas críticos. Sempre remover branches obsoletas após a conclusão e merge das alterações, evitando acúmulo desnecessário no repositório.

📚 Tecnologias Utilizadas
- Frontend: Ruby on Rails 8.0.0 (Views)
- ERB (Embedded Ruby)
- SCSS/SASS 1.49.9 para estilização
- JavaScript vanilla para interatividade
- Hotwire (Turbo 2.0.11 e Stimulus  3.0.1) para funcionalidades dinâmicas
- Bootstrap 5.1.3 para componentes de UI
- Backend: Ruby on Rails  8.0.0 (Arquitetura MVC)
- Banco de dados: PostgreSQL v15.7

💎 Boas Práticas Ruby/Rails
- Convenção sobre Configuração: Seguimos as convenções de nomenclatura do Rails
- DRY (Don't Repeat Yourself): Eliminação de código redundante através de:
  - Uso adequado de helpers
  - Partials para views reutilizáveis
  - Concerns para compartilhamento de código entre models e controllers
  - Fat Models, Skinny Controllers: Lógica de negócio concentrada nos models
  - SOLID Principles: Aplicação dos princípios de design de software
- TDD (Test-Driven Development): Desenvolvimento guiado por testes usando RSpec
- Code Review: Processo rigoroso de revisão de código
- RESTful Routes: Seguimos as convenções REST para rotas
- Gems: Uso criterioso de gems populares e bem mantidas
- Validações: Implementadas no nível do modelo
- Internacionalização (i18n): Suporte para múltiplos idiomas
- Service Objects: Para lógicas de negócio complexas
Active Record: Uso eficiente do ORM para consultas ao banco de dados
