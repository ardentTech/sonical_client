module Main exposing (main)

import Html exposing (Html)

import Commands exposing (getDrivers)
import Messages exposing (Msg(..))
import Models exposing (Driver, Model, defaultModel)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import Views exposing (view)


type alias Flags = { apiUrl: String }


init : Flags -> ( Model, Cmd Msg )
init flags =
  let
    model = { defaultModel | apiUrl = flags.apiUrl }
  in
    (model, Cmd.batch [ getDrivers model ])


main : Program Flags Model Msg
main = Html.programWithFlags {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions }
