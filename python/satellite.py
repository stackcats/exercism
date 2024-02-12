def tree_from_traversals(preorder, inorder):
    if len(preorder) != len(inorder):
        raise ValueError("traversals must have the same length")

    root = {}
    if preorder == []:
        return root

    root["v"] = preorder[0]
    preorder = preorder[1:]

    if root["v"] in preorder:
        raise ValueError("traversals must contain unique items")

    try:
        i = inorder.index(root["v"])
    except:
        raise ValueError("traversals must have the same elements")

    root["l"] = tree_from_traversals(preorder[:i], inorder[:i])
    root["r"] = tree_from_traversals(preorder[i:], inorder[i + 1 :])

    return root
