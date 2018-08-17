# merges two sorted arrays, resulting in a merged sorted array
def merge(arr1, arr2)
  total_length = arr1.length + arr2.length
  new_arr = []
  for i in 1..total_length
    new_element = arr1[0].nil? ? arr2.shift : (arr2[0].nil? ? arr1.shift : (arr1[0] < arr2[0] ? arr1.shift : arr2.shift))
    new_arr.push(new_element)
  end
  return new_arr
end

p merge([1, 2, 5], [3, 4, 6])
p merge([-90, 13, 67], [0, 4, 90])
p merge([0, 2, 7], [-90, 9, 10])


# sorts an array using the merge sort algorithm
def merge_sort(arr1)
  len = arr1.length
  if len > 1
    arr2, arr3 = merge_sort(arr1[0...(len/2)]), merge_sort(arr1[(len/2)...len])
    merge(arr2, arr3)
  else
    return arr1
  end
end

p merge_sort([7, 2, 0, 9, -90, 10])
p merge_sort([-90, -91, 13, 0, 34, 56, 0, 8])
p merge_sort([100, 99, 98, 97, 101, 0, -89])
