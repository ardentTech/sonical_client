module Manufacturing.Update exposing (..)

import Manufacturing.Messages exposing (Msg (..))
import Models exposing (Model)
import Rest exposing (httpErrorString)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GetManufacturersDone (Ok response) ->
      ({ model | manufacturers = response.results }, Cmd.none )
    GetManufacturersDone (Err error) ->
      ({ model | error = httpErrorString error }, Cmd.none )
