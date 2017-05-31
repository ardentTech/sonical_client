module Manufacturing.Update exposing (..)

import Manufacturing.Messages exposing (InternalMsg (..))
import Models exposing (Model)
import Rest exposing (httpErrorString)


update : InternalMsg -> Model -> (Model, Cmd InternalMsg)
update msg model =
  case msg of
    GetManufacturersDone (Ok response) ->
      ({ model | manufacturers = response.results }, Cmd.none )
    GetManufacturersDone (Err error) ->
      ({ model | error = httpErrorString error }, Cmd.none )
