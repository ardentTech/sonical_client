module Main exposing (main)

import Html exposing (Html, div, text)
import Http
import Json.Decode exposing (Decoder, at, list, string)
import Json.Decode.Pipeline exposing (decode, required)


type alias Driver = { model : String }
type alias Model = { drivers: List Driver }
type Msg = Fail Http.Error | FetchDriversDone (Result Http.Error (List Driver)) | NoOp


-- View.elm

view : Model -> Html Msg
view model = div [] [ text "Howdy!" ]


-- Update.elm

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
      Fail _ ->
        ( model, Cmd.none )
      FetchDriversDone (Ok drivers) ->
        ({ model | drivers = drivers }, Cmd.none )
      FetchDriversDone (Err _) ->
        ( model, Cmd.none )
      NoOp ->
        ( model, Cmd.none )


-- Subscriptions.elm

subscriptions : Model -> Sub Msg
subscriptions model = Sub.none


-- Decoders.elm

driverDecoder : Decoder Driver
driverDecoder = decode Driver
  |> required "model" string


driversDecoder : Decoder (List Driver)
driversDecoder =
  at ["results"] (list driverDecoder)


-- Commands.elm

fetchDrivers : Cmd Msg
fetchDrivers =
  Http.send FetchDriversDone <| Http.get "http://localhost:8001/v1/drivers/" driversDecoder


-- Main.elm

init : ( Model, Cmd Msg )
init = ( { drivers = [] }, fetchDrivers )


main : Program Never Model Msg
main = Html.program {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions }
