module Manufacturing.Commands exposing (getManufacturers)

import Api exposing (manufacturersUrl)
import Manufacturing.Decoders exposing (manufacturersDecoder)
import Manufacturing.Messages exposing (Msg (..))
import Models exposing (Model)
import Rest exposing (getList)


getManufacturers : Model -> Cmd Msg
getManufacturers model =
  let
    url = (manufacturersUrl model.apiUrl) ++ "?limit=100"
  in
    getList url manufacturersDecoder GetManufacturersDone
