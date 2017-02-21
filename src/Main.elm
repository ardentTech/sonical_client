module Main exposing (main)

import Html exposing (Html, div, text)


type alias Driver = { model : String }
type alias Model = { drivers: List Driver }
type Msg = NoOp


init : ( Model, Cmd Msg )
init = ( { drivers = [] }, Cmd.none )


view : Model -> Html Msg
view model = div [] [ text "Howdy!" ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
      NoOp ->
        ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model = Sub.none


main : Program Never Model Msg
main = Html.program {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions }
