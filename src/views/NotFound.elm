module Views.NotFound exposing (notFound)

import Html exposing (Html, div, h3, text)
import Messages exposing (Msg (..))


notFound : Html Msg
notFound =
  div [] [ h3 [] [ text "404 Not Found" ]]
