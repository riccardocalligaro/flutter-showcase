# Museo Zuccante

Il progetto è volto al fine di creare un'applicazione che riesca a far interagire gli utenti con le vecchie apparecchiature attraverso la scansione di un apposito QR code. Lo scopo del progetto è utilizzare l'App per illustrare ai giovani ragazzi come si lavora e come si lavorava all'ITIS C. Zuccante. 
L'applicazione fornisce anche una dettagliata descrizione per i vari macchinari che venivano utilizzati anni prima. Coniuga a tutti gli effetti il nuovo con il vecchio e dimostra come sia possibile valorizzare strumenti che non trovano più un utilizzo.


## Documentation

## File structure
```
lib
 ┣ commands
 ┃ ┗ commands.dart
 ┣ core
 ┃ ┣ data
 ┃ ┃ ┣ generics
 ┃ ┃ ┃ ┣ resource.dart
 ┃ ┃ ┃ ┗ update.dart
 ┃ ┃ ┣ local
 ┃ ┃ ┃ ┣ mz_database.dart
 ┃ ┃ ┃ ┗ mz_database.g.dart
 ┃ ┃ ┗ remote
 ┃ ┃ ┃ ┣ mz_api_config.dart
 ┃ ┃ ┃ ┗ mz_dio_client.dart
 ┃ ┣ domain
 ┃ ┃ ┗ domain
 ┃ ┃ ┃ ┗ usecase.dart
 ┃ ┣ infrastructure
 ┃ ┃ ┣ error
 ┃ ┃ ┃ ┣ types
 ┃ ┃ ┃ ┃ ┣ failures.dart
 ┃ ┃ ┃ ┃ ┗ successes.dart
 ┃ ┃ ┃ ┗ handler.dart
 ┃ ┃ ┣ localization
 ┃ ┃ ┃ ┣ bloc
 ┃ ┃ ┃ ┃ ┣ language_bloc.dart
 ┃ ┃ ┃ ┃ ┣ language_event.dart
 ┃ ┃ ┃ ┃ ┗ language_state.dart
 ┃ ┃ ┃ ┣ app_localizations.dart
 ┃ ┃ ┃ ┣ languages.dart
 ┃ ┃ ┃ ┗ shared_prefs_service.dart
 ┃ ┃ ┣ log
 ┃ ┃ ┃ ┣ bloc_logger.dart
 ┃ ┃ ┃ ┗ logger.dart
 ┃ ┃ ┣ notification
 ┃ ┃ ┣ report
 ┃ ┃ ┃ ┗ report_manager.dart
 ┃ ┃ ┣ mz_preferences.dart
 ┃ ┃ ┗ network_info.dart
 ┃ ┣ presentation
 ┃ ┃ ┣ customization
 ┃ ┃ ┃ ┣ custom_shimmer.dart
 ┃ ┃ ┃ ┣ mz_colors.dart
 ┃ ┃ ┃ ┣ mz_image.dart
 ┃ ┃ ┃ ┗ no_glow_behavior.dart
 ┃ ┃ ┣ states
 ┃ ┃ ┃ ┣ mz_empty_view.dart
 ┃ ┃ ┃ ┣ mz_failure_view.dart
 ┃ ┃ ┃ ┗ mz_loading_view.dart
 ┃ ┃ ┣ device_info.dart
 ┃ ┃ ┗ styles.dart
 ┃ ┣ utils
 ┃ ┃ ┗ mz_utils.dart
 ┃ ┗ core_container.dart
 ┣ feature
 ┃ ┣ home
 ┃ ┃ ┣ qrcode
 ┃ ┃ ┃ ┣ data
 ┃ ┃ ┃ ┗ presentation
 ┃ ┃ ┃ ┃ ┣ dialog
 ┃ ┃ ┃ ┃ ┃ ┗ animated_qr_dialog.dart
 ┃ ┃ ┃ ┃ ┗ qr_code_view.dart
 ┃ ┃ ┣ states
 ┃ ┃ ┃ ┣ widget
 ┃ ┃ ┃ ┃ ┗ item_vertical_card.dart
 ┃ ┃ ┃ ┣ items_loaded.dart
 ┃ ┃ ┃ ┗ items_loading.dart
 ┃ ┃ ┗ home_page.dart
 ┃ ┣ items
 ┃ ┃ ┣ data
 ┃ ┃ ┃ ┣ datasources
 ┃ ┃ ┃ ┃ ┣ items_local_datasource.dart
 ┃ ┃ ┃ ┃ ┣ items_local_datasource.g.dart
 ┃ ┃ ┃ ┃ ┗ items_remote_datasource.dart
 ┃ ┃ ┃ ┣ models
 ┃ ┃ ┃ ┃ ┣ item_local_model.dart
 ┃ ┃ ┃ ┃ ┗ item_remote_model.dart
 ┃ ┃ ┃ ┗ repository
 ┃ ┃ ┃ ┃ ┗ items_repository_impl.dart
 ┃ ┃ ┣ domain
 ┃ ┃ ┃ ┣ model
 ┃ ┃ ┃ ┃ ┗ item_domain_model.dart
 ┃ ┃ ┃ ┣ repositories
 ┃ ┃ ┃ ┃ ┗ items_repository.dart
 ┃ ┃ ┃ ┗ usecases
 ┃ ┃ ┃ ┃ ┣ update_items_usecase.dart
 ┃ ┃ ┃ ┃ ┗ watch_items_usecase.dart
 ┃ ┃ ┣ item
 ┃ ┃ ┃ ┣ data
 ┃ ┃ ┃ ┃ ┣ datasources
 ┃ ┃ ┃ ┃ ┣ models
 ┃ ┃ ┃ ┃ ┗ repository
 ┃ ┃ ┃ ┣ domain
 ┃ ┃ ┃ ┃ ┣ repositories
 ┃ ┃ ┃ ┃ ┗ usecases
 ┃ ┃ ┃ ┃ ┃ ┗ get_item_usecase.dart
 ┃ ┃ ┃ ┣ presentation
 ┃ ┃ ┃ ┃ ┣ bloc
 ┃ ┃ ┃ ┃ ┃ ┣ item_bloc.dart
 ┃ ┃ ┃ ┃ ┃ ┣ item_event.dart
 ┃ ┃ ┃ ┃ ┃ ┗ item_state.dart
 ┃ ┃ ┃ ┃ ┣ company_page.dart
 ┃ ┃ ┃ ┃ ┣ item_loader_page.dart
 ┃ ┃ ┃ ┃ ┗ item_page.dart
 ┃ ┃ ┃ ┗ item_container.dart
 ┃ ┃ ┣ presentation
 ┃ ┃ ┃ ┣ search
 ┃ ┃ ┃ ┃ ┣ search_bloc.dart
 ┃ ┃ ┃ ┃ ┣ search_event.dart
 ┃ ┃ ┃ ┃ ┗ search_state.dart
 ┃ ┃ ┃ ┣ states
 ┃ ┃ ┃ ┃ ┣ widget
 ┃ ┃ ┃ ┃ ┃ ┗ item_vertical_card.dart
 ┃ ┃ ┃ ┃ ┣ items_loaded.dart
 ┃ ┃ ┃ ┃ ┗ items_loading.dart
 ┃ ┃ ┃ ┣ updater
 ┃ ┃ ┃ ┃ ┣ items_updater_bloc.dart
 ┃ ┃ ┃ ┃ ┣ items_updater_event.dart
 ┃ ┃ ┃ ┃ ┗ items_updater_state.dart
 ┃ ┃ ┃ ┣ watcher
 ┃ ┃ ┃ ┃ ┣ items_watcher_bloc.dart
 ┃ ┃ ┃ ┃ ┣ items_watcher_event.dart
 ┃ ┃ ┃ ┃ ┗ items_watcher_state.dart
 ┃ ┃ ┃ ┣ items_list_page.dart
 ┃ ┃ ┃ ┗ items_page.dart
 ┃ ┃ ┗ items_container.dart
 ┃ ┣ list
 ┃ ┃ ┗ list_page.dart
 ┃ ┣ map
 ┃ ┃ ┣ data
 ┃ ┃ ┣ domain
 ┃ ┃ ┗ presentation
 ┃ ┃ ┃ ┣ model
 ┃ ┃ ┃ ┃ ┗ map_object.dart
 ┃ ┃ ┃ ┣ widget
 ┃ ┃ ┃ ┃ ┣ image_viewport.dart
 ┃ ┃ ┃ ┃ ┣ map_painter.dart
 ┃ ┃ ┃ ┃ ┗ zoom_container.dart
 ┃ ┃ ┃ ┗ map_page.dart
 ┃ ┣ rooms
 ┃ ┃ ┣ data
 ┃ ┃ ┃ ┣ datasources
 ┃ ┃ ┃ ┃ ┣ rooms_local_datasource.dart
 ┃ ┃ ┃ ┃ ┣ rooms_local_datasource.g.dart
 ┃ ┃ ┃ ┃ ┗ rooms_remote_datasource.dart
 ┃ ┃ ┃ ┣ models
 ┃ ┃ ┃ ┃ ┣ room_local_model.dart
 ┃ ┃ ┃ ┃ ┗ room_remote_model.dart
 ┃ ┃ ┃ ┗ repository
 ┃ ┃ ┃ ┃ ┗ rooms_repository_impl.dart
 ┃ ┃ ┣ domain
 ┃ ┃ ┃ ┣ model
 ┃ ┃ ┃ ┃ ┗ room_domain_model.dart
 ┃ ┃ ┃ ┣ repository
 ┃ ┃ ┃ ┃ ┗ rooms_repository.dart
 ┃ ┃ ┃ ┗ usecase
 ┃ ┃ ┃ ┃ ┣ get_items_for_room_usecase.dart
 ┃ ┃ ┃ ┃ ┣ update_rooms_usecase.dart
 ┃ ┃ ┃ ┃ ┗ watch_rooms_usecase.dart
 ┃ ┃ ┣ presentation
 ┃ ┃ ┃ ┣ single
 ┃ ┃ ┃ ┃ ┣ bloc
 ┃ ┃ ┃ ┃ ┃ ┣ room_items_bloc.dart
 ┃ ┃ ┃ ┃ ┃ ┣ room_items_event.dart
 ┃ ┃ ┃ ┃ ┃ ┗ room_items_state.dart
 ┃ ┃ ┃ ┃ ┗ room_page.dart
 ┃ ┃ ┃ ┣ state
 ┃ ┃ ┃ ┃ ┗ rooms_loaded.dart
 ┃ ┃ ┃ ┣ updater
 ┃ ┃ ┃ ┃ ┣ rooms_updater_bloc.dart
 ┃ ┃ ┃ ┃ ┣ rooms_updater_event.dart
 ┃ ┃ ┃ ┃ ┗ rooms_updater_state.dart
 ┃ ┃ ┃ ┣ watcher
 ┃ ┃ ┃ ┃ ┣ rooms_watcher_bloc.dart
 ┃ ┃ ┃ ┃ ┣ rooms_watcher_event.dart
 ┃ ┃ ┃ ┃ ┗ rooms_watcher_state.dart
 ┃ ┃ ┃ ┗ rooms_list.dart
 ┃ ┃ ┗ rooms_container.dart
 ┃ ┣ settings
 ┃ ┃ ┣ views
 ┃ ┃ ┃ ┗ credits_view.dart
 ┃ ┃ ┗ settings_page.dart
 ┃ ┗ mz_navigator.dart
 ┣ generated_plugin_registrant.dart
 ┗ main.dart
 ```

## Schemi

### Updater
<img src="https://i.imgur.com/AGYPYeX.png">

### Watcher
<img src="https://i.imgur.com/sh1E8vw.png">


### BLOC Pattern

<img src="https://i.imgur.com/gHSks24.png">

<img src="https://miro.medium.com/max/1750/1*MqYPYKdNBiID0mZ-zyE-mA.png">


### Clean architecture
<img src="https://i0.wp.com/resocoder.com/wp-content/uploads/2019/08/Clean-Architecture-Flutter-Diagram.png?resize=556%2C707&ssl=1">


## Sintesti clean architecture

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
- 📚 Moor for data persistency
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