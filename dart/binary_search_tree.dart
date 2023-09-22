class Node {
  String data;
  Node? left;
  Node? right;
  Node(this.data);
}

class BinarySearchTree {
  Node root;

  BinarySearchTree(String data) : root = Node(data);

  void insert(String data) {
    root = _insert(data, root);
  }

  static Node _insert(String data, Node? node) {
    if (node == null) {
      return Node(data);
    }

    if (data.compareTo(node.data) <= 0) {
      node.left = _insert(data, node.left);
    } else {
      node.right = _insert(data, node.right);
    }
    return node;
  }

  List<String> get sortedData {
    List<String> arr = [];
    List<Node> st = [];
    Node? curr = root;
    while (true) {
      if (curr != null) {
        st.add(curr);
        curr = curr.left;
      } else {
        if (st.isEmpty) {
          break;
        }
        curr = st.removeLast();
        arr.add(curr.data);
        curr = curr.right;
      }
    }
    return arr;
  }
}
