module Manufacturers.Decoders exposing (manufacturerDecoder, manufacturersDecoder)

import Json.Decode exposing (Decoder, int, list, string)
import Json.Decode.Pipeline exposing (decode, required)

import Models exposing (Manufacturer)


manufacturerDecoder : Decoder Manufacturer
manufacturerDecoder = decode Manufacturer
  |> required "id" int
  |> required "name" string
  |> required "website" string


manufacturersDecoder : Decoder (List Manufacturer)
manufacturersDecoder =
  list manufacturerDecoder
