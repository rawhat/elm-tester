module Main exposing (..)

import Html exposing (div, h2, button, input, text, span)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App
import String


-- model


type alias TodoList =
    { todos : List Todo
    , todo : String
    }


type alias Todo =
    { id : Int
    , content : String
    , completed : Bool
    }


initModel : TodoList
initModel =
    { todos = []
    , todo = ""
    }



-- update


type Msg
    = Add
    | Input String
    | Remove Todo
    | Toggle Todo


update : Msg -> TodoList -> TodoList
update msg model =
    case msg of
        Input string ->
            { model | todo = string }

        Add ->
            let
                newTodo =
                    Todo (List.length model.todos + 1) model.todo False

                newTodos =
                    if String.isEmpty model.todo then
                        model.todos
                    else
                        List.append model.todos [ newTodo ]
            in
                { model | todos = newTodos, todo = "" }

        Remove todo ->
            { model
                | todos =
                    List.filter
                        (\todoItem ->
                            todoItem.id /= todo.id
                        )
                        model.todos
            }

        _ ->
            model



-- view


view : TodoList -> Html.Html Msg
view model =
    div []
        [ h2 [] [ text "Todo List" ]
        , input [ type' "text", value model.todo, onInput Input ] []
        , button [ onClick Add ] [ text "Add Todo" ]
        , div []
            (List.map
                (\todo ->
                    div []
                        [ span [ onClick (Remove todo), style [ ( "margin-right", "10px" ) ] ] [ text "X" ]
                        , text todo.content
                        ]
                )
                model.todos
            )
        ]


main : Program Never
main =
    App.beginnerProgram
        { model = initModel
        , view = view
        , update = update
        }
