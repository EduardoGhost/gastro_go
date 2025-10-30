**Gastro Go**

Gastro Go é um aplicativo Flutter que lista restaurantes e seus pratos,
permitindo favoritar itens e salvar localmente usando banco de dados "Hive".

Decisões de Arquitetura

O Gastro Go segue Clean Architecture com camadas data, domain e presentation, facilitando manutenção,
testes e futuras integrações. O padrão Repository isola a fonte de dados, mesmo sendo JSON local.

O estado é gerenciado com Bloc.


Instruções de Build / Run
Pré-requisitos
    Flutter >= 3.x
    Dart >= 3.x

Android Studio ou VS Code com suporte a Flutter
JDK 17 (para compilação Android)

**Passos**

Clone o repositório:
git clone <https://github.com/EduardoGhost/gastro_go>

Acesse o diretório do projeto:
cd gastro_go

Instale as dependências:
flutter pub get

Gere arquivos de build (Hive / json_serializable):
flutter pub run build_runner build --delete-conflicting-outputs

Execute o app:
flutter run

-------------------------------------------------------------------------------------------

**Lista do que foi implementado**
1. Lista de restaurantes
    Exibe nome, categoria, rating (0–5) e distância.
    Busca por texto (nome) e filtro por categoria.
    Ordenação por rating ou distância.

2. Tela de detalhes
Mostra informações do restaurante + lista de pratos (nome, preço, se é vegano).
Botão de “Favoritar” para restaurante e prato.

3. Favoritos
Tela para ver itens favoritados (restaurantes e pratos).

Persistência local via Hive.
4. Fonte de dados
Dados provenientes de JSON local (assets):

5. Arquitetura & Estado
Camadas separadas (data/, domain/, presentation/).
Bloc para gerenciamento de estado.
Repository pattern para isolar a fonte de dados.

**Funcionalidades Faltantes**

6. Tratamento de erros & loading
Estados explícitos: carregando, sucesso, vazio, erro (com retry).

7. UI/UX

Tornar a UI totalmente responsiva para todos os tamanhos de tela.
Implementar Dark/Light mode completo.
Melhorar acessibilidade (labels, contraste, tamanho de toque).

8. Qualidade

Lint configurado (flutter_lints / very_good_analysis).
Testes: faltam alguns testes unitários e de widget.
CI/CD (GitHub Actions) ainda não configurado.

9. Funcionalidades extras

Paginação / “infinite scroll”
Animações sutis (ex.: herói na imagem do card)
Internacionalização (pt-BR e en)
Cache de imagens (cached_network_image)
Filtro “vegano apenas”