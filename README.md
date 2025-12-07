📘 Nubank Take-Home — URL Shortener

Um projeto iOS moderno construído com foco em qualidade, arquitetura limpa, modularização, testabilidade e experiência de desenvolvimento profissional.

Este app implementa um encurtador de URLs consumindo o backend fornecido no desafio. Ele foi estruturado de forma a refletir como um aplicativo real seria organizado dentro de uma squad madura e organizada, seguindo as melhores práticas de desenvolvimento.

🏗️ Arquitetura & Decisões Técnicas

O app segue uma arquitetura baseada em MVVM, onde a ViewModel é a grande responsável pela tratativa de regras, deixando as Views com a função de apresentar e interagir com o usuário, sendo assim uma arquitetura, de fácil manutenção, aprendizado, testabilidade, escalabilidade não deixando de ser simples e profissional, inspirada em práticas usadas em apps bancários de grande escala:
🎯 Camadas

Core → modelos compartilhados
Networking → abstração de camada HTTP
App → contém Engine, Adapter, Repository, ViewModels, Views, Router (Prontas para evoluir) e Coordinator (Prontas para evoluir)

🧠 Pilares

ViewModel: lógica de apresentação 100% testável
Engine: regras de negócio (normalização de URL, validações, tratamento de erros)
Repository: persistência in-memory, mockável
Adapter: conversão Core → UIModels
Coordinator + Router: navegação desacoplada
Views desacopladas: Header, Input, ListView, ListCell
Tudo isso garante que cada camada tenha uma responsabilidade clara, reduzindo acoplamento e deixando o código fácil de evoluir.

📦 Modularização

O projeto utiliza módulos independentes:
Core/
Networking/
NubankTakeHome (App)/


Essa separação facilita:

Testabilidade
Reutilização
Substituição por mocks
Evolução futura

🧪 Testes

Os testes foram escritos para serem rápidos, determinístico e independentes da rede.

📌 Abrangência

Unit Tests
ViewModel
Engine
Repository
Adapter
LinkService
Coordinator / Router
Snapshot Tests
ShortenerHeaderView
ShortenerInputView
ShortenerListCell
ShortenerViewController (tela completa)

🔍 Estratégia

Sem network real
Mocks leves e reutilizáveis
Testes garantem comportamentos previsíveis
Testes de snapshot com configuração centralizada

🎨 UI / Design System

O projeto contém um mini design-system inspirado na estética do Nubank:

Colors
Typography
Spacing tokens
Radii tokens
Shadows
Componentes reutilizáveis
PrimaryButton
GhostButton
SecondaryButton
CardView

O objetivo é demonstrar maturidade e consistência visual mesmo em um app pequeno.

🚀 Como rodar o projeto
Pré-requisitos

Xcode 15+
iOS 16+
Swift Package Manager (SPM)

Execução:

Clone o repositório
Abra o arquivo .xcodeproj
Compile (Cmd + R)
Testes:
Cmd + U
Snapshots serão gerados automaticamente dentro de:
__Snapshots__/

🔥 Pontos fortes do projeto

Arquitetura limpa e modular
Navegação desacoplada via Coordinator/Router
Camada de Engine realista (como usada em bancos e fintechs)
Testes rápidos, isolados, sem dependência externa
Views altamente reutilizáveis
Código documentado e sem mágicas desnecessárias
Fácil de manter e expandir


❤️ Conclusão

O objetivo foi construir um projeto que não apenas resolve o desafio, mas demonstra maturidade de engenharia, organização, cuidado com testabilidade, capacidade de criar um app sustentável e perfil evolutivo.
