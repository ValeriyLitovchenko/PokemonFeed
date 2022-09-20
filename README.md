# Pokemon

## Version

### 1.0

## Build and Runtime Requirements

+ Xcode 13.0 or later
+ iOS 13.0 or later
+ MacOS macOS 11.3 or later


## Code Style

For code style used [`SwiftLint`](https://github.com/realm/SwiftLint). <br>
Definition from the oficial documentation: <br>

> A tool to enforce Swift style and conventions, loosely based on the now archived GitHub Swift Style Guide.

<br>
Install `SwiftLint` via Homebrew

```
brew install swiftlint
```

## About Pokemon

Application allows user to search a list of Pokemon loaded using the https://pokeapi.co API and view their statistics.


## App's infrastructure

The project follows [Model-View-View-Model](/PokemonFeed/Presentation/PokemonFeedScene/PokemonFeed/ViewModel/PokemonFeedViewModelImpl.swift) (MVVM), [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) and [Dependency Injection](/PokemonFeed/Application/DIContainer/PokemonFeedSceneDIContainer.swift) (DI) design patterns + Application Controller Pattern represented by [FlowCoordinator](/PokemonFeed/Presentation/PokemonFeedScene/Flows/PokemonFeedSceneFlowCoordinator.swift).<br>
Client-server interaction in application implemented with using of Pokemon REST Api https://pokeapi.co and [Network layer](PokemonFeed/Infrastructure/Network/) via [RestApiNetworkService](PokemonFeed/Infrastructure/Network/RestApiNetworkService.swift).<br>
Pokemon list stored with [InMemoryPokemonFeedStorage](/PokemonFeed/Data/PersistentStorages/PokemonFeedStorage/InMemoryPokemonFeedStorage.swift). It allows to perform search by a part of pokemon's name without performing many API calls. API allows only to search by full name or id.<br>
Project contains [Core](/PokemonFeed/Core/) with base classes for building scene screens. [BaseTableViewSceneClasses](/PokemonFeed/Core/BaseTableViewSceneClasses/) contains resusable units which allows to create list displaying screen easiely.
- `View` - User Interface unit for displaying data;
- `ViewController` - Unit that operates by view and holds `ViewModel`;
- `ViewModel` - Displaying data container/provider for `View`;
- `Models` - Contains all required info to setup UI for one table view section.

## How to use app
After opening the app and passing splash screen you will see pokemons list screen. By pressing search icon on top bar you will activate search field. To search for a list of Pokemon simply start to write it's name. To view Pokemon statistics tap on one of the Pokemons, details screen will be opened. To view concrete pokemon variety(if provided) from details screen simply tap on it.