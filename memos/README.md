# App memo

## Museo Zuccante

A Flutter application for taking memos and sharing them with other users.


## Documentation

### NoSQL
NoSQL databases have a simple and flexible structure. They are schema-free. Unlike relational databases, NoSQL databases are based on key-value pairs.

Some store types of NoSQL databases include column store, document store, key value store, graph store, object store, XML store, and other data store modes.

Usually, each value in the database has a key. Some NoSQL database stores also allow developers to store serialized objects into the database, not just simple string values.

Open-source NoSQL databases don’t require expensive licensing fees and can run on inexpensive hardware, rendering their deployment cost-effective.

Also, when working with NoSQL databases, whether they are open-source or proprietary, expansion is easier and cheaper than when working with relational databases. This is because it’s done by horizontally scaling and distributing the load on all nodes, rather than the type of vertical scaling that is usually done with relational database systems, which is replacing the main host with a more powerful one.

### Why Firestore?

- **Easy to integrate**: Firestore has outstanding libraries for mobile. Android, iOS, Flutter - every one of them works magically. For free you get services that complement each other with ergonomic and easy to bootstrap libraries. With Firestore libs you get all the goodies of Firebase suite - auth, serverless, storage, ML and others perfectly blended with the language specifics.
- **Offline capabilities**: this is a major trait of Firestore. The truly killer feature - it can work (to some extent) offline. Seamlessly. If you have accessed the data previously, you can do so again without the Internet connection. You can even save the data there without active connection. Firestore libraries handle all the syncing, data merging, notifications and other problems.
- *You don’t need backend… sometimes*: Firebase platform (that Firestore is part of) might be a viable “backend” option for small, user-focused apps. If you use it alongside other SaaS solutions (e-mails, voice calls, etc.), you might be even able to build a not-so-small app without creating any traditional backend system.




## File structure
```
lib
 ┣ core
 ┃ ┣ data
 ┃ ┃ ┣ date_time_type_converter.dart
 ┃ ┃ ┣ memos_database.dart # database floor
 ┃ ┃ ┗ memos_database.g.dart # database generato
 ┃ ┣ infrastructure
 ┃ ┃ ┣ error_handler.dart
 ┃ ┃ ┣ failures.dart
 ┃ ┃ ┗ resource.dart
 ┃ ┣ presentation
 ┃ ┃ ┣ m_app_bar.dart
 ┃ ┃ ┣ m_colors.dart
 ┃ ┃ ┣ m_custom_placeholder.dart
 ┃ ┃ ┣ m_google_button.dart
 ┃ ┃ ┗ no_glow.dart
 ┃ ┗ core_container.dart
 ┣ feature
 ┃ ┣ login
 ┃ ┃ ┣ model
 ┃ ┃ ┃ ┗ current_user.dart
 ┃ ┃ ┗ login_page.dart
 ┃ ┣ memos
 ┃ ┃ ┣ data
 ┃ ┃ ┃ ┣ datasource
 ┃ ┃ ┃ ┃ ┗ memos_local_datasource.dart
 ┃ ┃ ┃ ┣ model
 ┃ ┃ ┃ ┃ ┣ memo_local_model.dart
 ┃ ┃ ┃ ┃ ┗ memo_remote_model.dart
 ┃ ┃ ┃ ┗ repository
 ┃ ┃ ┃ ┃ ┗ memos_repository_impl.dart
 ┃ ┃ ┣ domain
 ┃ ┃ ┃ ┣ model
 ┃ ┃ ┃ ┃ ┗ memo_domain_model.dart
 ┃ ┃ ┃ ┗ repository
 ┃ ┃ ┃ ┃ ┗ memos_repository.dart
 ┃ ┃ ┣ presentation
 ┃ ┃ ┃ ┣ bloc
 ┃ ┃ ┃ ┃ ┣ memos
 ┃ ┃ ┃ ┃ ┃ ┣ memos_watcher_bloc.dart
 ┃ ┃ ┃ ┃ ┃ ┣ memos_watcher_event.dart
 ┃ ┃ ┃ ┃ ┃ ┗ memos_watcher_state.dart
 ┃ ┃ ┃ ┃ ┗ share
 ┃ ┃ ┃ ┃ ┃ ┣ share_bloc.dart
 ┃ ┃ ┃ ┃ ┃ ┣ share_event.dart
 ┃ ┃ ┃ ┃ ┃ ┗ share_state.dart
 ┃ ┃ ┃ ┣ custom
 ┃ ┃ ┃ ┃ ┗ email_alert.dart
 ┃ ┃ ┃ ┣ add_memo_page.dart
 ┃ ┃ ┃ ┣ memo_page.dart
 ┃ ┃ ┃ ┗ memos_page.dart
 ┃ ┃ ┗ memos_container.dart
 ┃ ┣ screens
 ┃ ┃ ┗ splash_screen.dart
 ┃ ┗ settings
 ┃ ┃ ┗ settings_page.dart
 ┗ main.dart
 ```
