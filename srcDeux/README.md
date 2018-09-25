# Infrastructure

Elm directories:

- Applications/Brain
- Applications/UI
- Library

`UI` is the Elm application that'll be executed on the main thread (ie. the UI thread) and `Brain` is the Elm application that'll live inside a web worker. `UI` renders the user interface and `Brain` does all the rest. The code shared between these two applications lives in `Library`.



## State

The data will be located in the `Brain` and each time it changes, it'll be reflected in the `UI`. Or in other words, `UI` keeps a subset of the data in `Brain` so that it can put everything the user needs on the screen. `Brain` and `UI` will communicate through ports that send and receive `Json.Encode.Value`s.



## TODO

- Write Haskell tool for Elm doc tests
