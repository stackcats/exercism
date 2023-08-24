module Sublist exposing (ListComparison(..), sublist)


type ListComparison
    = Equal
    | Superlist
    | Sublist
    | Unequal


isSublist : List a -> List a -> Bool
isSublist alist blist =
    let
        alen =
            List.length alist
    in
    if alen == 0 || alen > List.length blist then
        False

    else if List.take alen blist == alist then
        True

    else
        isSublist alist (List.drop 1 blist)


sublist : List a -> List a -> ListComparison
sublist alist blist =
    if alist == blist then
        Equal

    else if alist == [] then
        Sublist

    else if blist == [] then
        Superlist

    else if isSublist alist blist then
        Sublist

    else if isSublist blist alist then
        Superlist

    else
        Unequal
