require 'httparty'

def get_words(url)
    response = HTTParty.get(url)
    response.body if response.code == 200
    response.split(' ')
end

array_pt = get_words('https://www.ime.usp.br/~pf/dicios/br-utf8.txt')

array_en = get_words('https://raw.githubusercontent.com/dwyl/english-words/master/words.txt')

def remove_accents(str)
    accents = {
        ['á','à','â','ä','ã'] => 'a',
        ['Ã','Ä','Â','À'] => 'A',
        ['é','è','ê','ë'] => 'e',
        ['Ë','É','È','Ê'] => 'E',
        ['í','ì','î','ï'] => 'i',
        ['Î','Ì'] => 'I',
        ['ó','ò','ô','ö','õ'] => 'o',
        ['Õ','Ö','Ô','Ò','Ó'] => 'O',
        ['ú','ù','û','ü'] => 'u',
        ['Ú','Û','Ù','Ü'] => 'U',
        ['ç'] => 'c', ['Ç'] => 'C',
        ['ñ'] => 'n', ['Ñ'] => 'N'
    }
    accents.each do |ac,rep|
        ac.each do |s|
        str = str.gsub(s, rep)
        end
    end
    str = str.gsub(/[^a-zA-Z0-9\. ]/,"")
    str = str.gsub(/[ ]+/," ")
    str = str.gsub(/ /,"-")
    str = str.gsub(/[,()'".]+\z/,'')
    str = str.gsub(/[,()'".]+\z/,'')
    str = str.gsub(/␣/,'')

    str = str.downcase
end

def select_words array
    selected_words = array.select{|item| item.length == 5}
    selected_words.map!{|word| remove_accents(word)}.select{|item| item.length == 5}
    selected_words.uniq
end

def not_include_words letters
    letters.split('')
end

def filter_words(selected_words, not_include_letters, kwoned_letters_without_position, knowed_letters)
    match = 0
    match2 = 0
    result  = []
    

    selected_words.select do |word|
        arr_word = word.split('')
        if ((arr_word & knowed_letters.values).any? || knowed_letters.values.size == 0) && 
            !(arr_word & not_include_letters).any? && 
            ((arr_word & kwoned_letters_without_position.values).any? || kwoned_letters_without_position.values.size == 0)
                
            
                knowed_letters.each do |k,v|
                    match +=1 if arr_word[k.to_s.to_i] == v 
                end 

                kwoned_letters_without_position.each do |key, value|
                    match2 += 1 if arr_word[key.to_s.to_i] != value && arr_word.include?(value)
                end 

                result << word if match == knowed_letters.size && match2 == kwoned_letters_without_position.size
                match = 0
                match2 = 0
        end
    end
    result.size > 0 ? result : 'No Matchs' 
end




def index(array, not_included, kwoned_letters, knowed_letters_position)
    selected_words = select_words(array)
    not_include_letters = not_include_words(not_included)
    filtered_words = filter_words(selected_words, not_include_letters,kwoned_letters, knowed_letters_position)

end



############### TESTS ######################
#example engligh

# letters_wrong_position = {}
# letters_wrong_position[:"2"] = 'n'
# letters_wrong_position[:"0"] = 'y'
# letters_wrong_position[:"3"] = 'n'

# letters_right_position = {}

# wrong_letters = 'tearsfidsoug'

# puts index(array_en, wrong_letters,letters_wrong_position,letters_right_position )


# example portuguese
# letters_wrong_position = {}
# letters_wrong_position[:"0"] = 'a'
# letters_wrong_position[:"4"] = 'l'

# letters_right_position = {}
# letters_right_position[:"3"] = 'i'
# letters_right_position[:"1"] = 'a'
# letters_right_position[:"0"] = 'l'


# wrong_letters = 'udobnrfcps'

# puts index(array_pt, wrong_letters,letters_wrong_position, letters_right_position )



