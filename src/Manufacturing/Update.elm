module Manufacturing.Update exposing (..)

import Http exposing (Error (..))

import Manufacturing.Messages exposing (Msg (..))
import Models exposing (Model)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GetManufacturersDone (Ok response) ->
      ({ model | manufacturers = response.results }, Cmd.none )
    GetManufacturersDone (Err error) ->
      ({ model | error = httpErrorString error }, Cmd.none )


-- PRIVATE


httpErrorString : Error -> String
httpErrorString error =
  case error of
    BadUrl text ->
      "Bad Url: " ++ text
    Timeout ->
      "Http Timeout"
    NetworkError ->
      "Network Error"
    BadStatus response ->
      "Bad HTTP Status: " ++ toString response.status.code
    BadPayload message response ->
      "Bad HTTP Payload: " ++ toString message ++ " (" ++
      toString response.status.code ++ ")"
