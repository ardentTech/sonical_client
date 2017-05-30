module Views.Loading exposing (loading)

import Html exposing (Html, div, h3, text)


loading : Html a
loading = div [] [ h3 [] [ text "Loading..." ]]
