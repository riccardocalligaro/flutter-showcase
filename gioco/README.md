# Colors game

## Assignment

Create a game in which a square changes color in a set range of 5 colors (at will), with each color change that takes place in a random time between 2 and 4 seconds. 
The player must click on one of the five appropriately positioned buttons of the same color.

## One thing before...

This architecture and the file organizazion are totally overkill for a simple project, in 'real-life' you wouldn't wanna do something like this. But in this case I wanted to show the clean architecture that I've been using for a few months, it helped me a lot with big projects, maintenance can be a pain but if the code is organized and modular it's a lot more easier.

I think that it is something that everyone should learn, with this architecutre a lot of principles come and they can make your developer-life a lot better.

> “It is not enough for code to work.” -  Robert C. Martin, Uncle Bob

Having said that, I will proceed to make the best explanation I can.


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

I tried to follow [Test Driven Development - TDD](https://it.wikipedia.org/wiki/Test_driven_development) and test every function.

With `flutter test` you can run all the tests.




### Functional programming

We know that Use Cases will obtain Question entities from Repositories and they will pass these entities to the presentation layer. So, the type returned by a UseCase should be a Question.

What about errors? Is it the best choice to let exceptions freely propagate, having to remember to catch them somewhere else in the code? No. Instead, we want to catch exceptions as early as possible (in the Repository) and then return Failure objects from the methods in question.

The dartz package, which I've added as a dependency, brings functional programming (FP) to Dart. We are interested in the Either<L, R> type.

This type can be used to represent any two types at the same time and it's just perfect for error handling, where L is the Failure and R is the Question. This way, the Failures don't have their own special "error flow" like exceptions do. They will get handled as any other data without using try/catch. 

### Libraries
- Audioplayers: play the custom sfx
- Dartz: Functional programming to dart
- Get it: Simple service locator
- Google Fonts: Fantastic google package to bring google fonts to flutter
- Shared preferences: Save the user high score

## Flutter

### Custom painter
With CustomPainter, Flutter gives you access to low-level graphics painting. I used this class to implement my custom game graphics (the divided parts circle).

To implement a custom painter, you either subclass or implement this interface. CustomPaint subclasses must implement the paint and shouldRepaint methods, and may optionally also implement the hitTest and shouldRebuildSemantics methods, and the semanticsBuilder getter.

The paint method is called whenever the custom object needs to be repainted.

The shouldRepaint method is called when a new instance of the class is provided, to check if the new instance actually represents different information.

The main difficulty here was to implement the hit test method since you can't draw stroke circles in a path. 

I solved this problem by drawing 5 different arcs per semi-circle. 

In the file `answer_circle_section_painter.dart` there are all the explanations.

### Animations

I used the amazing animations library that flutter provides to animate the initial circle. 

With the `AnimationController` you set all the animation constraints like the `Duration` and with the `AnimationBuilder` and the `Trasform.rotate()` widgets you build the view..



## More about clean architecture

[Clean architecture](https://pusher.com/tutorials/clean-architecture-introduction)

[A quick introduction to clean architecture ](https://www.freecodecamp.org/news/a-quick-introduction-to-clean-architecture-990c014448d2/)

[The Principles of Clean Architecture by Uncle Bob Martin](https://youtu.be/o_TH-Y78tt4?t=642)