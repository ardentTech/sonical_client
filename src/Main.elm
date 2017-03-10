module Main exposing (main)

import Html exposing (Html)

import Commands exposing (getDrivers)
import Messages exposing (Msg(..))
import Models exposing (Driver, Model, defaultModel)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import Views exposing (view)


-- Main.elm

init : ( Model, Cmd Msg )
init = ( defaultModel, getDrivers Nothing )


main : Program Never Model Msg
main = Html.program {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions }
