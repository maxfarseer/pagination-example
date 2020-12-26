module Main exposing (..)

import Browser
import Html exposing (Html, button, div, h1, img, text)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
import Pagination



---- MODEL ----


type alias Model =
    { counter : Int
    , pagination : Pagination.State
    }


init : ( Model, Cmd Msg )
init =
    let
        paginationState =
            Pagination.init { current = 1, total = 100 }
    in
    ( { counter = 0
      , pagination = paginationState
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = ClickedBtn
    | ChangedPagination Pagination.State


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedBtn ->
            ( model, Cmd.none )

        ChangedPagination state ->
            let
                _ =
                    Debug.log "New pagination state" state
            in
            ( { model | pagination = state }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Pagination example" ]
        , button [ onClick ClickedBtn ] [ text "Click me" ]
        , Pagination.view ChangedPagination model.pagination
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
