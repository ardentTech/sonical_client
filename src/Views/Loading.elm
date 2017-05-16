module Views.Loading exposing (loading)

import Html exposing (Html, div, h3, text)

import Messages exposing (Msg)


loading : Html Msg
loading = div [] [ h3 [] [ text "Loading..." ]]
