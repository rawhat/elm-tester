module Main exposing (..)

import Html exposing (div, h2, button, input, text)
import Html.Attributes exposing (..)


main =
    div []
        [ h2 [] [ text "Hello, world!" ]
        , input [ type' "text", placeholder "Textual healing" ] []
        , button [] [ text "Clickey" ]
        ]
