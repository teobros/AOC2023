lines = readlines("input.txt")

function lines_to_ascii(lines)
    nrows = size(lines,1)
    ncols = length(lines[1])

    engine_ascii = zeros(Int,nrows,ncols)

    for irow in range(1,ncols)
        ascii = [Int(c) for c in lines[irow]]
        engine_ascii[irow,:] = ascii
    end
    
    return engine_ascii
end

engine_ascii = lines_to_ascii(lines)

function validate_engine(engine_ascii)
    nrows, ncols = size(engine_ascii)
    # put all dots around the engine matrix
    engine_ascii = hcat(46*ones(nrows,1),engine_ascii,46*ones(nrows,1))
    engine_ascii = vcat(46*ones(1,ncols+2),engine_ascii,46*ones(1,ncols+2))
    digit = 0
    answer = 0.0
    number = 0.0
    for irow in range(1,nrows), icol in range(ncols,step=-1,stop=0)
        if engine_ascii[irow+1,icol+1]>47 && engine_ascii[irow+1,icol+1]<58 # if I read a digit
            # count the digits in the number
            digit += 1
        else 
            # check if the number was valid
            if digit>0
                # check if there is a symbol that is not a dot around the number
                box = vcat(engine_ascii[irow,icol+1:icol+digit+2], [engine_ascii[irow+1,icol+1]],
                            [engine_ascii[irow+1,icol+digit+2]], engine_ascii[irow+2,icol+1:icol+digit+2])
                if ~all(box.==46)
                    answer += number
                end
            end
            digit = 0
        end
        if digit >0
            # get the number up to the counted digits
            number = sum((engine_ascii[irow+1,icol+1:icol+digit].-48) .* 10 .^ (digit-1:-1:0))             
        end
    end
    return answer
end

answer1 = validate_engine(engine_ascii)
answer1