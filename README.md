# 🎵 Plataforma de Visibilidade para Novos Artistas

# 📖 Visão Geral
A Plataforma de Visibilidade para Novos Artistas é um sistema dedicado a músicos independentes que desejam compartilhar suas criações e alcançar o público que merecem. Criada para enfrentar os desafios do mainstream, onde os algoritmos frequentemente priorizam grandes nomes da indústria, esta plataforma oferece um espaço exclusivo para a promoção de novos talentos musicais.

# 🚀 Funcionalidades Principais
- Para Músicos
  - Cadastro de Artista: Solicitação de cadastro como músico para obter acesso às ferramentas.
  - CRUD de Álbum e Músicas
- Para Ouvintes
  - Navegação e Busca: Pesquisar músicas filtrando por artista, faixa ou álbum.
  - Exploração de Novos Talentos: Descobrir novos artistas independentes.
- Para Administradores
  - Gestão de Conteúdo: Aprovar, editar ou excluir álbuns e músicas da plataforma.
  - Moderação: Garantir que o conteúdo siga as políticas da plataforma.

# 🔒 Segurança
- Criptografia de Dados:
  - Login e senha armazenados de forma criptografada no banco de dados.
  - Toda comunicação entre o frontend e o backend é criptografada para garantir a segurança dos dados dos usuários.

# 👥 Tipos de Usuários
- Músicos: Usuários que criam álbuns e músicas.
- Ouvintes: Usuários que exploram e consomem as músicas disponíveis na plataforma.
- Administradores: Usuários com permissão para gerenciar o conteúdo da plataforma.

# 📚 Tecnologias Utilizadas
- **Frontend:** Ruby on Rails (Views)
  - ERB (Embedded Ruby)
  - SCSS/SASS para estilização
  - JavaScript vanilla para interatividade
  - Hotwire (Turbo e Stimulus) para funcionalidades dinâmicas
  - Bootstrap para componentes de UI
- **Backend:** Ruby on Rails (Arquitetura MVC)
- **Banco de dados:** PostgreSQL v15.7

# 💎 Boas Práticas Ruby/Rails
- **Convenção sobre Configuração**: Seguimos as convenções de nomenclatura do Rails
- **DRY (Don't Repeat Yourself)**: Eliminação de código redundante através de:
  - Uso adequado de helpers
  - Partials para views reutilizáveis
  - Concerns para compartilhamento de código entre models e controllers
- **Fat Models, Skinny Controllers**: Lógica de negócio concentrada nos models
- **SOLID Principles**: Aplicação dos princípios de design de software
- **TDD (Test-Driven Development)**: Desenvolvimento guiado por testes usando RSpec
- **Code Review**: Processo rigoroso de revisão de código
- **RESTful Routes**: Seguimos as convenções REST para rotas
- **Gems**: Uso criterioso de gems populares e bem mantidas
- **Validações**: Implementadas no nível do modelo
- **Internacionalização (i18n)**: Suporte para múltiplos idiomas
- **Service Objects**: Para lógicas de negócio complexas
- **Active Record**: Uso eficiente do ORM para consultas ao banco de dados
