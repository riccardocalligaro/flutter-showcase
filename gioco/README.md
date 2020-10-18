# Colors game

Si realizzi un gioco in cui un quadrato cambia colore in un range prefissato di 5 colori (a piacere), ad ogni cambiamento di colore che avviene in un tempo random fra i 2 ed i 4 secondi 
il giocatore deve fare click su uno dei cinque bottoni, posizionati opportunamente, dell'analogo colore.

## Table of contents

- [Overview of the project](#overview-of-the-project)
    - [Project structure](#project-structure)
    - [Clean architecture](#clean-architecture)
    - [Design patterns](#design-patterns)
    - [Testing](#testing)
    - [Functional programming](#functional-programming)
    - [Libraries](#libraries)

- [Flutter](#flutter)
    - [Custom painter](#custom-painter)
    - [Animations](#animations)

- [Design](#design)


## Overview of the project

### Project structure
![The project structure](https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?ssl=1)

In my case there were no remote or local data sources, the call flows ends at the repository, the layer in which the questions are generated.

### Clean architecture

![The clean architecture](https://miro.medium.com/max/1400/1*wOmAHDN_zKZJns9YDjtrMw.jpeg)

1. Module to present the data. This is called a presentation Layer.
2. Module to get data/feeds from. Can be local(like DB) or Remote(like REST calls). This is called Data Layer.
3. Business logic which shows the feeds/to handle like and dislike. This is called Domain Layer.

#### Data

The Data layer consists of repository and data models. Repository is where the application gather all data related to the use case, either from local sources (Local DB, cookies) or remote sources (remote API). Data from the sources, usually in json format, is parsed to Dart object called models. It’s need to be done to make sure the application knows what data and variable it’s expecting.

#### Domain

Domain is the inner layer which shouldn’t be susceptible to the whims of changing data sources or porting our app to Angular Dart. It will contain only the core business logic (use cases) and business objects (entities).
Repository classes act as the Data Layer and Domain Layer, each function on the repository class acts as the domain layer that specifies the use cases of the feature.

Domain Layer can have:
1. Use cases
2. Entities
3. DataLayer interfaces

#### Presentation
Presentation is where the UI goes. You obviously need widgets to display something on the screen. These widgets is controlled by the state using various state management design pattern used in Flutter. In this project, I use BLoC as the state management.

#### Dependencies/Data flow

UI calls from the Presentation layer.
Presentation layer executes the use case.
Use case(Domain layer) will ask the Data layer to send back the result.
Data layer will run and send back the result to the Use case.
Information is flown back to UI, to show the result.


### Design patterns

- Service locator
- Singleton
- Observer
- Repository
- Use case

### Testing


### Functional programming

We know that Use Cases will obtain Question entities from Repositories and they will pass these entities to the presentation layer. So, the type returned by a UseCase should be a Question.

What about errors? Is it the best choice to let exceptions freely propagate, having to remember to catch them somewhere else in the code? No. Instead, we want to catch exceptions as early as possible (in the Repository) and then return Failure objects from the methods in question.

The dartz package, which I've added as a dependency, brings functional programming (FP) to Dart. We are interested in the Either<L, R> type.

This type can be used to represent any two types at the same time and it's just perfect for error handling, where L is the Failure and R is the Question. This way, the Failures don't have their own special "error flow" like exceptions do. They will get handled as any other data without using try/catch. 

### Libraries

## Flutter

### Custom painter

### Animations

## Design