## Sintesti clean architecture

<img src="https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?resize=556%2C707&ssl=1">


- Data: livello giù basso, si occupa di ricavare i dati dalle api o dal database
	- **Datasource**: di solito presente una classe chiamata `LocalDatasource` e una `RemoteDatasource`, si occupano rispettivamente di prelevare i dati dal database o dalle API
    - **Model**, sono presenti due modelli, il livello del database chiamato `LocalModel` che non è altro che la entità salvabile e un modello chiamato `RemoteModel` che è la conversione del json che ci viene inviato dalle API
    - **Repository**: contiene l'impelementazione della repository dichiarata a livello dominio, si occupa di centralizzare l'ottenimento/aggiornamento dei dati in una unica posizione unendo la datasource remota e quella locale

- **Domain**: livello di mezzo, è quello che sta tra il livello data della nostra app e quello presentazione, a volte piò sembrare inutile ma aiuta molto nell'organizzazione, è molto semplice ed è composto solitamente da 2 cartelle:
    - **Model**: è un modello di riferimento, praticamente tutti i dati che escono dalla repository non sono ne di livello locale ne di livello remoto ma di questo tipo.
    - **Repository**: continee le repository ma sono di tipo astratto, quindi non contengono l'implementazione dei metodi

- **Presentation**: qui ci starà tutta la UI con il BloC che gestisce lo stato
## Libraries
- 🔝 Flutter + Dart
- 📡 Dio for API requests
- 💡 BLoC for state management
- 📚 Foor for data persistency + Cloud Firestore for remote storage
- 💉 Get It for dependency injection
- 🔗 Dartz for functional programming
- 🌊 RxDart for the data flow

## Handling errors

Error is handling is done with functional programming, every function and streams gives a Either or a Resource type, so in the UI we can give an error message

## What is the Clean Architecture by Uncle Bob?


![The clean architecture](https://miro.medium.com/max/1400/1*wOmAHDN_zKZJns9YDjtrMw.jpeg)


1. Module to present the data. This is called a presentation Layer.
2. Module to get data/feeds from. Can be local(like DB) or Remote(like REST calls). This is called Data Layer.
3. Business logic which shows the feeds/to handle like and dislike. This is called Domain Layer.


## Design patterns
- usecases
- repository
- dependency injection
- observer


## Data

The Data layer consists of repository and data models. Repository is where the application gather all data related to the use case, either from local sources (Local DB, cookies) or remote sources (remote API). Data from the sources, usually in json format, is parsed to Dart object called models. It’s need to be done to make sure the application knows what data and variable it’s expecting.

## Domain

Domain is the inner layer which shouldn’t be susceptible to the whims of changing data sources or porting our app to Angular Dart. It will contain only the core business logic (use cases) and business objects (entities).
Repository classes act as the Data Layer and Domain Layer, each function on the repository class acts as the domain layer that specifies the use cases of the feature.

Domain Layer can have:
1. Use cases
2. Entities
3. DataLayer interfaces



## Presentation
Presentation is where the UI goes. You obviously need widgets to display something on the screen. These widgets is controlled by the state using various state management design pattern used in Flutter. In this project, I use BLoC as the state management.

## Dependencies/Data flow

UI calls from the Presentation layer.
Presentation layer executes the use case.
Use case(Domain layer) will ask the Data layer to send back the result.
Data layer will run and send back the result to the Use case.
Information is flown back to UI, to show the result.