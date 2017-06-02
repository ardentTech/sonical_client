module Manufacturing.Commands exposing (..)

import Api exposing (manufacturersUrl)
import Manufacturing.Decoders exposing (manufacturersDecoder)
import Manufacturing.Messages exposing (..)
import Models exposing (Model)
import Rest exposing (getList)


manufacturingRouteToCmd : Model -> Cmd Msg
manufacturingRouteToCmd model =
  getManufacturers model


-- PRIVATE


getManufacturers : Model -> Cmd Msg
getManufacturers model =
  let
    url = (manufacturersUrl model.apiUrl) ++ "?limit=100"
  in
    Cmd.map ForSelf (getList url manufacturersDecoder GetManufacturersDone)
