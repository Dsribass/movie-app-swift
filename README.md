

# Movie App

![Application Screenshots](https://github.com/Dsribass/movie-app-swift/assets/68345989/5648e5ff-55ce-4edc-a3e9-c4679b124b88)

## Visão Geral
MovieApp é um aplicativo que utiliza a API do TMDb (The Movies Database) para listar os filmes mais bem avaliados no momento. O projeto foi criado como base de estudo para a linguagem Swift e o framework UIKit, utilizando boas práticas e tecnologias comuns do desenvolvimento iOS. Sendo assim, seu foco não era trazer funcionalidades muito complexas.

**Funcionalidades**:

1.  Listar Filmes
2.  Detalhar Filme
3.  Favoritar Filme  
  

## Arquitetura

O projeto foi estruturado com base na Clean Architecture, separado em 4 diferentes camadas:

 - **Domain:** Regras de Negócio
 - **Data:** Responsável por controlar os dados da aplicação, como chamadas para API, cache, memória, etc.
 - **Presentation:** Gerenciamento de estado(MVVM) e controle das informações que serão apresentadas na View
 - **Main:** Aplicação iOS (UIKit, SwiftUI)

## Tecnologias 
Ferramentas utilizadas:
1. [UIKit](https://developer.apple.com/documentation/uikit)
2. [RxSwift](https://github.com/ReactiveX/RxSwift)
3. [Swinject](https://github.com/Swinject/Swinject)
5. [Moya](https://github.com/Moya/Moya)
6. [Kingfisher](https://github.com/onevcat/Kingfisher)
7. [Cuckoo](https://github.com/Brightify/Cuckoo) (Teste Unitário)
8. [SwiftyUserDefaults](https://github.com/sunshinejr/SwiftyUserDefaults)
