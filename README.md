
# Movie App
![Application Screenshots](https://github.com/Dsribass/movie-app-swift/assets/68345989/5648e5ff-55ce-4edc-a3e9-c4679b124b88)

## Visão geral
MovieApp é um aplicativo que utiliza a API do [_**TMDb**_](https://www.themoviedb.org/) (The Movies Database) para listar os filmes mais bem avaliados no momento. O projeto foi criado como base de estudo para a linguagem Swift e o framework UIKit, utilizando boas práticas e tecnologias comuns do desenvolvimento iOS. Sendo assim, seu foco não era trazer funcionalidades muito complexas.

**Funcionalidades**:

1.  Listar Filmes
2.  Detalhar Filme
3.  Favoritar Filme

## Arquitetura

O projeto foi estruturado com base na Clean Architecture, separado em 4 diferentes camadas:

-   **Domain:** Regras de Negócio
-   **Data:** Responsável por controlar os dados da aplicação, como chamadas para API, cache, memória, etc.
-   **Presentation:** Gerenciamento de estado(MVVM) e controle das informações que serão apresentadas na View
-   **Main:** Aplicação iOS (UIKit, SwiftUI)

Como eram poucas funcionalidades, decidi estruturar a aplicação utilizando a abordagem de Layer First, ou seja, dividindo cada camada em um módulo diferente. A estratégia que adotei para a separação em módulos, foi utilizando os Targets do Xcode, e separando cada módulo como um framework independente.

## Implementação

**Main e Presentation**

Foi utilizado o framework UIKit para o desenvolvimento das interfaces gráficas, empregando tanto a abordagem de **Xibs** e de **ViewCode**. Para gerenciar o estado da aplicação, adotei o padrão arquitetural MVVM, utilizando a biblioteca RxSwift para estabelecer a vinculação entre as ViewModels e as ViewControllers.

O controle das rotas na aplicação foi implementado de acordo com o padrão Coordinator, juntamente com a biblioteca [Swinject](https://github.com/Swinject/Swinject) para o gerenciamento das dependências de cada _ViewController_.

**************Data**************

Para a gestão dos dados da aplicação, foi implementado Repositórios que gerenciam tanto da camada Remota quanto a camada de Cache.

Para as requisições HTTP, foi adotado a biblioteca Moya, que oferece uma abstração em relação ao conhecido [Alamofire](https://github.com/Alamofire/Alamofire).

Já para o armazenamento em cache, que consistiam em informações simples, foi utilizado o [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults).

**Domain**

Na camada de domínio, foram implementados todos os modelos e casos de uso relacionados às regras de negócio. Além disso, foram definidos protocolos (Repositórios) que devem ser implementados pela camada de dados.

> Em todos os módulos da aplicação foi utilizada a biblioteca [RxSwift](https://github.com/ReactiveX/RxSwift), e como padrão de retorno dos métodos foi utilizado _Observables_, _Single_ e _Completable_

## Tecnologias 
Ferramentas utilizadas:
1. [UIKit](https://developer.apple.com/documentation/uikit)
2. [RxSwift](https://github.com/ReactiveX/RxSwift)
3. [Swinject](https://github.com/Swinject/Swinject)
5. [Moya](https://github.com/Moya/Moya)
6. [Kingfisher](https://github.com/onevcat/Kingfisher)
7. [Cuckoo](https://github.com/Brightify/Cuckoo) (Teste Unitário)
8. [SwiftyUserDefaults](https://github.com/sunshinejr/SwiftyUserDefaults)
