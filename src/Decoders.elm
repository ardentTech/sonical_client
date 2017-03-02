module Decoders exposing (driverDecoder, driversDecoder)

import Json.Decode exposing (Decoder, at, int, list, nullable, string)
import Json.Decode.Pipeline exposing (decode, required, requiredAt)

import Models exposing (Driver, Manufacturer)


driverDecoder : Decoder Driver
driverDecoder = decode Driver
  |> required "id" int
  |> requiredAt [ "manufacturer" ] manufacturerDecoder
  |> required "model" string
  |> required "nominal_impedance" (nullable int)


driversDecoder : Decoder (List Driver)
driversDecoder =
  at ["results"] (list driverDecoder)


manufacturerDecoder : Decoder Manufacturer
manufacturerDecoder = decode Manufacturer
  |> required "name" string
  |> required "website" (nullable string)
