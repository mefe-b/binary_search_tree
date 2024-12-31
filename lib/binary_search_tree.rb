class Node
  attr_accessor :data, :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    @data <=> other.data
  end
end

class Tree
  attr_accessor :root

  def initialize(root = nil)
    @root = root
  end

  def build_tree(array)
    unique_array = array.uniq
    sorted_array = unique_array.sort
    sorted_array.each { |value| insert(value) }
  end

  def insert(value)
    if @root.nil?
      @root = Node.new(value)
    else
      insert_node(@root, value)
    end
  end

  def insert_node(node, value)
    if value < node.data
      node.left.nil? ? (node.left = Node.new(value)) : insert_node(node.left, value)
    else
      node.right.nil? ? (node.right = Node.new(value)) : insert_node(node.right, value)
    end
  end

  def delete(value, node = @root)
    return nil if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      if node.left.nil? && node.right.nil?
        return nil
      elsif node.left.nil?
        return node.right
      elsif node.right.nil?
        return node.left
      else
        min_larger_node = node.right.nil? ? node : find_min(node.right)
        node.data = min_larger_node.data
        node.right = delete(min_larger_node.data, node.right)
      end
    end
    node
  end

  def find_min(node)
    current = node
    current = current.left while current.left
    current
  end
  
  def level_order(&block)
    return unless @root
    
    queue = [@root]
    while queue.any?
      current = queue.shift
      next unless current.is_a?(Node)
      
      block_given? ? yield(current.data) : (puts current.data)
      queue.push(current.left) if current.left
      queue.push(current.right) if current.right
    end
  end  

  def inorder(node = @root, &block)
    return unless node
  
    inorder(node.left, &block)
    block_given? ? yield(node.data) : (puts node.data)
    inorder(node.right, &block)
  end

  def preorder(node = @root, &block)
    return unless node
  
    block_given? ? yield(node.data) : (puts node.data)
    preorder(node.left, &block)
    preorder(node.right, &block)
  end

  def postorder(node = @root, &block)
    return unless node
  
    postorder(node.left, &block)
    postorder(node.right, &block)
    block_given? ? yield(node.data) : (puts node.data)
  end  

  def height(node = @root)
    return 0 if node.nil?
    left_height = height(node.left)
    right_height = height(node.right)
    [left_height, right_height].max + 1
  end  

  def depth(node, current = @root, depth = 0)
    return 0 if current.nil?
    return depth if current == node
  
    if node.data < current.data
      depth(node, current.left, depth + 1)
    else
      depth(node, current.right, depth + 1)
    end
  end

  def balanced?(node = @root)
    return true if node.nil?
    
    left_height = height(node.left)
    right_height = height(node.right)
    
    (balanced?(node.left) && balanced?(node.right)) && (left_height - right_height).abs <= 1
  end  

  def rebalance
    elements = []
    inorder { |data| elements << data }
    @root = build_tree(elements)
  end  

  def find(value, node = @root)
    return nil if node.nil?
    return node if node.data == value

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end
end
