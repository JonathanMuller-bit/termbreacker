# termbreacker

Função principal - Ajudar pessoas com palavras que sigam determinados padrões do term.ooo. Funciona tanto para palavras em português quanto inglês.

Como utilizar:

Chamar a função index passando quatro parametros:
* array - Pode ser o array_pt ou array_en, conforme o idioma do termo ser descoberto
* not_included - String com todas as letras que não estão presentes no termo
* knowed_letters_without_position - Hash com a posição e a letra das letras descobertas mas na posição errada (amarelas)
* knowed_letters_with_position - Hash com a posição e a letra das letras descobertas e na posição correta (verdes)

############### TESTS ######################
#example engligh

# letters_wrong_position = {}
# letters_wrong_position[:"2"] = 'n'
# letters_wrong_position[:"0"] = 'y'
# letters_wrong_position[:"3"] = 'n'

# letters_right_position = {}

# wrong_letters = 'tearsfidsoug'

# puts index(array_en, wrong_letters,letters_wrong_position,letters_right_position )


#example portuguese
# letters_wrong_position = {}
# letters_wrong_position[:"0"] = 'a'

# letters_right_position = {}
# letters_right_position[:"3"] = 'i'
# letters_right_position[:"1"] = 'a'
# letters_right_position[:"0"] = 'l'

# wrong_letters = 'udonrzbc'

# puts index(array_pt, wrong_letters,letters_wrong_position, letters_right_position )

Para executar o script basta abrir a pasta do arquivo no terminal e executar 
ruby termbreacker.rb 
Com isso deverá ser retornado no terminal as palavras que respeitam o padrão informado. 
PS: Necessário ter instalado o ruby.
