def getChildren(node):
    childList = []
    for n in node.children():
        childList.append(n)
        if n.children():
            childList+=getChildren(n)
    return childList
