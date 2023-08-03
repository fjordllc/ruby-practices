scores = ARGV[0].split(',').to_a

total_score = 0
index = 0
frame = 1

while frame < 11 do
    if scores[index] == "X"
        total_score += 10 
        if scores[index+1] == "X"
            total_score+=10
        else
            total_score += scores[index+1].to_i
        end

        if scores[index+2] == "X"
            total_score+=10
        else
            total_score += scores[index+2].to_i
        end

        index+=1
        frame+=1
    else
        temp = scores[index].to_i + scores[index+1].to_i
        if temp < 10
            total_score+= temp
        else
            if scores[index+2] == "X"
                total_score+= (temp+10)
            else
                total_score+= (temp+ scores[index+2].to_i)
            end
        end
        index+=2
        frame+=1
    end
end

puts total_score