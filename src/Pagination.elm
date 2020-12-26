module Pagination exposing (State, init, view)

import Html exposing (Html, button, div, input, span, text)
import Html.Attributes
import Html.Events exposing (onClick)


type State
    = State InternalState


type alias InternalState =
    { current : Int
    , total : Int
    }


init : InternalState -> State
init internal =
    State
        { current = internal.current
        , total = internal.total
        }


type Msg
    = Prev
    | Next


update : Msg -> State
update msg =
    case msg of
        Prev ->
            State { current = 0, total = 10 }

        Next ->
            State { current = 2, total = 10 }



--        (State -> msg)
-- onClick : msg -> Attribute msg
-- onInput : (String -> msg) -> Attribute msg


view : (State -> msg) -> Html msg
view toMsg =
    div []
        [ button [ onClick <| toMsg (update Prev) ] [ text "<" ]
        , span [] [ text " " ]
        , input [] []
        , span [] [ text " / 10" ] -- total pages
        , span [] [ text " " ]
        , button [ onClick <| toMsg (update Next) ] [ text ">" ]
        ]
