module Picshare exposing (main)

import Html exposing (..)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)


baseUrl : String
baseUrl =
    "https://programming-elm.com/"


initialModel : { url : String, caption : String, liked : Bool }
initialModel =
    { url = baseUrl ++ "1.jpg"
    , caption = "Surfing"
    , liked = False
    }


view : { url : String, caption : String, liked : Bool } -> Html msg
view model =
    div []
        [ div [ class "header" ]
            [ h1 [] [ text "Picshare" ] ]
        , div [ class "content-flow" ]
            [ viewDetailedPhoto model ]
        ]


viewDetailedPhoto : { url : String, caption : String, liked : Bool } -> Html msg
viewDetailedPhoto { url, caption, liked } =
    let
        buttonClass =
            if liked then
                "fa-heart"

            else
                "fa-heart-o"

        msg =
            if liked then
                Unlike

            else
                Like
    in
    div [ class "detailed-photo" ]
        [ img [ src url ] []
        , div [ class "photo-info" ]
            [ div [ class "photo-info" ]
                [ div [ class "like-button" ]
                    [ i
                        [ class "fa fa-2x"
                        , class buttonClass
                        , onClick msg
                        ]
                        []
                    ]
                ]
            ]
        , h2 [ class "caption" ] [ text caption ]
        ]


main : Html msg
main =
    view initialModel
