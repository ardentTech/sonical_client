module Update exposing (update)

import Messages exposing (Msg(..))
import Models exposing (Model)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
      Fail _ ->
        ( model, Cmd.none )
      FetchDriversDone (Ok response) ->
        ({ model |
          drivers = response.results,
          driversCount = response.count,
          driversNextPage = (justString <| response.next),
          driversPreviousPage = (justString <| response.previous)
        }, Cmd.none )
      FetchDriversDone (Err _) ->
        ( model, Cmd.none )
      NoOp ->
        ( model, Cmd.none )


-- PRIVATE

justString : Maybe String -> String
justString s =
  case s of
    Nothing -> ""
    Just m -> m
