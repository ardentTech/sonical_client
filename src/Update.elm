module Update exposing (update)

import Messages exposing (Msg(..))
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
      Fail _ ->
        ( model, Cmd.none )
      FetchDriversDone (Ok drivers) ->
        ({ model | drivers = drivers }, Cmd.none )
      FetchDriversDone (Err _) ->
        ( model, Cmd.none )
      NoOp ->
        ( model, Cmd.none )
