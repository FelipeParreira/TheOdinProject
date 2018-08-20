class LinkedList

  def initialize(value = nil, next_node = nil)
    @head = Node.new(value, next_node)
  end

  # adds a new node to the start of the list
  def prepend(value = nil)
    node = @head
    @head = Node.new(value, node)
  end

  # adds a new node to the end of the list
  def append(value = nil, next_node = nil)

    if (@head.nil?)
      prepend(value)
    else
      node = @head
      while (node.has_next)
        node = node.next_node
      end
      node.next_node = Node.new(value, next_node)
    end

  end

  # returns the total number of nodes in the list
  def size
    i = 0
    node = @head
    while !(node.nil?)
      i += 1
      node = node.next_node
    end
    return i
  end

  # returns the first node in the list
  def head
    return @head
  end

  # returns the last node in the list
  def tail
    node = @head
    while (node.has_next)
      node = node.next_node
    end
    return node
  end

  #  returns the node at the given index
  def at(index)
    i = 0
    node = @head
    while i < index
      i += 1
      node = node.next_node
    end
    return node
  end

  # removes the last element from the list
  def pop
    last_node = self.tail
    self.at(self.size - 2).next_node = nil
    return last_node
  end

  # returns true if the passed in value is in the list and otherwise returns false
  def contains?(val)
    node = @head
    while !(node.nil?)
      return true if node.value == val
      node = node.next_node
    end
    return false
  end

  # returns the index of the node containing data, or nil if not found
  def find(data)
    i = 0
    node = @head
    while !(node.nil?)
      return i if node.value == data
      node = node.next_node
      i += 1
    end
    return nil
  end

  # inserts the node with the given value at the given index
  def insert_at(value, index)
    prev = self.at(index - 1)
    next_node = prev.next_node
    prev.next_node = Node.new(value, next_node)
  end

  # removes the node at the given index
  def remove_at(index)
    self.at(index - 1).next_node = self.at(index + 1)
    self.at(index).next_node = nil
  end

  # represent your LinkedList objects as strings, in order to print it out in the console
  def to_s
    print "head -> "
    node = @head
    while !(node.nil?)
      print "( #{node.value} ) -> "
      node = node.next_node
    end
    print " nil\n"
  end

end

class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end

  # checks if node has a next node attached to it
  def has_next
    return !(self.next_node.nil?)
  end

end

# some test to see that the classes and methods do indeed work
list1 = LinkedList.new(12)
list1.append(11)
list1.append(10)
list1.append(9)
list1.append(8)
list1.prepend(13)
puts list1.to_s
puts list1.size
puts list1.head.value
puts list1.tail.value
puts list1.at(2).value
puts list1.pop.value
puts list1.to_s
puts list1.contains?(11)
puts list1.contains?(90)
puts list1.find(11)
puts list1.find(90).nil?
list1.insert_at(10.5, 3)
puts list1.to_s
list1.remove_at(3)
puts list1.to_s
