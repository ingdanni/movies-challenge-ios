# Code challenge iOS - Movies app

## Project structure

* The `Common` folder contains shared code across all features.

```
.
├── Constants.swift -> global constants used in the app
├── Entities
│   ├── ContentAdapter.swift      -> a protocol for adapting movies/series data to UI Components
│   ├── ContentEntity.swift       -> a class representing the local DB model for realm
│   ├── ContentResponse.swift     -> a struct to handle responses data from the API (acts as a wrapper for movies/series)
│   ├── Movie.swift               -> a struct to handle movies data from the API
│   └── Serie.swift               -> a struct to handle series data from the API
├── Enums
│   ├── Category.swift            -> an enum to handle Categories (popular, top rated and upcoming)
│   └── ResourceType.swift        -> an enum to handle the type of resource for the API (movies or series)
├── Networking
│   ├── HTTPClient
│   │   ├── HTTPClient.swift      -> a class to handle http requests
│   │   └── Resource.swift        -> a protocol to handle resources for the http client
│   ├── Repositories
│   │   └── ContentRepository.swift -> a class containing all http requests related to movies and series
│   └── Resources
│       └── ContentResource.swift   -> an enum containing all http resources related to movies and series
└── Persistance
    └── Cache.swift               -> a class to handle local data for realm (save, get, search)
```

* The `Features` folder contains the different VIPER modules for the app (content list and detail).

```
.
├── Content                               -> this module is for the movies/series list
│   ├── ContentInteractor.swift           -> An interactor class to handle data
│   ├── ContentModel.swift                -> A model to be used for the interactor
│   ├── ContentPresenter.swift            -> A presenter class to handle business logic
│   ├── ContentRouter.swift               -> A router class to handle navigation between modules
│   ├── ContentView.swift                 -> A view class to handle UI
│   └── Views
│       └── ContentListItem.swift         -> A view class representing every item of the content list
├── ContentDetail                         -> this module is for the movies/series detail
│   ├── ContentDetailInteractor.swift
│   ├── ContentDetailPresenter.swift
│   ├── ContentDetailRouter.swift
│   └── ContentDetailView.swift
└── MainNavigation
    └── MainNavigation.swift              -> this is a tabbed navigation component (2 tabs for movies/series)

```

---

## Preguntas

1. **En qué consiste el principio de responsabilidad única? Cuál es su propósito?**

RESPUESTA: Consiste en que cada clase o componente de nuestro código tenga un solo objetivo o función. De esta forma cada componente evita tener dependencias a otras funcionalidades que están fuera de su alcance y el código se hace más comprensible y reutilizable para los desarrolladores.

2. **Qué características tiene, según su opinión, un “buen” código o código limpio**

RESPUESTA: Para tener un código limpio se necesita tener una arquitectura bien definida y consensuada entre el equipo de desarrollo, luego el código debe ser testeable y si no lo fuera se debe replantear la solución al problema. También es necesario seguir una guia de estilos para estandarizar el código y documentar siempre que fuera necesario los elementos de nuestro código (clases, funciones, parametros, etc..)
