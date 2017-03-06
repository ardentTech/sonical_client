module Update exposing (update)

import Messages exposing (Msg(..))
import Models exposing (Model)
import TypeConverters exposing (maybeStringToString)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
      Fail _ ->
        ( model, Cmd.none )
      FetchDriversDone (Ok response) ->
        ({ model |
          drivers = response.results,
          driversCount = response.count,
          -- @todo do not convert maybe to empty string
          driversNextPage = maybeStringToString response.next,
          driversPreviousPage = maybeStringToString response.previous
        }, Cmd.none )
      FetchDriversDone (Err _) ->
        ( model, Cmd.none )
      NoOp ->
        ( model, Cmd.none )
