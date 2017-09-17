#encoding utf-8

Quando(/^faço a soma de (\d+) \+ (\d+)$/) do |valor_1, valor_2|                    
  @result = valor_1.to_i + valor_2.to_i
end                                                                          
                                                                             
Então(/^o resultado deve ser (\d+)$/) do |total|                              
  expect(@result).to eql total.to_i
end                                           