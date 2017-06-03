module Main exposing (main)

import Navigation exposing (programWithFlags)

import Init exposing (Flags, init)
import Messages exposing (Msg(..))
import Models exposing (Model)
import Subscriptions exposing (subscriptions)
import Update exposing (update)
import Views.App exposing (view)


main : Program Flags Model Msg
main = programWithFlags UrlChange {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions }
