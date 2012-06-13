#Parag Patel
#4/10/2012

beginning_time = Time.now

#location of where our file is held and the name of our file
Directory_file = "Documents/word.list.txt"

#this hash will hold our word files
$dictionary = {}

#our total network count
$social_network_count = 1

#this hash will hold our social network and we can print it out or do other functions to it.
#social_network_tree[parent] = child

#$social_network_tree = {}

#flat social network
#$friends = {}

#need to read file, strip the each word of new line characters and store them
#in our hash.

#We set the keys of our hash to be the words in our file and pick some random
#don't care value to set each of them to, like 1.  All we care about is being
#able to search our hash by comparing the value to nil.

File.open(Directory_file) do |file|
   while line = file.gets
      $dictionary[line.strip!] = 1
   end
end

#This method builds our social network. It creates 3 variations of the parent word
#by adding, subtituting, or deleting letters in the parent word.  It checks the
#derived values against the dictionary keys.  If a match occurs, then the child word
#is added to the social network

def permutate(parents)
count = 0
 while (parents.size > 0)
   all_children = []  
   for parent in parents 
       # children = []
        for i in 0.upto(parent.size - 1)
         additional_character = "a"
         for x in 0..25
       	     child_addition  = parent[0,i] + additional_character + parent[i,parent.size - i]
             child_substitution = parent[0,i] + additional_character + parent[i + 1, parent.size - i - 1]
             if !($dictionary[child_addition].nil?)
               all_children << child_addition
                $dictionary.delete(child_addition)
                $social_network_count += 1
             elsif !($dictionary[child_substitution].nil?)
               all_children << child_substitution
                $dictionary.delete(child_substitution)
                $social_network_count += 1
             end
              
             additional_character = additional_character.next
         
         end
   
         child_deletion = parent[0,i] + parent[i + 1, parent.size - i - 1]
  
         if !($dictionary[child_deletion].nil?)
            all_children << child_deletion
            $dictionary.delete(child_deletion)
             $social_network_count += 1
         end
              
       end
      
       additional_character = "a"

       for x in 0..25
       child_addition_at_end = parent + additional_character

       if !($dictionary[child_addition_at_end].nil?)
           all_children << child_addition_at_end
            $dictionary.delete(child_addition_at_end)
            $social_network_count += 1
         end

       additional_character = additional_character.next

       end


       # if (children.size > 0)
           # $social_network_tree[parent] = children
        #    all_children = all_children + children
       # end
 
    end 

 # puts "Social Network Tree up to level level #{count.to_s} is " +  $friends.to_s
# puts "social network count is #{$social_network_count.to_s} up to level #{count.to_s}"
  
  parents = all_children
  count += 1
end

end

starting_string = "causes"
# $friends[starting_string] = 1
$dictionary.delete(starting_string)
permutate([] << starting_string)
puts "Size of the total social network of #{starting_string} is #{$social_network_count.to_s}"
end_time = Time.now
puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"

