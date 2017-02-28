module Decoders exposing (driverDecoder, driversDecoder)

import Json.Decode exposing (Decoder, at, list, string)
import Json.Decode.Pipeline exposing (decode, required)

import Models exposing (Driver)


driverDecoder : Decoder Driver
driverDecoder = decode Driver
  |> required "model" string


driversDecoder : Decoder (List Driver)
driversDecoder =
  at ["results"] (list driverDecoder)
