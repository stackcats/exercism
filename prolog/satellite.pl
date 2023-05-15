tree_traversals(Tree, Preorder, Inorder) :-
    phrase(preorder(Tree), Preorder),
    phrase(inorder(Tree), Inorder).


inorder(nil) --> [].
inorder(node(Left, Value, Right)) -->
    inorder(Left),
    [Value],
    inorder(Right).

preorder(nil) --> [].
preorder(node(Left, Value, Right)) -->
    [Value],
    preorder(Left),
    preorder(Right).
