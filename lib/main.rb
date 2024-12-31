
# Test kodları
tree = Tree.new

# Ağaç yapısını kur
tree.build_tree([10, 5, 20, 3, 7, 15, 25])

# Düğüm değerlerini basarak level order geçiş
puts "Level Order Traversal:"
tree.level_order do |value|
  puts "Node value: #{value}"
end

puts "\nInorder Traversal:"
tree.inorder do |value|
  puts "Node value: #{value}"
end

puts "\nPreorder Traversal:"
tree.preorder do |value|
  puts "Node value: #{value}"
end

puts "\nPostorder Traversal:"
tree.postorder do |value|
  puts "Node value: #{value}"
end

# Ağaç yüksekliğini kontrol et
puts "\nHeight of the tree: #{tree.height}"

# Ağaç dengeli mi kontrol et
puts "Is the tree balanced? #{tree.balanced?}"

# Rebalance işlemi
tree.rebalance
puts "\nAfter rebalancing:"
tree.level_order do |value|
  puts "Node value: #{value}"
end