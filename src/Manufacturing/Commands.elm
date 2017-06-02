module Manufacturing.Commands exposing (..)

import Api exposing (manufacturersUrl)
import Manufacturing.Decoders exposing (manufacturersDecoder)
import Manufacturing.Messages exposing (..)
import Models exposing (Model)
import Rest exposing (getList)
import Router exposing (Route (ManufacturerList))


manufacturingRouteToCmd : Route -> Cmd Msg
manufacturingRouteToCmd route =
  Cmd.none


-- PRIVATE


--getManufacturers : Model -> Cmd Msg
--getManufacturers model =
--  let
--    url = (manufacturersUrl model.apiUrl) ++ "?limit=100"
--  in
--    getList url manufacturersDecoder (ForSelf GetManufacturersDone)
